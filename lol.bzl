def _impl(ctx):
    ctx.file("data.txt", content = "hello", executable = False)
    ctx.file("BUILD", content = """
package(default_visibility = ["//visibility:public"])
exports_files(["data.txt"])
    """, executable = False)

lol = repository_rule(
    implementation = _impl,
)


