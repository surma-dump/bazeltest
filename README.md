# Minimalist JS rules

Current version: `v0.0.0-alpha-incomplete-omg-so-buggy`

# Examples

## Run a script

Run a script in Node that generates output files

```
bazel build //package/js_script
```

## Run a bundler

Invoking a bundler is really just running a script, but it seems useful to make an example.

```
bazel build //package/a_lib
```
