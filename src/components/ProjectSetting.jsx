import { Component, h } from "preact";

import { CommitInfo } from "./CommitInfo.jsx";

export class ProjectSetting extends Component {
  handleMasterChange = (evt) => {
    if (evt.target.checked) {
      this.props.updatePatchset(this.props.project, "master");
    }
  };

  handleSkipChange = (evt) => {
    if (evt.target.checked) {
      this.props.updatePatchset(this.props.project, "skip");
    }
  };

  isSpecificPatchset = () => this.props.patchset !== "skip" && this.props.patchset !== "master";

  handlePatchsetActivate = (evt) => {
    if (evt.target.checked) {
      this.props.updatePatchset(this.props.project, "");
      setTimeout(this.patchsetInput.focus.bind(this.patchsetInput), 0);
    }
  };

  handlePatchsetChange = (evt) => {
    this.props.updatePatchset(this.props.project, evt.target.value);
  };

  render = () => (
    <div className="row proj-setting">
      <div className="col-sm-12 col-md-3 proj-name">{this.props.project.name}</div>
      <div className="col-sm-12 col-md-3">
        <div className="input-group">
          <input type="radio" id={`r_${this.props.project.name}_master`} name={`r_${this.props.project.name}`} checked={this.props.patchset === "master"} onChange={this.handleMasterChange}/>
          <label htmlFor={`r_${this.props.project.name}_master`}>master branch</label>
        </div>
      </div>
      <div className="col-sm-12 col-md-3">
        <div className="input-group">
          <input type="radio" id={`r_${this.props.project.name}_skip`} name={`r_${this.props.project.name}`} checked={this.props.patchset === "skip"} onChange={this.handleSkipChange}/>
          <label htmlFor={`r_${this.props.project.name}_skip`}>skip project</label>
        </div>
      </div>
      <div className="col-sm-12 col-md-3" hidden={this.props.project.master_only}>
        <div className="input-group">
          <input type="radio" id={`r_${this.props.project.name}_patchset`} name={`r_${this.props.project.name}`} checked={this.isSpecificPatchset()} onChange={this.handlePatchsetActivate}/>
          <label htmlFor={`r_${this.props.project.name}_patchset`}>{this.isSpecificPatchset() ? "" : "specific patchset"}</label>
        </div>
        <input type="text" value={this.props.patchset} placeholder="8888,11" className="proj-patchset" hidden={!this.isSpecificPatchset()} onChange={this.handlePatchsetChange} ref={(input) => { this.patchsetInput = input; }}/>
      </div>
      <div className="col-sm-12 col-md-9 col-md-offset-3" hidden={!this.isSpecificPatchset()}>
        <CommitInfo patchset={this.props.patchset}/>
      </div>
    </div>
  );
}
