import { Component, h } from "preact";

import { ProjectsList } from "./ProjectsList.jsx";

export class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      projects: [],
      isInProgress: false,
      patchsets: {},
      email: "",
      result: "",
    };
  }

  componentDidMount = async () => {
    const patchsets = {};
    const projects = await fetch("projects.json").then((resp) => resp.json());
    projects.forEach((p) => patchsets[p.name] = "master");
    this.setState({
      projects,
      patchsets,
    });
  }

  updatePatchset = (project, patchset) => {
    this.setState((prevState) => ({
      patchsets: Object.assign(prevState.patchsets, { [project.name]: patchset }),
    }));
  }

  handleEmailChange = (evt) => {
    this.setState({ email: evt.target.value });
  }

  handleSubmit = async (evt) => {
    evt.preventDefault();
    this.setState({ isInProgress: true, result: "" });
    const response = await fetch("submit-job.php", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        patchsets: this.state.patchsets,
        email: this.state.email,
      }),
    });
    this.setState({
      isInProgress: false,
      result: response.status === 204 ?
        "OK, you'll receive an email upon completion" :
        `error ${response.status}`,
    });
  }

  render = () => {
    return (
      <form className="container" onSubmit={this.handleSubmit}>
        <p>Please build projects using these revisions:</p>
        <ProjectsList
          projects={this.state.projects}
          patchsets={this.state.patchsets}
          updatePatchset={this.updatePatchset}
        />
        <p>Send result to
          <input type="email" required placeholder="someone@example.com" value={this.state.email} onChange={this.handleEmailChange}/>,
          <input type="submit" className="primary" value="please" disabled={this.state.isInProgress}/>
          <span className={this.state.isInProgress ? "spinner-donut" : ""}/>
          <span hidden={!this.state.result}>{this.state.result}</span>
        </p>
      </form>
    );
  }
}
