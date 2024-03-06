import { shouldBe42 } from "@surma/vanilla_js";
import { greet } from "@surma/ts";
import "@surma/js_with_deps";

document.body.append(greet("user who is using a TypeScript library"));
document.body.append(`The result of a vanilla JS computation is: ${shouldBe42()}`);
