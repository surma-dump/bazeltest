import React from 'react'; // can't get TS to stop caring about this (it's redundant)
import { shouldBe42 } from "@surma/vanilla_js";
import { greet } from "@surma/ts";

export function App() {
    const greeting = greet("user who is using a TypeScript library");
    // try changing the background color below to see HMR in action.
    return (
        <div className="app" style={{ background:'#ccc' }}>
            <div className="greeting">{greeting}</div>
            <div className="result">The result of a vanilla JS computation is: {shouldBe42()}</div>
        </div>
    );
}
