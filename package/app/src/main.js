import { shouldBe42 } from "@surma/vanilla_js";
import { greet } from "@surma/ts";

document.body.append(greet("Surma"));
document.body.append(`The result is: ${shouldBe42()}`);
