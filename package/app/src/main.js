import { shouldBe42 } from "@surma/vanilla_js";
import { greet } from "@surma/ts";
import "@surma/js_with_deps";

document.body.append(greet("Surma"));
document.body.append(`The result is: ${shouldBe42()}`);
