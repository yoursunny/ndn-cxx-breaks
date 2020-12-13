import { Component, h } from "preact";

import { ProjectSetting } from "./ProjectSetting.jsx";

export class ProjectsList extends Component {
  render = () => {
    const { projects, patchsets, updatePatchset } = this.props;
    const projectSettings = projects.map((proj) =>
      <ProjectSetting key={proj.name} project={proj} patchset={patchsets[proj.name]} updatePatchset={updatePatchset}/>,
    );

    return (
      <div>
        {projectSettings}
      </div>
    );
  }
}
