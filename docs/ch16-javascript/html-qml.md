# 浏览器/HTML 与 Qt Quick/QML 的对比

浏览器是渲染 HTML 并执行与之关联的 JavaScript 的运行时。如今，现代 Web 应用程序中 JavaScript 的含量远超 HTML。浏览器中的 JavaScript 是一个标准的 ECMAScript 环境，并附带一些浏览器 API。浏览器中典型的 JS 环境有一个名为 `window` 的全局对象，用于与浏览器窗口交互（标题、位置 URL、DOM 树等）。浏览器提供了按 id、class 等访问 DOM 节点的函数（jQuery 曾利用这些函数提供 CSS 选择器功能），最近还支持直接通过 CSS 选择器访问（`querySelector`、`querySelectorAll`）。此外，还可以在一段时间后调用某个函数（`setTimeout`）以及重复调用某个函数（`setInterval`）。除了这些（以及其他浏览器 API）之外，该环境与 QML/JS 类似。

另一个区别是 JS 在 HTML 和 QML 中的出现方式。在 HTML 中，你只能在初始页面加载期间或事件处理器（例如页面加载完成、鼠标按下）中执行 JS。例如，你的 JS 通常在页面加载时初始化，这与 QML 中的 `Component.onCompleted` 类似。默认情况下，你不能在浏览器中将 JS 用于属性绑定（AngularJS 扩展了 DOM 树以支持这种用法，但这与标准 HTML 相去甚远）。

在 QML 中，JS 更像是一等公民，并且更深入地集成到 QML 渲染树中。这使得语法更具可读性。除了这些差异之外，开发过 HTML/JS 应用程序的人在使用 QML/JS 时应该会感到得心应手。
