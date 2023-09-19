load("@npm//:defs.bzl", "npm_link_all_packages")
load("@aspect_rules_js//js:defs.bzl", "js_binary")
load("@npm//:vite/package_json.bzl", vite_bin = "bin")

package(default_visibility = ["//visibility:public"])


npm_link_all_packages(name = "node_modules")

vite_bin.vite(
    name = "app",
    args = ["build"],
    out_dirs = ["dist"],
    chdir = package_name(),
    srcs = [
        "index.html",
        "src/main.js",
        ":node_modules/@surma/vanilla_js", 
        ":node_modules/@surma/ts"
    ],
)
