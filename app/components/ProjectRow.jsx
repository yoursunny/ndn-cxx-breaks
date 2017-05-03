import React from 'react';
import CommitInfo from './CommitInfo';

export default class ProjectRow extends React.Component {
  constructor(props) {
    super(props)
    this.changeSetting = props.onChange.bind(null, props.project);

    this.onBuildChange = this.onBuildChange.bind(this);
    this.onMasterChange = this.onMasterChange.bind(this);
    this.onTextChange = this.onTextChange.bind(this);
  }

  shouldComponentUpdate(nextProps, nextState) {
    return this.props.patchset != nextProps.patchset;
  }

  onBuildChange(evt) {
    if (!evt.target.checked) {
      this.changeSetting('none');
    }
  }

  onMasterChange(evt) {
    if (evt.target.checked) {
      this.changeSetting('master');
    }
  }

  onTextChange(evt) {
    this.changeSetting(evt.target.value);
  }

  render() {
    return (
      <tr>
        <td>{this.props.project.name}</td>
        <td><input type="checkbox" checked={this.props.patchset != 'none'} onChange={this.onBuildChange}/></td>
        <td><input type="checkbox" checked={this.props.patchset == 'master'} onChange={this.onMasterChange}/></td>
        <td><input type="text" value={this.props.patchset} onChange={this.onTextChange}/></td>
        <td><CommitInfo patchset={this.props.patchset}/></td>
      </tr>
    );
  }
}
