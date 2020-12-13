import { Component, h } from "preact";

export class CommitInfo extends Component {
  constructor(props) {
    super(props);

    this.state = {
      info: null,
    };
  }

  componentDidMount = () => {
    this.fetchInfo();
  }

  componentDidUpdate = (prevProps) => {
    if (this.props.patchset !== prevProps.patchset) {
      this.fetchInfo();
    }
  }

  fetchInfo = async () => {
    const { patchset } = this.props;
    if (!/^\d+,\d+$/.test(patchset)) {
      this.setState({ info: null });
      return;
    }

    const resp = await fetch(`commit-info.php?patchset=${patchset}`);
    const j = await resp.json();
    this.setState({ info: j });
  }

  render = () => {
    return (
      <CommitInfoDisplay info={this.state.info}/>
    );
  }
}

function CommitInfoDisplay(props) {
  if (!props.info) {
    return <span/>;
  }
  return (
    <div className="commit-info">
      <span>{props.info.author}</span>
      {" "}
      <span>{props.info.subject}</span>
    </div>
  );
}
