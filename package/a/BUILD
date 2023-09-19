load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@aspect_rules_js//npm:defs.bzl", "npm_package")
load("@npm//:defs.bzl", "npm_link_all_packages")

package(default_visibility = ["//visibility:public"])

npm_link_all_packages(name = "node_modules")

js_library(
    name = "lib",
    srcs = [
        "main.js",
        "package.json",
    ],
    deps = [
        "//:node_modules/lodash"
    ]
)

npm_package(
    name = "a",
     # The package name does not need to be specified in this target since the name
    # that this package is linked as is set by the pnpm lockfile. If it is
    # specified here then it won't be load bearing since the value in the pnpm
    # lockfile will take precedence.
    srcs = [":lib"]
)
