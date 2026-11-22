# Qt6 Book

*Copyright(C) 2012-2021 Johan Thelin and Jürgen Bocklage-Ryannel*

Qt6 书籍（基于 QmlBook）的新家

> 本仓库为简体中文翻译版；翻译说明、术语表与进度见 [README.zh-CN.md](README.zh-CN.md)。

你可以随时在 [https://www.qt.io/product/qt6/qml-book](https://www.qt.io/product/qt6/qml-book) 找到本书最新发布版本的构建成果，最新快照则位于 [https://distracted-dijkstra-f5d508.netlify.app/](https://distracted-dijkstra-f5d508.netlify.app/)。

# 目录

1. 在本地构建本书
2. 构建发布版本
3. 致审阅者
4. 致作者

# 1. 在本地构建本书

全书内容使用 [VuePress](https://vuepress.vuejs.org/) 构建为静态站点，包管理使用 [Yarn](https://yarnpkg.com/)。

要在本地构建内容，运行：

```
$ yarn
$ yarn run docs:dev
```

然后访问 [localhost:8080](http://localhost:8080) 阅读本书。

要构建示例程序，运行：

```
$ yarn run examples:build
```

这会在 `_examples/` 目录中生成构建产物。它假定 CMake 能够找到 Qt6。我在一台 Debian Linux 机器上的典型命令行如下：

```
$ CMAKE_PREFIX_PATH=/path/to/Qt/6.2.0/gcc_64/lib/cmake/ yarn run examples:build
```

后续调用无需再指定 `CMAKE_PREFIX_PATH`。

# 2. 构建发布版本

要构建发布版本，先构建文档，再把示例打包为 tar 压缩包：

```
$ yarn run docs:build
$ yarn run examples:package
```

这会在你的包根目录生成 `examples.tar.gz`，同时生成 VuePress 的输出，即 `docs/.vuepress/dist/`。

请注意 `examples:package` 命令假定 VuePress 的 `dist/` 目录已经存在。

# 3. 致审阅者

请从 [Project Board](https://github.com/qmlbook/qt6book/projects/1) 中挑选要审阅的章节，也可以关注项目中标记为 [Questions](https://github.com/qmlbook/qt6book/issues?q=is%3Aissue+is%3Aopen+label%3Aquestion) 的议题。

欢迎以 issue 或 pull request 的形式提交审阅意见——选择对你来说最方便的方式即可！

# 4. 致作者

各章节的结构在 `docs/.vuepress/config.js` 中定义。请分别将章节标记为 `Qt5`、`Qt6 Draft` 和 `Qt 6`。
