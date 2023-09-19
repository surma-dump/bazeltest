load("@aspect_rules_ts//ts:defs.bzl", "ts_project")

package(default_visibility = ["//visibility:public"])

# Type-checks, and emits output to
# bazel-bin/examples/simple/foo.js
# bazel-bin/examples/simple/foo.d.ts
ts_project(
    name = "c",
    srcs = ["main.ts"],
    tsconfig = "//:ts_config",
    transpiler = "tsc",
    # declaration = True,
    # "." is the same as default
    # explicitly given as a regression test for https://github.com/aspect-build/rules_ts/issues/195
    # out_dir = ".",
    # Note, the tsconfig attribute defaults to the tsconfig.json file in this directory.
    # tsconfig = "<default>",
    # deps = [
    #     # Two dependencies are linked from first-party code in this repo
    #     # by the npm_link_package calls in /examples/BUILD.bazel
    #     "//examples:node_modules/@myorg/js_lib",
    #     "//examples:node_modules/@myorg/dts_lib",
    #     # Two dependencies are linked from third-party npm packages
    #     # by the npm_link_all_packages call in /examples/BUILD.bazel
    #     "//examples:node_modules/@types/node",
    #     "//examples:node_modules/date-fns",
    # ],
)

