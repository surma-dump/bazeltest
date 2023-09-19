import _ from "lodash";

export function a() {
	let a = [4];
	if(false) {
		a.push(5)
	}
	return _.sum(a);
}
