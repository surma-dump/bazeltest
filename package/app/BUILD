load("@npm//:defs.bzl", "npm_link_all_packages")
load("@aspect_rules_js//js:defs.bzl", "js_binary", "js_run_devserver")
load("@npm//package/app:vite/package_json.bzl", vite_bin = "bin")

package(default_visibility = ["//visibility:public"])

npm_link_all_packages(name = "node_modules")

SRCS = glob(["src/**"]) + [
    "index.html"
]

DEPS = [":node_modules/" + d for d in [
        "@surma/vanilla_js",
        "@surma/ts"
]]

vite_bin.vite(
    name = "app",
    args = ["build"],
    out_dirs = ["dist"],
    chdir = package_name(),
    srcs = SRCS + DEPS,
)

vite_bin.vite_binary(
    name = "devserver",
    chdir = package_name(),
)

js_run_devserver(
    name = "dev",
    tool = ":devserver",
    data = SRCS + DEPS,
    args = [],
)
