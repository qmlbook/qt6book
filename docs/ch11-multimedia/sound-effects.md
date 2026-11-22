# 音效

播放音效时，从请求播放到实际开始播放的响应时间就变得很重要。这种情况下，`SoundEffect` 元素就派上用场了。通过设置 `source` 属性，只需简单调用 `play` 函数即可立即开始播放。

这可以用于点击屏幕时的音频反馈，如下所示。

<<< @/docs/ch11-multimedia/src/sound-effects/basic.qml#global

该元素还可以用来为过渡配上音频。要从过渡中触发播放，需要使用 `ScriptAction` 元素。

下面的示例展示了如何使用音效元素，通过动画为可视状态之间的过渡配上声音：

<<< @/docs/ch11-multimedia/src/sound-effects/complete.qml#global

在这个示例中，每当点击 *Flip!* 按钮时，我们都想对 `Rectangle` 应用一个 180 度的旋转动画。当矩形向不同方向翻转时，我们还想播放不同的声音。

为此，我们首先加载音效：

<<< @/docs/ch11-multimedia/src/sound-effects/complete.qml#effects

然后为矩形定义两个状态 `DEFAULT` 和 `REVERSE`，并为每个状态指定预期的旋转角度：

<<< @/docs/ch11-multimedia/src/sound-effects/complete.qml#states

为了提供状态之间的动画，我们定义了两个过渡：

<<< @/docs/ch11-multimedia/src/sound-effects/complete.qml#transitions

注意 `ScriptAction { script: swosh.play(); }` 这一行。使用 `ScriptAction` 组件，我们可以在动画中运行任意脚本，从而在动画过程中播放所需的音效。

::: tip
除了 `play` 函数之外，还有一些与 `MediaPlayer` 所提供的类似的属性可用，例如 `volume` 和 `loops`。后者可以设置为 `SoundEffect.Infinite` 以实现无限播放。要停止播放，请调用 `stop` 函数。
:::

::: warning
使用 PulseAudio 后端时，`stop` 不会立即停止播放，而只是阻止后续的循环。这是底层 API 的限制所致。
:::

