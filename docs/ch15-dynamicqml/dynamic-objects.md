## 创建与销毁对象

`Loader` 元素使得动态填充用户界面的一部分成为可能。不过，界面的整体结构仍然是静态的。借助 JavaScript，我们可以再进一步，完全动态地实例化 QML 元素。

在深入动态创建元素的细节之前，我们需要理解其工作流程。从文件甚至互联网加载一段 QML 时，会创建一个组件。该组件封装了解释后的 QML 代码，可用于创建项。这意味着，加载一段 QML 代码并从中实例化项是一个两阶段的过程。首先把 QML 代码解析为组件，然后用该组件实例化实际的项对象。

除了从存储在文件或服务器上的 QML 代码创建元素之外，也可以直接从包含 QML 代码的文本字符串创建 QML 对象。这样动态创建的项在实例化之后，会以类似的方式加以处理。

### 动态加载并实例化项

加载一段 QML 时，它首先会被解释为一个组件。这包括加载依赖并验证代码。被加载 QML 的位置可以是本地文件、Qt 资源，甚至是由 URL 指定的远程网络位置。这意味着加载时间可能从瞬间完成（例如位于 RAM 中、且没有任何未加载依赖的 Qt 资源），到非常漫长（例如位于缓慢的服务器上、且有多个待加载依赖的一段代码）不等。

正在创建的组件的状态可以通过其 `status` 属性来跟踪。可用的值有 `Component.Null`、`Component.Loading`、`Component.Ready` 和 `Component.Error`。通常的流程是 `Null` 到 `Loading` 再到 `Ready`。在任何阶段，`status` 都可能变为 `Error`。此时该组件不能用于创建新的对象实例。`Component.errorString()` 函数可用于获取用户可读的错误描述。

在缓慢的连接上加载组件时，`progress` 属性会派上用场。它的取值范围从 `0.0`（表示尚未加载任何内容）到 `1.0`（表示全部加载完成）。当组件的 `status` 变为 `Ready` 时，该组件就可以用来实例化对象。下面的代码演示了如何做到这一点，既考虑了组件立即就绪或创建失败的情况，也考虑了组件稍后才就绪的情况。

<<< @/docs/ch15-dynamicqml/src/load-component/create-component.js#M1

上面的代码保存在一个单独的 JavaScript 源文件中，由主 QML 文件引用。

<<< @/docs/ch15-dynamicqml/src/load-component/main.qml#M1

如上所示，组件的 `createObject` 函数用于创建对象实例。这不仅适用于动态加载的组件，也适用于内联在 QML 代码中的 `Component` 元素。生成的对象可以像其他对象一样在 QML 场景中使用。唯一的区别是它没有 `id`。

`createObject` 函数接受两个参数。第一个是类型为 `Item` 的 `parent` 对象。第二个是格式为 `{"name": value, "name": value}` 的属性和值列表。下面的例子演示了这一点。请注意，属性参数是可选的。

```js
var image = component.createObject(root, {"x": 100, "y": 100});
```

::: tip
动态创建的组件实例与内联的 `Component` 元素并无不同。内联的 `Component` 元素同样提供了动态实例化对象的函数。
:::

#### 孵化组件

使用 `createObject` 创建对象时，创建过程是阻塞的。这意味着复杂元素的实例化可能会阻塞主线程，造成可见的卡顿。另一种办法是把复杂组件拆分开来，使用 `Loader` 元素分阶段加载。

为了解决这个问题，可以使用 `incubateObject` 方法来实例化组件。它可能像 `createObject` 一样立即返回一个实例，也可能在组件就绪时才回调。根据你的具体设置，这可能是、也可能不是解决与实例化有关的动画卡顿的好办法。

要使用孵化器（incubator），像使用 `createComponent` 一样调用它即可。不过，返回的对象是一个孵化器，而不是对象实例本身。当孵化器的状态为 `Component.Ready` 时，就可以通过孵化器的 `object` 属性获取对象。下面的例子展示了这一切：

```js
function finishCreate() {
    if (component.status === Component.Ready) {
        var incubator = component.incubateObject(root, {"x": 100, "y": 100});
        if (incubator.status === Component.Ready) {
            var image = incubator.object; // Created at once
        } else {
            incubator.onStatusChanged = function(status) {
                if (status === Component.Ready) {
                    var image = incubator.object; // Created async
                }
            };
        }
    }
}
```

### 从文本动态实例化项

有时，能够从一段 QML 文本字符串实例化对象会很方便。即便没有别的理由，它也比把代码放进单独的源文件更快。为此可以使用 `Qt.createQmlObject` 函数。

该函数接受三个参数：`qml`、`parent` 和 `filepath`。`qml` 参数包含要实例化的 QML 代码字符串。`parent` 参数为新创建的对象提供父对象。`filepath` 参数用于报告对象创建过程中的任何错误。函数返回的结果要么是一个新对象，要么是 `null`。

::: warning
`createQmlObject` 函数总是立即返回。要使该函数成功，这次调用的所有依赖都必须已经加载。这意味着，如果传给函数的代码引用了尚未加载的组件，调用就会失败并返回 `null`。为了更好地处理这种情况，必须使用 `createComponent` / `createObject` 的方式。
:::

使用 `Qt.createQmlObject` 函数创建的对象与其他任何动态创建的对象相似。也就是说，除了没有 `id` 之外，它与其他 QML 对象完全相同。在下面的例子中，当 `root` 元素创建完成后，会从内联的 QML 代码实例化一个新的 `Rectangle` 元素。

<<< @/docs/ch15-dynamicqml/src/create-object/main.qml#M1

### 管理动态创建的元素

动态创建的对象可以像 QML 场景中的其他对象一样对待。不过，有一些陷阱需要我们注意。其中最重要的是创建上下文（creation context）的概念。

动态创建的对象的创建上下文，就是创建它时所处的上下文。它不一定与父对象所在的上下文相同。当创建上下文被销毁时，与该对象相关的绑定也会随之销毁。这意味着，务必把动态对象的创建实现在这样的代码位置：该处在对象的整个生命周期内都保持实例化状态。

动态创建的对象也可以被动态销毁。这样做时有一条经验法则：永远不要试图销毁不是你创建的对象。这也包括你创建的、但并非通过 `Component.createObject` 或 `createQmlObject` 这类动态机制创建的元素。

通过调用对象的 `destroy` 函数来销毁对象。该函数接受一个可选参数，是一个整数，指定对象在被销毁之前还应存在多少毫秒。这可以用来，例如，让对象完成最后一次过渡。

```js
item = Qt.createQmlObject(...)
...
item.destroy()
```

::: tip
可以从对象内部销毁它自身，例如借此创建能够自我销毁的弹窗。
:::

