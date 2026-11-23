# Qt for MCUs

::: tip 注意
Qt for MCUs 并不是开源 Qt 发行版的一部分，而是一个商业附加组件。
:::

Qt for MCUs 是一个把 Qt 带到运行不了 Linux 的过小平台的 Qt 版本。Qt for MCUs 可以运行在 FreeRTOS 之上，甚至可以跑在裸机（bare metal）上，也就是完全不涉及任何操作系统。由于本书聚焦于 QML，我们将深入探讨 Qt Quick Ultralite，并把它与完整版的 Qt 产品进行比较。

使用 Qt for MCUs，你可以为基于微控制器（microcontroller）的系统构建精美、流畅的图形用户界面。Qt for MCUs 专注于图形前端，因此它不使用传统的 Qt 模块，而是使用常见的 C++ 类型。这意味着某些接口会发生变化，其中最显著的是模型暴露给 QML 的方式。本章将深入探讨这一点以及更多内容。
