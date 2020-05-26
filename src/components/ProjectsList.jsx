import React from 'react';
import ProjectSetting from './ProjectSetting';

export default function ProjectsList(props) {
  const projectSettings = props.projects.map(proj =>
    <ProjectSetting key={proj.name} project={proj} patchset={props.patchsets[proj.name]} updatePatchset={props.updatePatchset}/>
  );

  return (
    <div>
      {projectSettings}
    </div>
  );
}
