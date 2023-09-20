import { defineConfig } from "vite";
import commonjs from "vite-plugin-commonjs";
import { dirname } from "node:path";

export default defineConfig({
	clearScreen: false,
	optimizeDeps: {
		disabled: true,
	},
});
