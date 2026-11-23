# 限制

目前，有些事情还无法方便地实现。其中之一是无法方便地使用 Python 创建 QML 插件。作为替代，你需要把这些 Python QML“模块”导入到 Python 程序中，然后使用 qmlRegisterType，使它们可以从 QML 导入。

