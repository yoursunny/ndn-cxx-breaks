import React from 'react';
import CommitInfo from './CommitInfo';

export default class ProjectSetting extends React.Component {
  constructor(props) {
    super(props)
    this.onMasterChange = this.onMasterChange.bind(this);
    this.onSkipChange = this.onSkipChange.bind(this);
    this.activatePatchset = this.activatePatchset.bind(this);
    this.onPatchsetChange = this.onPatchsetChange.bind(this);

    this.updatePatchset = props.updatePatchset.bind(null, props.project);
  }

  onMasterChange(evt) {
    if (evt.target.checked) {
      this.updatePatchset('master');
    }
  }

  onSkipChange(evt) {
    if (evt.target.checked) {
      this.updatePatchset('none');
    }
  }

  isSpecificPatchset() {
    return this.props.patchset != 'none' && this.props.patchset != 'master';
  }

  activatePatchset(evt) {
    if (evt.target.checked) {
      this.updatePatchset('');
      setTimeout(this.patchsetInput.focus.bind(this.patchsetInput), 0);
    }
  }

  onPatchsetChange(evt) {
    this.updatePatchset(evt.target.value);
  }

  render() {
    return (
      <div className="row proj-setting">
        <div className="col-sm-12 col-md-3 proj-name">{this.props.project.name}</div>
        <div className="col-sm-12 col-md-3">
          <div className="input-group">
            <input type="radio" id={'r_' + this.props.project.name + '_master'} name={'r_' + this.props.project.name} checked={this.props.patchset == 'master'} onChange={this.onMasterChange}/>
            <label htmlFor={'r_' + this.props.project.name + '_master'}>master branch</label>
          </div>
        </div>
        <div className="col-sm-12 col-md-3">
          <div className="input-group">
            <input type="radio" id={'r_' + this.props.project.name + '_skip'} name={'r_' + this.props.project.name} checked={this.props.patchset == 'none'} onChange={this.onSkipChange}/>
            <label htmlFor={'r_' + this.props.project.name + '_skip'}>skip project</label>
          </div>
        </div>
        <div className="col-sm-12 col-md-3" hidden={this.props.project.master_only}>
          <div className="input-group">
            <input type="radio" id={'r_' + this.props.project.name + '_patchset'} name={'r_' + this.props.project.name} checked={this.isSpecificPatchset()} onChange={this.activatePatchset}/>
            <label htmlFor={'r_' + this.props.project.name + '_patchset'}>{this.isSpecificPatchset() ? '' : 'specific patchset:'}</label>
          </div>
          <input type="text" value={this.props.patchset} className="proj-patchset" hidden={!this.isSpecificPatchset()} onChange={this.onPatchsetChange} ref={(input) => { this.patchsetInput = input; }}/>
        </div>
        <div className="col-sm-12 col-md-9 col-md-offset-3" hidden={!this.isSpecificPatchset()}>
          <CommitInfo patchset={this.props.patchset}/>
        </div>
      </div>
    );
  }
}
