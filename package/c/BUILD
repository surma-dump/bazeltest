load("@aspect_rules_ts//ts:defs.bzl", "ts_project")
load("@bazel_skylib//lib:partial.bzl", "partial")
load("@aspect_rules_swc//swc:defs.bzl", "swc")

package(default_visibility = ["//visibility:public"])

ts_project(
    name = "c",
    srcs = ["main.ts"],
    tsconfig = "//:ts_config",
    declaration = True,
    transpiler = partial.make(
        swc,
        swcrc = "//:swcrc",
    )
)

