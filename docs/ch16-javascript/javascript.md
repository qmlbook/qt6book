# JavaScript

JavaScript 是 Web 客户端开发的通用语言。它也主要通过 node.js 开始在 Web 服务器开发中获得关注。因此，作为命令式语言，它是声明式 QML 语言的一个非常合适的补充。QML 本身作为声明式语言用于表达用户界面层级结构，但在表达操作代码方面存在局限。有时你需要一种表达操作的方式，这时 JavaScript 就派上用场了。

::: tip
关于现代 Qt 应用程序中 QML/JS/Qt C++ 的合理比例，Qt 社区一直存在争议。普遍认可的建议是将应用程序中 JS 部分降到最低，业务逻辑放在 Qt C++ 中实现，UI 逻辑放在 QML/JS 中实现。
:::

本书会突破这一边界，但这种做法对产品开发来说并不总是合适的比例，也不适用于每个人。重要的是要结合你的团队技能和个人偏好。如有疑问，请遵循上述建议。

下面是一个简短的示例，展示在 QML 中使用 JS 的样子：

```qml
Button {
  width: 200
  height: 300
  property bool checked: false
  text: "Click to toggle"

  // JS function
  function doToggle() {
    checked = !checked
  }

  onClicked: {
    // this is also JavaScript
    doToggle();
    console.log('checked: ' + checked)
  }
}
```

在 QML 中，JavaScript 可以出现在许多位置：作为独立的 JS 函数、作为 JS 模块，也可以出现在属性绑定的任何右侧。

```qml
import "util.js" as Util // import a pure JS module

Button {
  width: 200
  height: width*2 // JS on the right side of property binding

  // standalone function (not really useful)
  function log(msg) {
    console.log("Button> " + msg);
  }

  onClicked: {
    // this is JavaScript
    log();
    Qt.quit();
  }
}
```

在 QML 中你声明用户界面，用 JavaScript 让它运转起来。那么应该写多少 JavaScript 呢？这取决于你的风格以及你对 JS 开发的熟悉程度。JS 是一种松散类型（loosely typed）的语言，这使得类型缺陷难以发现。此外，函数期望接收所有参数变体，这可能是一个非常难以发现的 bug。发现缺陷的方法是严格的单元测试或验收测试。因此，如果你在 JS 中开发真正的逻辑（而不仅仅是几行胶水代码），你真的应该开始使用测试先行的方法。一般来说，混合团队（Qt/C++ 和 QML/JS）在将前端中作为领域逻辑的 JS 量降到最低、并在后端用 Qt C++ 承担繁重工作时会非常成功。后端应该进行严格的单元测试，这样前端开发者才能信任这些代码，专注于所有细小的用户界面需求。

::: tip
一般而言：后端开发者由功能驱动，前端开发者由用户故事驱动。
:::
