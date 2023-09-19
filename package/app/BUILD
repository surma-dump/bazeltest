load("@npm//:defs.bzl", "npm_link_all_packages")
load("@aspect_rules_js//js:defs.bzl", "js_binary")

package(default_visibility = ["//visibility:public"])

npm_link_all_packages(name = "node_modules")

js_binary(
    name = "app",
    data = [
        ":node_modules/@surma/vanilla_js", 
        ":node_modules/@surma/ts"
    ],
    entry_point = "main.js",
)
