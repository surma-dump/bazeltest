genrule(
	name = "p1",
	srcs = ["run.sh", "@lol//:data.txt"],
	outs = ["env.txt", "tree.txt"],
	cmd = "$(location :run.sh) $(RULEDIR) $(location :run.sh) $(location @lol//:data.txt)",
	visibility = ["//visibility:public"]
)