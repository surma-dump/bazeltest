import reactPlugin from "@vitejs/plugin-react";
import { defineConfig } from "vite";

export default defineConfig({
  plugins: [reactPlugin()],
  clearScreen: false,
  optimizeDeps: {
    // This works around the fact that we have our own code
    force: true,
  },
});
