load("@aspect_bazel_lib//lib:run_binary.bzl", "run_binary")
load("@aspect_bazel_lib//lib:copy_to_bin.bzl", "copy_to_bin")

def npm_link_all_packages(
        name,
        package_json = "package.json",
        package_lock_json = "package-lock.json",
        **kwargs):
    copy_to_bin(
        name = "package_json_bin",
        srcs = [package_json],
    )

    copy_to_bin(
        name = "package_lock_json_bin",
        srcs = [package_lock_json],
    )

    run_binary(
        name = name,
        srcs = [
            ":package_json_bin",
            ":package_lock_json_bin",
            "//minimalist_rules_js:prepare_env",
            "@nodejs_host//:npm",
        ],
        args = [
            "$(location //minimalist_rules_js:prepare_env)",
            "$${EXECROOT}/$(location @nodejs_host//:npm)",
            "ci",
        ],
        env = {
            "PACKAGE_NAME": native.package_name(),
            "MARKER_OUT": "$(location :package_json_bin)",
            "CHDIR": "$${PACKAGE_DIR}",
        },
        out_dirs = ["node_modules"],
        tool = "@nodejs_host//:node",
        **kwargs
    )

def run_js_binary(
        name,
        src,
        outs,
        node_modules,
        data = [],
        args = [],
        env = {},
        package_json = "package.json",
        package_lock_json = "package-lock.json",
        **kwargs):
    run_binary(
        name = name,
        srcs = [
            package_json,
            node_modules,
            "//minimalist_rules_js:prepare_env",
            ":package_json_bin",
            "@nodejs_host//:node",
        ] + data + [src],
        outs = outs,
        args = [
            "$(location //minimalist_rules_js:prepare_env)",
            "$${EXECROOT}/$(location @nodejs_host//:node)",
            "--preserve-symlinks-main",
            "$${EXECROOT}/$(location %s)" % src,
        ] + args,
        env = {
            "PACKAGE_NAME": native.package_name(),
            "MARKER_OUT": "$(location :package_json_bin)",
            "SYMLINKS": "$${EXECROOT}/$(location %s):$${EXECROOT}/$${PACKAGE_NAME}/node_modules" % node_modules,
        },
        tool = "@nodejs_host//:node",
        **kwargs
    )
