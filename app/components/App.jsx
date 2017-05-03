import React from 'react';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      projects: [
        {
          name: 'ndn-cxx'
        },
        {
          name: 'NFD'
        },
        {
          name: 'ndn-tools'
        }
      ]
    };
  }

  render() {
    const projectRows = this.state.projects.map(proj =>
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
}

function ProjectRow(props) {
  return (
    <tr>
      <td>{props.name}</td>
      <td><input type="text" value={props.value} onChange={props.onChange}/></td>
    </tr>
  );
}
