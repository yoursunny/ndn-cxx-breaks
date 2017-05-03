import React from 'react';
import ProjectsTable from './ProjectsTable';

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
