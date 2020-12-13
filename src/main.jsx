import galite from "ga-lite";
import { h, render } from "preact";

import { App } from "./components/App.jsx";

if (location.hostname.endsWith(".ndn.today")) {
  galite("create", "UA-935676-11", "auto");
  galite("send", "pageview");
}

document.addEventListener("DOMContentLoaded", () => {
  render(<App/>, document.querySelector("#app"));
});
