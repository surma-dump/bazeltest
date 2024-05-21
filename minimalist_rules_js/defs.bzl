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
            # "//minimalist_rules_js:npmrc",
            "@nodejs_host//:npm",
        ],
        args = [
            "$(location //minimalist_rules_js:prepare_env)",
            "$${EXECROOT}/$(location @nodejs_host//:npm)",
            "--cache=.cache",
            "ci",
        ],
        env = {
            "PACKAGE_NAME": native.package_name(),
            "OUT_DIR_FILE": "$(location :package_json_bin)",
            "CHDIR": "$${PACKAGE_DIR}",
        },
        out_dirs = ["node_modules"],
        tool = "@nodejs_host//:node",
        **kwargs
    )

def run_js_binary(
        name,
        tool,
        outs,
        node_modules,
        is_npx = False,
        srcs = [],
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
        ] + data + srcs + ([tool] if not is_npx else []),
        outs = outs,
        args = [
            "$(location //minimalist_rules_js:prepare_env)",
        ] + ([
            "$${EXECROOT}/$(location @nodejs_host//:node)",
            "--preserve-symlinks-main",
            "$${EXECROOT}/$(location %s)" % tool,
        ] if not is_npx else [
            "$${EXECROOT}/$(location %s)/.bin/%s" % (node_modules, tool),
        ]) + args,
        env = env | {
            "PACKAGE_NAME": native.package_name(),
            "OUT_DIR_FILE": "$(location :package_json_bin)",
            "SYMLINKS": ";".join(["$${EXECROOT}/$(location %s):$${EXECROOT}/$${PACKAGE_NAME}/node_modules" % node_modules, env.get("SYMLINKS", "")]),
            "IS_NPX": "%s" % is_npx,
        },
        tool = "@nodejs_host//:node",
        **kwargs
    )
