import _ from "lodash";
import {symbol} from "./utils.js";

export function shout(a, {numExcl = 3} = {}) {
	return a.toString().toUpperCase() + _.repeat(symbol(), numExcl);
}
