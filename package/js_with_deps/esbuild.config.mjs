import graphqlPlugin from "../../esbuild-graphql-plugin.mjs";

export default {
	plugins: [
		graphqlPlugin()
	],
  jsx: "transform",
  jsxFactory: "h",
  jsxFragment: "Fragment",
  format: "esm",
	minify: false,
}
