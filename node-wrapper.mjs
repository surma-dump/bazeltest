import * as fs from "node:fs";
import * as path from "node:path";
import { spawnSync } from "node:child_process";

// Replace all `${name}` expressions in `str` with `vars[name]`.
const VAR_REGEXP = /\$\{([^}]+)\}/g;
function expandVariables(str, vars) {
	return str.replace(VAR_REGEXP, (_match, varName) => {
		return vars[varName] ?? "";
	});
}

// Expand all ${env} expressions in all variables.
function expandEnvVariables(env) {
	for (const key of Object.keys(env)) {
		env[key] = expandVariables(env[key], env);
	}
	return env;
}

// TODO: Rename MARKER_OUT to OUT_DIR_FILE or something
const { MARKER_OUT, PACKAGE_NAME, EXECROOT = process.cwd() } = process.env;
// Derive additional, helpful values.
const PACKAGE_DIR = MARKER_OUT.startsWith("/")
	? path.dirname(MARKER_OUT)
	: path.join(EXECROOT, path.dirname(MARKER_OUT));
const additionalEnv = {
	EXECROOT,
	PACKAGE_DIR,
	BINDIR: PACKAGE_DIR.slice(0, -1 * PACKAGE_NAME.length),
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
