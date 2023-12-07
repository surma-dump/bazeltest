export default {
	plugins: [
		{
			name: "graphql-resolver",
			setup(build) {
			    build.onResolve({ filter: /\.graphql$/ }, ({path, importer}) => {
						path = path.replace(/\.graphql$/, ".js");
						const fullPath = new URL(path, new URL(importer, import.meta.url)).pathname;
						return {path: fullPath};
			    });
			  },
		}
	],
  jsx: "transform",
  jsxFactory: "h",
  jsxFragment: "Fragment",
  format: "esm",
	minify: false,
}
