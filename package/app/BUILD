genrule(
    name = "node_modules_tar",
    srcs = [
        "package.json",
        "package-lock.json"
    ],
    tools = [
        "@nodejs_host//:npm"
    ],
    outs = ["node_modules.tar"],
    cmd = """
        NPM=$$(readlink -f $(location @nodejs_host//:npm))
        OUT=$$(echo $$PWD/$(location :node_modules.tar))
        PKGDIR=$$(dirname $$(echo $$PWD/$(location :package.json)))
        cd $$PKGDIR
        $$NPM ci
        tar -cf $$OUT node_modules
    """,
)

genrule(
    name = "app",
    tools = [
        "@nodejs_host//:node"
    ],
    srcs = [
        "src/main.js",
        "package.json",
        ":node_modules_tar"
    ],
    outs = ["version.txt"],
    cmd = """
        NODE=$$(readlink -f $(location @nodejs_host//:node))
        PKGDIR=$$(dirname $$(echo $$PWD/$(location :package.json)))
        TAR=$$(readlink -f $(location :node_modules_tar))
        OUT=$$(echo $$PWD/$(location :version.txt))
        cd $$PKGDIR
        tar -xf $(location :node_modules_tar)
        $(location @nodejs_host//:node) $(location :src/main.js) > $$OUT
    """,
)
