# Qt6 Book

*Copyright(C) 2012-2021 Johan Thelin and Jürgen Bocklage-Ryannel*

The new home for the Qt6 book (based on QmlBook)

You can always find the latest released version of the book built at [https://www.qt.io/product/qt6/qml-book](https://www.qt.io/product/qt6/qml-book), and the latest snapshot at [https://distracted-dijkstra-f5d508.netlify.app/](https://distracted-dijkstra-f5d508.netlify.app/).

# Contents

1. Building the Book Locally
2. Building for Release
3. For Reviewers
4. For Authors

# 1. Building the Book Locally

The contents is built into a static site using [VuePress](https://vuepress.vuejs.org/). The packages are managed using [Yarn](https://yarnpkg.com/).

To build the contents locally, run:

```
$ yarn
$ yarn run docs:dev
```

Then visit [localhost:8080](http://localhost:8080) to view the book.

To build the examples, run:

```
$ yarn run examples:build
```

This will create the `_examples/` directory with the build. It assumes Qt6 can be found by CMake. My typical command line on a Debian Linux machine looks like this:

```
$ CMAKE_PREFIX_PATH=/path/to/Qt/6.2.0/gcc_64/lib/cmake/ yarn run examples:build
```

Subsequent calls do not need `CMAKE_PREFIX_PATH` to be specified.

# 2. Building for Release

To build for release, first build the docs, then package the examples into a tar-ball:

```
$ yarn run docs:build
$ yarn run examples:package
```

This creates `examples.tar.gz` in your package root, as well as where VuePress places the output, i.e. `docs/.vuepress/dist/`.

Notice that the `examples:package` command assumes that the VuePress `dist/` directory exists.

# 3. For Reviewers

Pick chapters to review from the [Project Board](https://github.com/qmlbook/qt6book/projects/1). Also look for issues tagged as [Questions](https://github.com/qmlbook/qt6book/issues?q=is%3Aissue+is%3Aopen+label%3Aquestion) in the project.

Reviews are welcome both as issues, or as pull requests. Pick the approach that is the easiest for you!

# 4. For Authors

Chapters are outlined in `docs/.vuepress/config.js`. Please tag chapters as `Qt5`, `Qt6 Draft`, and `Qt 6` respectively.
