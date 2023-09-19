load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@aspect_rules_js//npm:defs.bzl", "npm_link_package", "npm_package", "stamped_package_json")

stamped_package_json(
    name = "package",
    # This key is defined by /workspace_status.sh
    stamp_var = "STABLE_BUILD_VERSION",
)

js_library(
    name = "a",
    srcs = [
        "main.js",
        ":package"
    ],
    visibility = ["//visibility:public"],
)

npm_package(
    name = "npm",
    srcs = [
        ":a"
    ],
    package = "@surmatest/a",
    visibility = ["//visibility:public"],
)