# 高级技巧

## QML 的性能

QML 和 JavaScript 是解释型语言。这意味着它们在执行前不必经过编译器处理，而是运行在执行引擎中。不过由于解释执行开销较大，人们采用了多种技术来提升性能。

QML 引擎使用即时编译（just-in-time compilation，JIT）来提升性能。它还缓存中间输出，避免重复编译。作为开发者，这一切对你来说是无缝的。唯一的痕迹是源文件旁会出现以 `qmlc` 和 `jsc` 结尾的文件。

如果想避免初始解析带来的启动开销，也可以预编译你的 QML 和 JavaScript。这要求你把代码放进 Qt 资源文件，详见 Qt 文档中的[提前编译 QML](https://doc.qt.io/qt-6/qtquick-deployment.html#ahead-of-time-compilation)一章。
