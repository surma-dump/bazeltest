import { ComponentOfDoom } from "@surma/js_with_deps";
import { greet } from "@surma/ts";
import { shouldBe42 } from "@surma/vanilla_js";
import * as React from "react";

export function App() {
  const [ctr, setCtr] = React.useState(0);
  return (
    <div>
      <ComponentOfDoom>Omg a counter</ComponentOfDoom>
      <button onClick={() => setCtr((i) => i + 1)}>Increment</button>
      <span>{greet(`user #${ctr}`)}! Please take a look this: {shouldBe42()}</span>
    </div>
  );
}
