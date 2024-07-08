import { defineConfig } from "vite";

export default defineConfig({
  resolve: {
    alias: {
      // This would be automatically set up by a vite plugin
      // that we write.
      "rust-js-wrapper": `${process.env.buildInputs.split(" ")[0]}/lib/node_modules/js`,
    },
  },
  build: {
    target: "esnext",
    outDir: process.env.out ?? "dist",
  },
});
