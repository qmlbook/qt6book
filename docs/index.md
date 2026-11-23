---
home: true
heroText: Qt 6 Book
tagline: 一本关于 Qt 6 的书
actionText: 开始阅读 →
actionLink: /ch01-meetqt/meet-qt
features:
- title: 跨平台
  details: 跨平台特性让开发者能够使用同一技术、从单一代码库出发，将应用部署到所有的桌面、移动和嵌入式平台
- title: 可伸缩性
  details: 可伸缩性从低端的单一用途设备，一直延伸到高端复杂的桌面应用或联网系统
- title: 世界级 API
  details: 世界级的 API、工具和文档，简化了应用与设备的创建
- title: 稳定性
  details: 可维护性、稳定性与兼容性，可以用极少的精力维护大型代码库
- title: 开发者生态系统
  details: 庞大的开发者生态系统，拥有超过一百万用户
- title: Qt 6 发布系列
  details: 让 Qt 成为面向未来的生产力平台

footer: CC-BY-NC 许可 | Copyright © 2021-present J. Ryannel & J. Thelin
---

就这么简单：

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
