import * as React from "react";
import { createRoot } from "react-dom/client";
import { App } from "./app.jsx";

const root = createRoot(document.querySelector("main"));
root.render(<App />);
