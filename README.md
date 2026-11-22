# Qt6 Book

*Copyright(C) 2012-2021 Johan Thelin and Jürgen Bocklage-Ryannel*

Qt 6 书籍（基于 QmlBook）的简体中文翻译版。

> **在线阅读：<https://bgllj.github.io/qt6book-zh/>**（GitHub Pages 自动部署）
>
> 翻译说明、术语表与进度见 [README.zh-CN.md](README.zh-CN.md)。

## 关于本书

本书面向懂基础 C++、几乎没有 Qt/QML 经验的中文学习者，从 Qt 与 Qt Quick 的整体概念讲起，覆盖 QML 语法、核心元素、组件、布局与定位、动画与状态、Qt Quick Controls、模型-视图、Canvas 绘图、形状、粒子特效、多媒体、Qt Quick 3D、网络、存储、动态 QML、JavaScript、Qt C++、扩展 QML、Qt for Python 与 Qt for MCUs 等内容。

英文原版的最新发布版本始终可以在 [https://www.qt.io/product/qt6/qml-book](https://www.qt.io/product/qt6/qml-book) 找到，最新快照位于 [https://distracted-dijkstra-f5d508.netlify.app/](https://distracted-dijkstra-f5d508.netlify.app/)，源文件见 [上游仓库 qmlbook/qt6book](https://github.com/qmlbook/qt6book)。

## 阅读导航

在线站点按章节组织，从首页侧边栏进入，或直接访问各章首页，例如：

- 前言 · 认识 Qt · 入门 · Qt Creator 集成开发环境
- QML 快速入门 · 流畅元素 · Qt Quick Controls · 模型-视图-委托
- Canvas 元素 · 形状 · 特效 · 多媒体 · Qt Quick 3D · 网络 · 存储
- 动态 QML · JavaScript · Qt 与 C++ · 使用 C++ 扩展 QML · Qt for Python · Qt for MCUs

# 1. 在本地构建本书

全书内容使用 [VuePress](https://vuepress.vuejs.org/) 构建为静态站点，包管理使用 [Yarn](https://yarnpkg.com/)。

要在本地构建内容，运行：

```
$ yarn
$ yarn run docs:dev
```

然后访问 [localhost:8080/qt6book-zh/](http://localhost:8080/qt6book-zh/) 阅读本书（站点配置了 `/qt6book-zh/` 子路径以适配 GitHub Pages）。

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

在线站点由 GitHub Actions 在每次推送 `main` 分支时自动构建并发布（见 `.github/workflows/deploy-docs.yml`）。

# 3. 参与上游项目

请从 [Project Board](https://github.com/qmlbook/qt6book/projects/1) 中挑选要审阅的章节，也可以关注项目中标记为 [Questions](https://github.com/qmlbook/qt6book/issues?q=is%3Aissue+is%3Aopen+label%3Aquestion) 的议题。

欢迎以 issue 或 pull request 的形式提交审阅意见——选择对你来说最方便的方式即可！

各章节的结构在 `docs/.vuepress/config.js` 中定义。请分别将章节标记为 `Qt5`、`Qt6 Draft` 和 `Qt 6`。

# 4. 翻译与许可

- 翻译来源、归属、术语表与翻译状态：见 [README.zh-CN.md](README.zh-CN.md) 与 [TRANSLATION_STATUS.md](TRANSLATION_STATUS.md)。
- 正文文本采用 Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International（`LICENSE.text`），示例代码采用 BSD 3-Clause（`LICENSE.code`），其余例外见 `LICENSE.md`。
- 原作者与版权归属不变：Copyright(C) 2012-2021 Johan Thelin and Jürgen Bocklage-Ryannel。
