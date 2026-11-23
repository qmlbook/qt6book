# 本地文件

也可以使用 XMLHttpRequest 加载本地的（XML/JSON）文件。例如，名为 “colors.json” 的本地文件可以这样加载：

```js
xhr.open("GET", "colors.json")
```

我们用它来读取一张颜色表并以网格形式显示。无法从 Qt Quick 一侧修改这个文件。若要把数据存回源文件，我们需要一个基于 REST 的小型 HTTP 服务器，或者一个用于文件访问的原生 Qt Quick 扩展。

<<< @/docs/ch13-networking/src/localfiles/localfiles.qml#global

:::tip
默认情况下，QML 引擎禁止对本地文件使用 GET。要解除这一限制，可以将 `QML_XHR_ALLOW_FILE_READ` 环境变量设为 `1`：

```sh
QML_XHR_ALLOW_FILE_READ=1 qml localfiles.qml
```

问题在于，允许 QML 应用通过 `XMLHttpRequest`（即 `XHR`）读取本地文件，会开放整个文件系统供其读取，这是一个潜在的安全问题。只有设置了该环境变量，Qt 才会允许读取本地文件，因此这必须是一个有意识的决定。
:::

除了使用 `XMLHttpRequest`，也可以使用 XmlListModel 来访问本地文件。

<<< @/docs/ch13-networking/src/localfiles/localfilesxmlmodel.qml#global

XmlListModel 只能读取 XML 文件，不能读取 JSON 文件。
