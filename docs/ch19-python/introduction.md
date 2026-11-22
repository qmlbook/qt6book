# 简介

Qt for Python 项目提供了将 C++ 和 Qt 绑定到 Python 的工具，以及一套完整的面向 Qt 的 Python API。这意味着，凡是能用 Qt 和 C++ 完成的事情，也都可以用 Qt 和 Python 完成，范围从无界面服务（headless services）到基于窗口部件的用户界面。本章将重点介绍如何集成 QML 和 Python。

目前，Qt for Python 支持所有桌面平台，但不支持移动平台。根据所用平台的不同，Python 的配置略有差异；不过，只要搭建好 [Python](https://www.python.org/) 和 [PyPA](https://www.pypa.io/en/latest/) 环境，就可以使用 `pip` 安装 Qt for Python。这一点稍后会详细讨论。

由于 Qt for Python 项目为 Qt 提供了一套全新的语言绑定（language binding），它也配套了全新的文档。在探索这个模块时，了解以下资源会很有帮助。


* 参考文档：[https://doc.qt.io/qtforpython/](https://doc.qt.io/qtforpython/)
* Qt for Python wiki：[https://wiki.qt.io/Qt_for_Python](https://wiki.qt.io/Qt_for_Python)
* 注意事项：[https://wiki.qt.io/Qt_for_Python/Considerations](https://wiki.qt.io/Qt_for_Python/Considerations)

Qt for Python 的绑定是使用 Shiboken 工具生成的。有时也值得阅读它的相关资料，以便理解背后发生的事情。查找 Shiboken 信息的首选位置是[参考文档](https://doc.qt.io/qtforpython/shiboken6/index.html)。如果你想把自己的 C++ 代码与 Python 和 QML 混合使用，Shiboken 就是你需要的工具。

::: tip
本章全程使用 Python 3.7。
:::

