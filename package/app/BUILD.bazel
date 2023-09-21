load("@npm//:defs.bzl", "npm_link_all_packages")
load("@aspect_rules_js//js:defs.bzl", "js_binary", "js_run_devserver")
load("@npm//package/app:vite/package_json.bzl", vite_bin = "bin")

package(default_visibility = ["//visibility:public"])

npm_link_all_packages(name = "node_modules")

SRCS = glob(["src/**"]) + [
    "index.html",
    "vite.config.js",
]

DEPS = [":node_modules/" + d for d in [
        "@surma/vanilla_js",
        "@surma/ts",
        "vite"
    ]]

vite_bin.vite(
    name = "app",
    args = ["build"],
    out_dirs = ["dist"],
    chdir = package_name(),
    srcs = SRCS + DEPS,
)

vite_bin.vite_binary(
    name = "dev",
    chdir = package_name(),
    data = SRCS + DEPS,
)

