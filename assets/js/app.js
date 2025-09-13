import "./phx";
import "./events";
import "iconify-icon";
import autoAnimate from "@formkit/auto-animate";
import { observe } from "selector-observer";

/*
 * Detects when new auto animate elements have been added
 * to the DOM  (statically or dynamically) and initialize them.
 */
observe("[data-auto-animate]", {
  initialize: (element) => autoAnimate(element),
});

/*
 * Make sure to reinitialize all plugins when we navigate.
 * LiveView sends two page-loading-stop events, but we want to
 * ensure that any additional initialization code runs only once.
 */
window.addEventListener("phx:page-loading-stop", (info) => {
  if (info.detail.kind != "initial") return;
  // Add any plugin initialization code here!
});
