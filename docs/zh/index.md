---
home: true
heroText: Qt 6 电子书
tagline: 一本关于 Qt 6 的电子书
actionText: 快速上手 →
actionLink: /zh/ch01-meetqt/meet-qt
features:
- title: 跨平台
  details: 其跨平台性质，允许用户使用一种技术和单一代码库将他们的应用程序部署到所有桌面、移动和嵌入式平台
- title: 可扩展
  details: 其可扩展性质从低端的单一用途设备到高端复杂的桌面应用程序或连接系统
- title: 世界一流的 API
  details: 世界一流的 API 和工具以及文档，简化了应用程序和设备的创建
- title: 稳定性
  details: 可维护性、稳定性和兼容性，允许以最少的工作量维护大型代码库
- title: 开发者生态系统
  details: 拥有超过 100 万用户的大型开发者生态系统
- title: Qt 6 发布系列
  details: 使 Qt 成为面向未来的生产力平台

footer: CC-BY-NC Licensed | Copyright © 2021-present J. Ryannel & J. Thelin
---

一个简单的例子

```qml
import QtQuick

Item {
    id: root
    width: 800
    height: 600
    Text {
      anchors.centerIn: parent
      text: "Hello QtQuick!"
    }
}
```
