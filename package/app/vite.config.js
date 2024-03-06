import reactPlugin from "@vitejs/plugin-react";
import { defineConfig } from "vite";

import data from "./package.json";

const workspaceDeps = Object.entries(data.dependencies)
  .filter(([_k, v]) => v.startsWith("workspace:"))
  .map(([k]) => k);

console.log({ workspaceDeps });
export default defineConfig({
  plugins: [reactPlugin()],
  clearScreen: false,
  // This is allegedly the fix, but it breaks the app with Bazel.
  // https://github.com/vitejs/vite/issues/13014
  // resolve: {
  //   preserveSymlinks: true
  // },
  optimizeDeps: {
    force: true,
    exclude: workspaceDeps,
  },
});
