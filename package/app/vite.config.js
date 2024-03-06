import reactPlugin from "@vitejs/plugin-react";
import * as fs from "node:fs";
import { defineConfig } from "vite";

import data from "./package.json";

const workspaceDeps = Object.entries(data.dependencies)
  .filter(([_k, v]) => v.startsWith("workspace:"))
  .map(([k]) => k);

const watchRoot = getBazelWorkspaceRoot();
console.log({ watchRoot });
export default defineConfig({
  plugins: [reactPlugin(), {
    apply: "serve",
    configureServer(server) {
      server.watcher.add(new URL("./node_modules", import.meta.url).pathname);
    },
  }],
  clearScreen: false,
  // This is allegedly the fix, but it breaks the app with Bazel.
  // https://github.com/vitejs/vite/issues/13014
  // resolve: {
  //   preserveSymlinks: true
  // },
  server: {
    watch: {
      followSymlinks: true,
      cwd: watchRoot,
    },
  },
  optimizeDeps: {
    force: true,
    exclude: workspaceDeps,
  },
});

setInterval(() => {
  console.log(
    fs.readFileSync(new URL("./node_modules/@surma/js_with_deps/bundle.js", import.meta.url).pathname, "utf8"),
  );
}, 1000);

function getBazelWorkspaceRoot() {
  const { JS_BINARY__PACKAGE } = process.env;
  const depth = JS_BINARY__PACKAGE.split("/").length;
  return new URL("../".repeat(depth), import.meta.url).pathname;
}
