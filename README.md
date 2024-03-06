### Install dependencies

```sh
pnpm
```

### Build

```sh
npx bazel build :app
```

### Dev

```sh
npx bazel run :dev
```

[ibazel](https://github.com/bazelbuild/bazel-watcher) is the file watcher that reruns tasks automatically.

```
npx ibazel run :dev
```
