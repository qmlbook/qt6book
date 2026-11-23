# 通过 HTTP 提供 UI

要通过 HTTP 加载一个简单的用户界面，我们需要一台提供 UI 文档的 Web 服务器。我们先用一行 Python 命令实现一个自己的简易 Web 服务器。不过首先，我们需要一个演示用的用户界面。为此，在项目文件夹中创建一个小的 `RemoteComponent.qml` 文件，并在其中创建一个红色矩形。

<<< @/docs/ch13-networking/src/serve-qml-basics/RemoteComponent.qml#global

要提供这个文件，可以启动一个小型 Python 脚本：

```sh
cd <PROJECT>
python -m http.server 8080
```

现在应该可以通过 `http://localhost:8080/RemoteComponent.qml` 访问到我们的文件。可以用下面的命令测试：

```sh
curl http://localhost:8080/RemoteComponent.qml
```

或者直接让浏览器指向该位置。可惜的是，浏览器并不理解 QML，无法渲染这份文档。幸运的是，确实存在一种 QML 网页浏览器，它叫 [Canonic](https://www.canonic.com)。Canonic 本身就用 QML 构建，并通过 WebAssembly 在浏览器中运行。不过，如果你使用的是 Canonic 的 WebAssembly 版本，将无法查看从 `localhost` 提供的文件；稍后你会看到如何让你的 QML 文件能被 Canonic 的 WebAssembly 版本使用。如果你愿意，也可以下载代码把 Canonic 作为桌面应用运行，但这样做存在安全方面的顾虑（详见[这里](https://docs.page/canonic/canonic)和[这里](https://doc.qt.io/qt-6/qtqml-documents-networktransparency.html#implications-for-application-security)）。

此外，Qt 6 还提供了 `qml` 可执行文件，它可以像网页浏览器一样使用。用下面的命令可以直接加载远程 QML 文档：

```sh
qml http://localhost:8080/RemoteComponent.qml
```

简单又直接。

::: tip
如果 `qml` 程序不在你的搜索路径（path）中，可以在 Qt 的二进制目录中找到它：`<qt-install-path>/<qt-version>/<your-os>/bin/qml`。
:::

导入远程 QML 文档的另一种方式是用 QML 动态加载它！为此，我们使用 `Loader` 元素来替我们获取远程文档。

<<< @/docs/ch13-networking/src/serve-qml-basics/LocalHostExample.qml#global

现在可以让 `qml` 可执行文件加载本地的 `LocalHostExample.qml` 加载器文档了。

```sh
qml LocalHostExample.qml
```

::: tip
如果你不想运行本地服务器，也可以使用 GitHub 的 gist 服务。gist 是一种类似剪贴板的在线服务，和 Pastebin 等类似，地址是 [https://gist.github.com](https://gist.github.com)。在本例中，我在 [https://gist.github.com/jryannel/7983492](https://gist.github.com/jryannel/7983492) 这个 URL 下创建了一个小的 gist。它会显示一个绿色矩形。由于 gist 的 URL 提供的是 HTML 网页代码，我们需要在 URL 后附加 `/raw` 来获取原始文件，而不是 HTML 代码。

由于这些内容托管在具有公开网址的 Web 服务器上，你现在可以使用基于 Web 的 Canonic 版本来查看它。只需让浏览器指向 [https://app.canonic.com/#http://gist.github.com/jryannel/7983492](https://app.canonic.com/#http://gist.github.com/jryannel/7983492) 即可。当然，要查看你自己的文件，需要修改 `#` 之后的部分。
:::

<<< @/docs/ch13-networking/src/serve-qml-basics/GistExample.qml#global

要让 `RemoteComponent.qml` 从网络上加载另一个文件，需要在服务器上同一目录中创建一个专用的 `qmldir` 文件。完成后，就可以按名称引用该组件了。

## 联网组件

来做个小实验。我们在远程一侧添加一个小按钮，作为可复用的组件。

我们将使用如下目录结构：

```sh
./src/SimpleExample.qml
./src/remote/qmldir
./src/remote/Button.qml
./src/remote/RemoteComponent.qml
```

我们的 `SimpleExample.qml` 与前面的 `main.qml` 示例相同：

<<< @/docs/ch13-networking/src/serve-qml-networked-components/SimpleExample.qml#global

在 `remote` 目录中，我们更新 `RemoteComponent.qml` 文件，让它使用自定义的 `Button` 组件：

<<< @/docs/ch13-networking/src/serve-qml-networked-components/remote/RemoteComponent.qml#global

由于组件托管在远程，QML 引擎需要知道远程还有哪些可用的组件。为此，我们在 `qmldir` 文件中定义远程目录的内容：

<<< @/docs/ch13-networking/src/serve-qml-networked-components/remote/qmldir

最后创建一个占位用的 `Button.qml` 文件：

<<< @/docs/ch13-networking/src/serve-qml-networked-components/remote/Button.qml#global

现在可以启动 Web 服务器了（注意现在有一个 `remote` 子目录）：

```sh
cd src/serve-qml-networked-components/
python -m http.server --directory ./remote 8080
```

以及远程 QML 加载器：

```sh
qml SimpleExample.qml
```

## 导入 QML 组件目录

通过定义 `qmldir` 文件，也可以直接从远程仓库导入一个组件库。为此，使用经典的 import 即可：

<<< @/docs/ch13-networking/src/serve-qml-networked-components/LibraryExample.qml#global

::: tip
使用本地文件系统中的组件时，它们会立即创建，没有延迟。而通过网络加载组件时，它们是异步创建的。其效果是：创建完成的时刻是未知的，某些元素可能尚未完全加载，而另一些已经完成。处理通过网络加载的组件时，请把这一点考虑在内。
:::

::: warning
从互联网加载 QML 组件时一定要格外小心。这样做会有意外下载恶意组件的风险，这些组件可能对你的计算机做坏事。Qt 已经[记录了](https://doc.qt.io/qt-6/qtqml-documents-networktransparency.html#implications-for-application-security)这些安全风险。本页已经给出过 Qt 文档的链接，但这里值得再强调一次这个警告。
:::
