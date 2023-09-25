import * as readline from "node:readline/promises";
import { stdin as input, stdout as output } from "node:process";

const rl = readline.createInterface({ input, output });

console.log("Directory: ", process.cwd());
rl.on("line", (input) => {
	const parts = input.split(" ");
	console.log({ parts });
	switch (parts[0]) {
		case "IBAZEL_BUILD_STARTED":
			console.log(">>>>>>>>> ibazel started a build after a file change");
			break;
		case "IBAZEL_BUILD_COMPLETED":
			console.log(">>>>>>>>> ibazel finished a build. Status:", parts[1]);
			break;
		default:
			console.log(">>>>>>>>> Unrecognized input:", JSON.stringify(input));
	}
});
