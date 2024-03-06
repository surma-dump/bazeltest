import * as React from "react";
import { shouldBe42 } from "@surma/vanilla_js";
import { greet } from "@surma/ts";
import {ComponentOfDoom} from "@surma/js_with_deps";

export function App() {
	const [ctr, setCtr] = React.useState(0);
	return (
		<>
			<ComponentOfDoom>Omg a counter</ComponentOfDoom>
			<button onClick={() => setCtr((i) => i + 1)}>Increment</button>
      <span>{greet(`user #${ctr}`)}! Please take a look this: {shouldBe42()}</span>
		</>
	);
}
