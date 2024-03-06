import { defineConfig } from "vite";
import react from '@vitejs/plugin-react';

export default defineConfig({
	clearScreen: false,
	optimizeDeps: {
		// This works around the fact that we have our own code
		force: true,
	},
	plugins: [
		react(),
	]
});
