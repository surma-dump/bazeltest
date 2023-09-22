genrule(
	name = "p1",
	srcs = ["run.sh"],
	outs = ["env.txt", "tree.txt"],
	cmd = "$(location :run.sh) $(RULEDIR) $< $(location :run.sh)",
	visibility = ["//visibility:public"]
)