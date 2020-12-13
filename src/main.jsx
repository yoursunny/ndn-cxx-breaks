import { h, render } from "preact";

import { App } from "./components/App.jsx";

document.addEventListener("DOMContentLoaded", () => {
  render(<App/>, document.querySelector("#app"));
});
