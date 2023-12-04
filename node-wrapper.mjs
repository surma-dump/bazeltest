import * as fs from "node:fs";
import * as path from "node:path";
import { spawnSync } from "node:child_process";

// Replace all `${name}` expressions in `str` with `vars[name]`.
const VAR_REGEXP = /\$\{([^}]+)\}/g;
function expandVariables(str, vars, { keepUnknown = false } = {}) {
	return str.replace(VAR_REGEXP, (match, varName) => {
		if (keepUnknown && !vars[varName]) return match;
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

const { MARKER_OUT, PACKAGE_NAME } = process.env;
// Derive additional, helpful values.
const EXECROOT = process.cwd();
const PACKAGE_OUT_DIR = path.join(EXECROOT, path.dirname(MARKER_OUT));
const PACKAGE_SRC_DIR = path.join(EXECROOT, PACKAGE_NAME);
const additionalEnv = {
	EXECROOT,
	PACKAGE_OUT_DIR,
	PACKAGE_SRC_DIR,
	BINDIR: PACKAGE_OUT_DIR.slice(0, -1 * PACKAGE_NAME.length),
};
// Expand all variables
const newEnv = expandEnvVariables(
	Object.assign({}, process.env, additionalEnv),
);

const [cmd, ...args] = process.argv
	.slice(2)
	.map((arg) => expandVariables(arg, newEnv));

const result = spawnSync(cmd, args, {
	stdio: "inherit",
	cwd: newEnv.CHDIR,
	env: newEnv,
});

fs.writeFileSync(
	process.env.MARKER_OUT,
	JSON.stringify(
		{
			env: process.env,
			newEnv: newEnv,
			cmd,
			args,
		},
		null,
		2,
	),
);

process.exit(result.status);
