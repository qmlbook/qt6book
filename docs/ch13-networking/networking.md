# 网络

Qt 6 在 C++ 一侧提供了丰富的网络类。例如，在 HTTP 协议层有以请求-响应方式工作的高层类，如 `QNetworkRequest`、`QNetworkReply` 和 `QNetworkAccessManager`；在 TCP/IP 或 UDP 协议层也有较低层的类，如 `QTcpSocket`、`QTcpServer` 和 `QUdpSocket`。此外还有用于管理代理、网络缓存以及系统网络配置的类。

本章并不讨论 C++ 网络编程，而是讨论 Qt Quick 与网络。也就是说，如何让 QML/JS 用户界面直接连接网络服务，或者如何通过网络服务来提供用户界面？关于 Qt/C++ 网络编程，已有许多优秀的书籍和参考资料。接下来只需阅读讲述 C++ 集成的章节，设计一个集成层，把数据馈送到 Qt Quick 的世界即可。
