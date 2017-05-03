import React from 'react';

export default function ProjectRow(props) {
  const onChange = props.onChange.bind(null, props.project);

  return (
    <tr>
      <td>{props.project.name}</td>
      <td><input type="text" value={props.setting} onChange={onChange}/></td>
    </tr>
  );
}
