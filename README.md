# Minimalist JS rules

Current version: `v0.0.0-alpha-incomplete-omg-so-buggy`

# Examples

## Script that generates files

Run a script in Node that generates output files

```
bazel build //package/js_script
```

## Bundling with npm deps

Invoking a bundler is really just running a script, but it seems useful to make an example anyway

```
bazel build //package/a_lib
```

## Run a bundler with workspace deps

Currently, it’s manually symlink’d, but that could easily be automated.

```
bazel build //package/a_lib_with_workspace_deps
```
