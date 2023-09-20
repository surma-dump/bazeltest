genrule(
    name = "minified",
    cmd = "npx esbuild --bundle src/main.js --minify --outdir=$OUT",
    srcs = ["src/main.js"] + glob(["src/**"]),
    out = "dist"
)