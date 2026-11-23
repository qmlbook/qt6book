# 视频流

`VideoOutput` 元素并不限于与 `MediaPlayer` 元素配合使用。它还可以与各种视频源配合使用，以显示视频流。

例如，我们可以用 `VideoOutput` 来显示用户 `Camera` 的实时视频流。为此，我们将把它与两个组件结合起来：`Camera` 和 `CaptureSession`。

<<< @/docs/ch11-multimedia/src/camera-capture/basic.qml#global

`CaptureSession` 组件提供了一种简单的方式来读取摄像头流、捕获静态图像或录制视频。

与 `MediaPlayer` 组件一样，`CaptureSession` 元素也提供了一个 `videoOuput` 属性。因此我们可以用这个属性来配置自己的可视组件。

最后，当应用程序加载完成后，就可以启动摄像头录制：

```qml
Component.onCompleted: captureSession.camera.start()
```

::: tip
根据操作系统的不同，这个应用程序可能需要敏感的访问权限。如果你使用 `qml` 可执行文件运行本示例应用程序，这些权限会被自动请求。

不过，如果你把它作为独立程序运行，可能需要先申请这些权限（例如：在 MacOS 下，需要一个与应用程序打包在一起的专用 .plist 文件）。
:::
