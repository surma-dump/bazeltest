import * as fs from "node:fs";
import * as preact from "preact";

const args = process.argv.slice(2);

fs.writeFileSync(
	args[0],
	JSON.stringify(
		{
			v: process.version,
			c: preact.Component.name,
		},
		null,
		2,
	),
);
