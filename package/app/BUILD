genrule(
    name = "node_modules_dir",
    srcs = [
        "package.json",
        "package-lock.json"
    ],
    tools = [
        "@nodejs_host//:npm"
    ],
    outs = ["node_modules"],
    cmd = """
        NPM=$$(readlink -f $(location @nodejs_host//:npm))
        cd package/app
        mv node_modules $(location :node_modules_dir)
        $$NPM ci
    """,
)

genrule(
    name = "app",
    tools = [
        "@nodejs_host//:node"
    ],
    srcs = [
        "src/main.js",
        ":node_modules_dir"
    ],
    outs = ["version.txt"],
    cmd = """
        $(location @nodejs_host//:node) $(location :src/main.js) > version.txt
    """,
)
