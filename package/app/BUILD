load("@aspect_bazel_lib//lib:run_binary.bzl", "run_binary")
load("@aspect_bazel_lib//lib:copy_to_bin.bzl", "copy_to_bin")

copy_to_bin(
    name = "bin_package_json",
    srcs = [
        "package.json"
    ]
)

copy_to_bin(
    name = "bin_package_lock_json",
    srcs = [
        "package-lock.json"
    ]
)

run_binary(
    name = "node_modules_dir",
    out_dirs = ["node_modules"],
    outs = [".marker"],
    srcs = [
        "//:node_wrapper",
        ":bin_package_json",
        ":bin_package_lock_json",
        "package.json",
        "package-lock.json",
        "@nodejs_host//:npm",
    ],
    env = {
        "PACKAGE_NAME": package_name(),
        "MARKER_OUT": "$(execpath :.marker)",
        "CHDIR": "$${PACKAGE_DIR}",
    },
    tool = "@nodejs_host//:node",
    args = ["$(location //:node_wrapper)", "$${EXECROOT}/$(location @nodejs_host//:npm)", "ci"]
)

run_binary(
    name = "app",
    srcs = [
        "src/main.js",
        "package.json",
        ":node_modules_dir"
    ],
    outs = ["version.txt"],
    tool = "@nodejs_host//:node",
    args = ["$(location //:node_wrapper)", "$(location :src/main)"]
)
# genrule(
#     name = "app",
#     tools = [
#         "@nodejs_host//:node"
#     ],
#     cmd = """
#         NODE=$$(readlink -f $(location @nodejs_host//:node))
#         PKGDIR=$$(dirname $$(echo $$PWD/$(location :package.json)))
#         TAR=$$(readlink -f $(location :node_modules_tar))
#         OUT=$$(echo $$PWD/$(location :version.txt))
#         cd $$PKGDIR
#         tar -xf $(location :node_modules_tar)
#         $(location @nodejs_host//:node) $(location :src/main.js) > $$OUT
#     """,
# )
