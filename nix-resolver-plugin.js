import * as fs from "node:fs/promises";
import * as path from "node:path";

/**
 * Nix passes the paths for all build inputs via $buildInputs.
 * Those paths contain the root of the derivation, which usually conforms
 * to the POSIX file hierarchy (/bin, /lib, ...). A package built by
 * `buildNpmPackage` seems to put its output into
 * `<pkg path>/lib/node_modules/<top-level package name>`.
 *
 * (The fact that the node_moduels folders contains the name of the top-level
 *  package is a side-effect of workspaces. This needs further investigation.)
 *
 * This plugin tries to resolve package imports against the packages found in
 * $buildInputs or yields to the remaining resolvers otherwise.
 */

/**
 * @returns {import("vite").PluginOption}
 */
export default function nixResolver() {
  let config;
  return {
    async buildStart() {
      const id = await this.resolve("/package.json");
      if (!id) throw Error("Could not resolve to package.json");
      const pkg = JSON.parse(await fs.readFile(id.id, "utf8"));
      const nixBuildInputs = await gatherNixBuildInputs(pkg);
      config = { pkg, nixBuildInputs };
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
      if (!config.nixBuildInputs[packageName]) return;
      // Return the real path.
      return path.join(config.nixBuildInputs[packageName], subPath);
    },
  };
}

async function isFile(p) {
  return fs.stat(p).then(s => s.isFile()).catch(() => false);
}

async function gatherNixBuildInputs(pkg, inputs = process.env.buildInputs) {
  const aliases = await Promise.all(
    // $buildInputs is a space-separated list of build inputs provided by Nix.
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
