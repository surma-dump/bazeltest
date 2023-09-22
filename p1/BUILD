genrule(
	name = "p1",
	srcs = ["run.sh"],
	outs = ["code.json", "lol.txt"],
	cmd = "$(location run.sh) $(RULEDIR)",
)