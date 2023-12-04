load("@aspect_bazel_lib//lib:run_binary.bzl", "run_binary")
load("@aspect_bazel_lib//lib:copy_to_bin.bzl", "copy_to_bin")

copy_to_bin(
    name = "package_json_bin",
    srcs = [
        "package.json",
    ],
)

copy_to_bin(
    name = "package_lock_json_bin",
    srcs = [
        "package-lock.json",
    ],
)

run_binary(
    name = "node_modules_dir",
    srcs = [
        ":package_json_bin",
        ":package_lock_json_bin",
        "//:node_wrapper",
        "@nodejs_host//:npm",
    ],
    args = [
        "$(location //:node_wrapper)",
        "$${EXECROOT}/$(location @nodejs_host//:npm)",
        "ci",
    ],
    env = {
        "PACKAGE_NAME": package_name(),
        "MARKER_OUT": "$(location :package_json_bin)",
        "CHDIR": "$${PACKAGE_DIR}",
    },
    out_dirs = ["node_modules"],
    tool = "@nodejs_host//:node",
)

run_binary(
    name = "app",
    srcs = [
        "package.json",
        "src/main.js",
        ":node_modules_dir",
        ":package_json_bin",
        "//:node_wrapper",
        "@nodejs_host//:node",
    ],
    outs = ["version.txt"],
    args = [
        "$(location //:node_wrapper)",
        "$${EXECROOT}/$(location @nodejs_host//:node)",
        "--preserve-symlinks-main",
        "$${EXECROOT}/$(location :src/main.js)",
        "$${EXECROOT}/$(location :version.txt)",
    ],
    env = {
        "PACKAGE_NAME": package_name(),
        "MARKER_OUT": "$(location :package_json_bin)",
        "CHDIR": "$${EXECROOT}/$${PACKAGE_NAME}",
        "SYMLINKS": "$${EXECROOT}/$(location :node_modules_dir):$${EXECROOT}/$${PACKAGE_NAME}/node_modules",
    },
    tool = "@nodejs_host//:node",
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
