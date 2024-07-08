import * as fs from "node:fs/promises";
import * as path from "node:path";

const pkg = JSON.parse(await fs.readFile(new URL("./package.json", import.meta.url).pathname, "utf8"));

import { defineConfig } from "vite";

async function isFile(p) {
  return fs.stat(p).then(s => s.isFile()).catch(() => false);
}

async function gatherBuildInputs(inputs = process.env.buildInputs) {
  const aliases = await Promise.all(
    inputs.split(" ").map(async input => {
      const depPkgPath = path.join(input, "lib", "node_modules", pkg.name);
      const depPkgJson = path.join(depPkgPath, "package.json");
      if (!(await isFile(depPkgJson))) return [];
      const depPkg = JSON.parse(await fs.readFile(depPkgJson, "utf8"));
      return [[depPkg.name, depPkgPath]];
    }),
  );
  return Object.fromEntries(aliases.flat());
}

export default defineConfig({
  resolve: {
    alias: {
      ...await gatherBuildInputs(),
    },
  },
  build: {
    assetsInlineLimit: 0,
    target: "esnext",
    outDir: process.env.out ?? "dist",
  },
});
