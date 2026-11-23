# 多媒体

Qt Multimedia 中的多媒体元素使得播放和录制声音、视频或图片等媒体成为可能。解码和编码由特定于平台的后端（backend）处理。例如，Linux 上使用流行的 GStreamer 框架，Windows 上使用 WMF，OS X 和 iOS 上使用 AVFramework，Android 上则使用 Android 多媒体 API。

多媒体元素并不是 Qt Quick 核心 API 的一部分。相反，它们由一个单独的 API 提供，如下所示导入 Qt Multimedia 即可使用：

```qml
import QtMultimedia
```

