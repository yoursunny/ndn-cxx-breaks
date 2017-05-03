import React from 'react';
import CommitInfo from './CommitInfo';

export default function ProjectRow(props) {
  const onChange = props.onChange.bind(null, props.project);

  return (
    <tr>
      <td>{props.project.name}</td>
      <td><input type="text" value={props.setting} onChange={onChange}/></td>
      <td><CommitInfo patchset={props.setting}/></td>
    </tr>
  );
}
