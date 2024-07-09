import * as fs from "node:fs/promises";
import * as path from "node:path";

/**
 * Nix passes the paths for all build inputs via $buildInputs.
 * Those paths contain the root of the derivation, which usually conforms
 * to the POSIX file hierarchy (/bin, /lib, ...). A package built by
 * `buildNpmPackage` seems to put its output into
 * `<pkg path>/lib/node_modules/<package names>`.
 *
 * This plugin tries to resolve package imports against the packages found in
 * $buildInputs or yields to the remaining resolvers otherwise.
 */

/**
 * @returns {import("vite").PluginOption}
 */
export default function nixResolver() {
  let nixBuildInputs;
  return {
    async buildStart() {
      nixBuildInputs = await gatherNixBuildInputs();
    },
    async resolveId(id) {
      if (id.startsWith("./") || id.startsWith("/")) return;
      // `id` is something like `my-package`, `my-package/file.js`
      // or `@org/my-package/file.js` etc.
      const parts = id.split("/");
      // If `id` starts with "@", we need to take the first two items
      // to get the package name. Otherwise just the first part.
      const packageName = parts.slice(0, id.startsWith("@") ? 2 : 1).join("/");
      const subPath = parts.slice(id.startsWith("@") ? 2 : 1).join("/");
      if (!nixBuildInputs[packageName]) return;
      // Return the real path.
      return path.join(nixBuildInputs[packageName], subPath);
    },
  };
}

async function isDir(p) {
  return fs.stat(p).then(s => s.isDirectory()).catch(() => false);
}

async function gatherNixBuildInputs(inputs = process.env.buildInputs) {
  const aliases = await Promise.all(
    // $buildInputs is a space-separated list of build inputs provided by Nix.
    inputs.split(" ").map(async input => {
      const nodeModules = path.join(input, "lib", "node_modules");
      if (!(await isDir(nodeModules))) return [];
      const modules = await fs.readdir(nodeModules);
      return modules.map(m => [m, path.join(nodeModules, m)]);
    }),
  );
  return Object.fromEntries(aliases.flat());
}
