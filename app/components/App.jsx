import React from 'react';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.updateSetting = this.updateSetting.bind(this);

    this.state = {
      projects: []
    };

    fetch('projects.json').then(resp => resp.json())
    .then(j => this.setState({projects: j}));
  }

  updateSetting(project, evt) {
    this.setState({ ['setting_' + project.name ]: evt.target.value });
  }

  render() {
    return (
      <ProjectsTable
        projects={this.state.projects}
        updateSetting={this.updateSetting}
      />
    );
  }
}

function ProjectsTable(props) {
  const projectRows = props.projects.map(proj =>
    <ProjectRow key={proj.name} project={proj} setting={props['setting_' + proj.name]} onChange={props.updateSetting}/>
  );

  return (
    <table>
      <thead>
        <tr><th>project</th><th>patchset</th></tr>
      </thead>
      <tbody>
        {projectRows}
      </tbody>
    </table>
  );
}

function ProjectRow(props) {
  const onChange = props.onChange.bind(null, props.project);

  return (
    <tr>
      <td>{props.project.name}</td>
      <td><input type="text" value={props.setting} onChange={onChange}/></td>
    </tr>
  );
}
