import { defineConfig } from "vite";

export default defineConfig({
	clearScreen: false,
	optimizeDeps: {
		// This works around the fact that we have our own code
		force: true,
	},
});
