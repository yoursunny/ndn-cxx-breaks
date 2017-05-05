import React from 'react';

export default class CommitInfo extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      info: null
    };
  }

  componentWillMount() {
    this.fetchInfo(this.props);
  }

  componentWillReceiveProps(nextProps) {
    if (this.props.patchset == nextProps.patchset) {
      return;
    }
    this.fetchInfo(nextProps);
  }

  shouldComponentUpdate(nextProps, nextState) {
    return JSON.stringify(this.state.info) != JSON.stringify(nextState.info);
  }

  fetchInfo(props) {
    if (!/^[\d]+,[\d]+$/.test(props.patchset)) {
      this.setState({info: null});
      return;
    }

    fetch('commit-info.php?patchset=' + props.patchset).then(resp => resp.json())
    .then(j => this.setState({info: j}));
  }

  render() {
    return (
      <CommitInfoDisplay info={this.state.info}/>
    );
  }
}

function CommitInfoDisplay(props) {
  return (
    <span>{JSON.stringify(props.info)}</span>
  );
}
