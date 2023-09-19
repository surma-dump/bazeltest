import _ from "lodash";

export function shouldBe42() {
	let a = [40, 2];
	if (false) {
		a.push(5);
	}
	return _.sum(a);
}
