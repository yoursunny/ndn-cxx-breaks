import React from 'react';
import ProjectsTable from './ProjectsTable';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.updateSetting = this.updateSetting.bind(this);

    this.state = {
      projects: [],
      settings: {}
    };
  }

  componentWillMount() {
    var self = this;

    fetch('projects.json').then(resp => resp.json())
    .then(function(projects) {
      var settings = {};
      projects.forEach(p => settings[p.name] = '');
      self.setState({
        projects: projects,
        settings: settings
      });
    });
  }

  updateSetting(project, evt) {
    var newSetting = evt.target.value;
    this.setState(prevState => ({
      settings: Object.assign(prevState.settings, {[project.name]: newSetting})
    }));
  }

  render() {
    return (
      <ProjectsTable
        projects={this.state.projects}
        settings={this.state.settings}
        updateSetting={this.updateSetting}
      />
    );
  }
}
