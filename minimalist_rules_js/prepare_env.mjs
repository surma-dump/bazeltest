import * as fs from "node:fs";
import * as path from "node:path";
import { spawnSync } from "node:child_process";


// Grab all values that we pass in via the defs.bzl file.
// - PACKAGE_NAME is equivalent to `package_name()` in starlark
// - OUT_DIR_FILE is the path of a file in the output folder, 
//   so we can derive the path of the output folder.
// - EXECROOT is, well, the exec root.
const { OUT_DIR_FILE, PACKAGE_NAME, EXECROOT = process.cwd() } = process.env;
const OUT_DIR = path.dirname(OUT_DIR_FILE);
const PACKAGE_DIR = OUT_DIR_FILE.startsWith("/")
	? OUT_DIR
	: path.join(EXECROOT, OUT_DIR);

const additionalEnv = {
	EXECROOT,
	PACKAGE_DIR,
	OUT_DIR,
	BIN_DIR: PACKAGE_DIR.slice(0, -1 * PACKAGE_NAME.length),
};
// Expand all variables
const newEnv = expandEnvVariables(
	Object.assign({}, process.env, additionalEnv),
);

if (newEnv.SYMLINKS) {
	for (const symlink of newEnv.SYMLINKS.split(";")) {
		let [target, symlinkPath] = symlink
			.split(":")
			.map((p) => path.normalize(p));
		fs.symlinkSync(target, symlinkPath);
	}
}

const [cmd, ...args] = process.argv
	.slice(2)
	.map((arg) => expandVariables(arg, newEnv));

const result = spawnSync(cmd, args, {
	stdio: "inherit",
	cwd: newEnv.CHDIR,
	env: newEnv,
});

process.exit(result.status);

/**
 * Replaces all occurences of `${name}` in `str` with the value in the dictionary (i.e. `vars[name]`).
 * @param {string} str
 * @param {Record<string, string>} vars
 * @returns {string}
 */
function expandVariables(str, vars) {
const VAR_REGEXP = /\$\{([^}]+)\}/g;
	return str.replace(VAR_REGEXP, (_match, varName) => {
		return vars[varName] ?? "";
	});
}

/**
 * Expand all variable expressions in the values of the provided dictionary, 
 * using the dictionary itself for values.
 * @param {Record<string, string>} env
 * @returns {Record<string, string>}
 */
function expandEnvVariables(env) {
	for (const key of Object.keys(env)) {
		env[key] = expandVariables(env[key], env);
	}
	return env;
}
