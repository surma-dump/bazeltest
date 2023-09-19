load("@npm//:defs.bzl", "npm_link_all_packages")
load("@aspect_rules_ts//ts:defs.bzl", "ts_config")

package(default_visibility = ["//visibility:public"])

ts_config(
    name = "ts_config",
    src = ":tsconfig.json"
)

npm_link_all_packages(name = "node_modules")

