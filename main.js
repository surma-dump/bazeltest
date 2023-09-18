import {sum} from "lodash";
export function a() {
	let a = [4];
	if(false) {
		a.push(5)
	}
	return sum(a);
}
