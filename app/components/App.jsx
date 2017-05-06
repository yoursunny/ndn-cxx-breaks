import React from 'react';
import ProjectsList from './ProjectsList';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.updatePatchset = this.updatePatchset.bind(this);
    this.updateEmail = this.updateEmail.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);

    this.state = {
      projects: [],
      isInProgress: false,
      patchsets: {},
      email: ''
    };
  }

  componentWillMount() {
    fetch('projects.json').then(resp => resp.json())
    .then(projects => {
      var patchsets = {};
      projects.forEach(p => patchsets[p.name] = 'master');
      this.setState({
        projects: projects,
        patchsets: patchsets
      });
    });
  }

  updatePatchset(project, patchset) {
    this.setState(prevState => ({
      patchsets: Object.assign(prevState.patchsets, {[project.name]: patchset})
    }));
  }

  updateEmail(evt) {
    this.setState({email: evt.target.value});
  }

  handleSubmit(evt) {
    evt.preventDefault();
    this.setState({isInProgress: true});
    fetch('submit-job.php', {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({
        patchsets: this.state.patchsets,
        email: this.state.email
      })
    })
    .then(resp => resp.json())
    .then(resp => {
      this.setState({isInProgress: false});
      console.log(resp);
    });
  }

  render() {
    return (
      <form className="container" onSubmit={this.handleSubmit}>
        <p>Please build projects using these revisions:</p>
        <ProjectsList
          projects={this.state.projects}
          patchsets={this.state.patchsets}
          updatePatchset={this.updatePatchset}
        />
        <p>Send result to
          <input type="email" placeholder="someone@example.com" value={this.state.email} onChange={this.updateEmail}/>,
          <input type="submit" className="primary" value="please" disabled={this.state.isInProgress}/>
        </p>
      </form>
    );
  }
}
