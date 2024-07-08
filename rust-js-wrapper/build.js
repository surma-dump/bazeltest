import * as fs from "node:fs";
import * as path from "node:path";

const args = process.argv.slice(2);
fs.copyFileSync(path.join(args[0], "lib", "lol.wasm"), path.join(new URL("./", import.meta.url).pathname, "lol.wasm"));
