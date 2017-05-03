import React from 'react';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      projects: []
    };

    fetch('projects.json').then(resp => resp.json())
    .then(j => this.setState({projects: j}));
  }

  render() {
    return <ProjectsTable projects={this.state.projects}/>
  }
}

function ProjectsTable(props) {
  const projectRows = props.projects.map(proj =>
    <ProjectRow key={proj.name} name={proj.name}/>
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
  return (
    <tr>
      <td>{props.name}</td>
      <td><input type="text" value={props.value} onChange={props.onChange}/></td>
    </tr>
  );
}
