import { defineConfig } from "vite";

import nixResolver from "./nix-resolver-plugin.js";

export default defineConfig({
  plugins: [nixResolver()],
  build: {
    assetsInlineLimit: 0,
    target: "esnext",
    outDir: process.env.out ?? "dist",
  },
});
