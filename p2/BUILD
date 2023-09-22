genrule(
	name = "p2",
	srcs = ["run.sh", "//p1:env.txt", "//p1:tree.txt"],
	outs = ["env.txt", "tree.txt"],
	cmd = "$(location :run.sh) $(RULEDIR) $(location :run.sh) $(location //p1:env.txt)",
	visibility = ["//visibility:public"]
)