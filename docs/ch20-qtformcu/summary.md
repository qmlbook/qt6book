# 小结

在本章中，我们初步了解了 Qt for MCUs 和 Qt Quick Ultralite。这些技术把 Qt 带到了小得多的平台上，使其真正可嵌入。贯穿本章，我们一直使用虚拟桌面目标（virtual desktop target），它支持快速原型开发。面向某个具体评估板同样简单，但需要拿到硬件以及配套工具。

使用 Qt Quick Ultralite 的关键要点是：内置元素更少，某些 API 也稍受限制。但考虑到其面向的目标系统，这通常并不构成妨碍。Qt Quick Ultralite 还把 QML 变成了一种编译型语言，这其实很好。它让你能在编译期捕获更多错误，而不必在运行时做更多测试。
