import { render, h, Fragment } from "preact";
import { useState } from "preact/hooks";

const div = document.createElement("div");
document.body.append(div);

function App() {
	const [ctr, setCtr] = useState(0);
	return (
		<>
			<h1>Omg a counter</h1>
			<div>Count {ctr}</div>
			<button onClick={() => setCtr((i) => i + 1)}>Increment</button>
		</>
	);
}

render(<App />, div);
