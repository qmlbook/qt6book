# 播放媒体

在 QML 应用程序中集成多媒体，最基本的场景就是播放媒体。`QtMultimedia` 模块通过提供一个专用的 QML 组件来支持这一功能：`MediaPlayer`。

`MediaPlayer` 组件是一个非可视项，它将媒体源连接到一个或多个输出通道。根据媒体的性质（即音频、图像或视频），可以配置不同的输出通道。

## 播放音频

在下面的示例中，`MediaPlayer` 在一个空窗口中播放来自远程 URL 的 mp3 示例音频文件：

<<< @/docs/ch11-multimedia/src/playback-audio/main.qml#global

在这个示例中，`MediaPlayer` 定义了两个属性：

- `source`：包含要播放的媒体的 URL。它可以是内嵌的（`qrc://`）、本地的（`file://`）或远程的（`https://`）。
- `audioOutput`：包含一个音频输出通道 `AudioOutput`，它连接到物理输出设备。默认情况下，它会使用系统的默认音频输出设备。

一旦主组件完成初始化，就会调用播放器的 `play` 函数：

<<< @/docs/ch11-multimedia/src/playback-audio/main.qml#play


## 播放视频

如果要播放图片或视频这类可视媒体，还必须定义一个 `VideoOutput` 元素，以便将输出的图像或视频放入用户界面。

在下面的示例中，`MediaPlayer` 播放来自远程 URL 的 mp4 示例视频文件，并将视频内容在窗口中居中显示：

<<< @/docs/ch11-multimedia/src/playback-video/main.qml#global

在这个示例中，`MediaPlayer` 定义了第三个属性：

- `videoOutput`：包含视频输出通道 `VideoOutput`，它表示在用户界面中为显示视频而保留的可视区域。

::: tip
请注意，`VideoOutput` 组件是一个可视项。因此，务必在可视组件层级结构中创建它，而不要在 `MediaPlayer` 内部创建。
:::


## 控制播放

`MediaPlayer` 组件提供了若干有用的属性。例如，可以使用 `duration` 和 `position` 属性来构建进度条。如果 `seekable` 属性为 `true`，甚至可以在点击进度条时更新 `position`。

还可以利用 `AudioOutput` 和 `VideoOutput` 的属性来自定义体验，例如提供音量控制。

下面的示例为播放添加了自定义控制：

* 一个音量滑块
* 一个播放/暂停按钮
* 一个进度滑块

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#global

### 音量滑块
在窗口右上角添加了一个垂直的 `Slider` 组件，让用户可以控制媒体的音量：

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#volume-slider

然后把 `AudioOutput` 的音量属性映射到滑块的值：

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#audio-output

### 播放 / 暂停

一个 `Button` 组件反映媒体的播放状态，并允许用户控制这一状态：

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#button

根据播放状态的不同，按钮上会显示不同的文本。点击按钮会触发相应的动作，播放或暂停媒体。

::: tip
可能的播放状态如下：
* `MediaPlayer.PlayingState`：媒体当前正在播放。
* `MediaPlayer.PausedState`：媒体播放已暂停。
* `MediaPlayer.StoppedState`：媒体播放尚未开始。
:::


### 可交互的进度滑块

添加一个 `Slider` 组件来反映当前的播放进度。它也允许用户控制当前的播放位置。

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#progress-slider{5,6,19-21}

关于这个示例，有几点需要注意：
* 仅当媒体可定位（`seekable`）时，该滑块才可用（第 5 行）
* 它的值会被设置为当前的媒体进度，即 `player.position / player.duration`（第 6 行）
* 当用户移动滑块时，媒体位置 *（也）* 会被更新（第 19-21 行）

## 媒体状态

使用 `MediaPlayer` 构建媒体播放器时，最好监视播放器的 `status` 属性。下面是可能状态的枚举，取值范围从 `MediaPlayer.Buffered` 到 `MediaPlayer.InvalidMedia`。可能的取值总结如下：

* `MediaPlayer.NoMedia`。未设置任何媒体。播放已停止。
* `MediaPlayer.Loading`。媒体正在加载。
* `MediaPlayer.Loaded`。媒体已加载。播放已停止。
* `MediaPlayer.Buffering`。媒体正在缓冲数据。
* `MediaPlayer.Stalled`。媒体缓冲数据时播放被中断。
* `MediaPlayer.Buffered`。媒体已缓冲，这意味着播放器可以开始播放该媒体。
* `MediaPlayer.EndOfMedia`。已到达媒体末尾。播放已停止。
* `MediaPlayer.InvalidMedia`。媒体无法播放。播放已停止。
* `MediaPlayer.UnknownStatus`。媒体状态未知。

如上面的要点所述，播放状态会随时间变化。调用 `play`、`pause` 或 `stop` 会改变状态，但所播放的媒体本身也会产生影响。例如，可能已到达末尾，或者媒体无效，从而导致播放停止。

::: tip
也可以让 `MediaPlayer` 循环播放某个媒体项。`loops` 属性控制 `source` 被播放的次数。将该属性设置为 `MediaPlayer.Infinite` 会无限循环。非常适合持续播放的动画或循环播放的背景歌曲。
:::
