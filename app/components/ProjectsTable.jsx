import React from 'react';
import ProjectRow from './ProjectRow';

export default function ProjectsTable(props) {
  const projectRows = props.projects.map(proj =>
    <ProjectRow key={proj.name} project={proj} patchset={props.patchsets[proj.name]} updatePatchset={props.updatePatchset}/>
  );

  return (
    <table>
      <thead>
        <tr>
          <th>project</th>
          <th>build</th>
          <th>master</th>
          <th>patchset</th>
          <th>info</th>
        </tr>
      </thead>
      <tbody>
        {projectRows}
      </tbody>
    </table>
  );
}
