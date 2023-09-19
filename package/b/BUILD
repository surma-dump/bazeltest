load("@npm//:defs.bzl", "npm_link_all_packages")
load("@aspect_rules_js//js:defs.bzl", "js_binary")

package(default_visibility = ["//visibility:public"])

npm_link_all_packages(name = "node_modules")

js_binary(
    name = "b",
    data = [
        ":node_modules/surm_a", 
        ":node_modules/@surma/c"
    ],
    entry_point = "main.js",
)
