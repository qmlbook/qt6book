# Qt 6 书籍简体中文翻译

本仓库是 [qmlbook/qt6book](https://github.com/qmlbook/qt6book)（Qt 6 Book）的
简体中文翻译工作区。

## 来源与归属

- 上游仓库：<https://github.com/qmlbook/qt6book.git>
- 上游默认分支：`main`
- 翻译基线提交：`3e7d97a5a11f368a3b9f58ace3fd6e70cb461282`
- 原作者：Johan Thelin、Jürgen Bocklage-Ryannel
  （`Copyright(C) 2012-2021 Johan Thelin and Jürgen Bocklage-Ryannel`）
- 翻译分支：`translation/zh-CN`
- 初始化日期：2026-11-22

英文原版始终可以在上游仓库中找到。本书最新发布版本位于
<https://www.qt.io/product/qt6/qml-book>。

## 许可证声明

翻译沿用上游仓库的许可条款，未改变原文的版权归属：

- 正文文本：Creative Commons Attribution-NonCommercial-ShareAlike 4.0
  International（见 `LICENSE.text`）
- 示例代码：BSD 3-Clause License（见 `LICENSE.code`）
- 其余例外许可见 `LICENSE.md`
  （例如 `docs/ch12-qtquick3d/src/basicmaterials/maps/skybox.jpg` 采用
  CC BY-SA 3.0）

简体中文翻译内容同样按上述条款发布。翻译不改变、不替换任何 `LICENSE*`
文件或版权声明。

## 构建方法

依赖使用 [Yarn](https://yarnpkg.com/) 管理，文档使用
[VuePress](https://vuepress.vuejs.org/) 构建。与上游 README 一致：

```bash
# 安装依赖（使用现有 yarn.lock，勿升级依赖）
yarn

# 本地预览
yarn run docs:dev
# 然后访问 http://localhost:8080

# 构建静态文档站点
yarn run docs:build
# 输出位于 docs/.vuepress/dist/
```

构建示例程序（需要 Qt 6 与 CMake，与翻译无关）：

```bash
yarn run examples:build
```

## 在线阅读

本书已通过 GitHub Actions 自动部署到 GitHub Pages：

**https://bgllj.github.io/qt6book-zh/**


## 翻译状态

翻译进度、审查状态、构建记录见仓库根目录的 `TRANSLATION_STATUS.md`。
术语约定见 `GLOSSARY.zh-CN.md`。

当前状态：全部章节翻译与独立复核已完成，最终审计与构建通过（详见 TRANSLATION_STATUS.md）。

## 翻译约定摘要

- 目标读者：懂基础 C++、几乎没有 Qt/QML 经验的中文学习者。
- 保持技术含义忠实于上游基线提交，行文使用自然的简体中文。
- 代码、命令、URL、API 名称、文件名、标识符一律不翻译。
- QML 类型名（如 `Item`、`Rectangle`、`Button`）保持英文原样。
- 核心术语以 `GLOSSARY.zh-CN.md` 为准。
