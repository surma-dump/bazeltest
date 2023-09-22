### Install Bazel

```
brew install bazelisk
```

... or get a binary or something. Check the [Bazel website](https://bazel.build)

### Build

```
bazel build //package/app
```

### Dev

```
bazel run //package/app:dev

ibazel run //package/app:dev
```

[ibazel](https://github.com/bazelbuild/bazel-watcher) is the file watcher that reruns tasks automatically.

### With remote cache:

```
bazel build --remote_cache=http://localhost:8080 //package/app

# Same, but the cache is read-only.
bazel build --remote_upload_local_results=false --remote_cache=http://localhost:8080 //package/app
```

I used [bazel-remote](https://github.com/buchgr/bazel-remote) as a quick cache server.
