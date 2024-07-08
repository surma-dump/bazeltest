import rawWasm from "rust-js-wrapper/lol.wasm?url";

const { instance } = await WebAssembly.instantiateStreaming(fetch(rawWasm), {});

console.log(`Hi! ${instance.exports.math(40, 2)}`);
