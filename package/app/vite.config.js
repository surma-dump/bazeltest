import { defineConfig } from "vite";
import commonjs from "vite-plugin-commonjs";
import { dirname } from "node:path";

export default defineConfig({
	clearScreen: false,
	optimizeDeps: {
		// This works around the fact that we have our own code
		force: true,
	},
});
