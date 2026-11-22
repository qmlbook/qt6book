# 简体中文术语表（GLOSSARY.zh-CN.md）

本文件是全书翻译的术语与大小写约定。新增术语决策必须先登记到本表，
再在正文中广泛使用；不得在未记录的情况下引入竞争性译法。

## 受保护名称（不翻译，保持原大小写）

- `Qt`、`Qt 6`、`QML`、`Qt Quick`、`Qt Quick Controls`
- `C++`、`JavaScript`、`CMake`、`VuePress`
- `QObject`、`Q_PROPERTY`、`Q_INVOKABLE`
- 一切类名、类型名、属性名、信号名、方法名、枚举名、模块名、命名空间名
- QML 类型，如 `Item`、`Rectangle`、`Text`、`ApplicationWindow`、`Button`、
  `TextField`、`ListView`、`RowLayout`、`ColumnLayout`

标识符即使形如普通英文单词也不翻译。

## 核心术语

| English | 简体中文 | 备注 |
| --- | --- | --- |
| property | 属性 | |
| property binding | 属性绑定 | 与“属性赋值”严格区分 |
| property assignment | 属性赋值 | |
| signal | 信号 | |
| signal handler | 信号处理器 | |
| slot | 槽 | |
| component | 组件 | |
| object | 对象 | |
| type | 类型 | QML 类型与对象实例严格区分 |
| element | 元素 | |
| visual item | 可视项 | |
| anchor | 锚点 | |
| attached property | 附加属性 | |
| grouped property | 分组属性 | |
| model | 模型 | |
| view | 视图 | |
| delegate | 委托 | |
| scene graph | 场景图 | |
| layout | 布局 | |
| state | 状态 | |
| transition | 过渡 | |
| animation | 动画 | |
| property alias | 属性别名 | |
| root object | 根对象 | |
| parent object | 父对象 | |
| child object | 子对象 | |
| build system | 构建系统 | |
| kit | 构建套件 | Qt Creator 语境 |

## 首次出现标注约定

技术概念首次出现时可用 `中文（English）` 便于对照识别；其后不再重复附注英文。

## 标点与排版

- 中文行文使用全角标点。
- 代码、命令、URL、文件名、标识符内的标点保持原样。


## 扩展术语（B01–B05 提案，父代理已合并）

| English | 简体中文 | 备注 |
| --- | --- | --- |
| module | 模块 | |
| enumeration | 枚举 | |
| user interface | 用户界面 | |
| graphical user interface / GUI | 图形用户界面（GUI） | 首次括注缩写 |
| software interface | 接口 | API 语境 |
| front-end / back-end | 前端 / 后端 | |
| declarative | 声明式 | |
| root type | 根类型 | 泛指根对象类型时沿用原文用词 |
| sibling (object) | 同级对象 | |
| widget | 窗口部件 | Qt Widgets 语境；Qt Quick Controls 的 control 译「控件」 |
| console application | 控制台应用程序 | |
| event loop | 事件循环 | |
| runtime | 运行时 | |
| scope | 作用域 | |
| layout manager | 布局管理器 | |
| graphics view / scene / item | 图形视图 / 图形场景 / 图形项 | Qt Graphics View 框架 |
| string list model | 字符串列表模型 | |
| table model | 表模型 | |
| sort filter proxy model | 排序过滤代理模型 | |
| schema | 模式（schema） | 数据库语境 |
| context property | 上下文属性 | |
| root context | 根上下文 | |
| touch user interface | 触摸用户界面 | |
| connected devices | 联网设备 | |
| workflow | 工作流 | |
| markup language | 标记语言 | |
| building blocks | 构建块 | |
| cross-platform | 跨平台 | |
| scalability | 可伸缩性 | 与「可扩展性」区分 |
| code base | 代码库 | |
| release series | 发布系列 | |
| developer ecosystem | 开发者生态系统 | |
| know-how | 专业知识 | |
| change management | 变更管理 | |
| Qt Essentials Modules | Qt 必备模块 | 首次括注英文原名 |
| Qt Add-On Modules | Qt 附加模块 | 首次括注英文原名 |
| Qt Platform Abstraction | Qt 平台抽象 | |
| Component Marketplace | 组件市场 | |
| UX designer | UX 设计师 | |
| IDE | 集成开发环境（IDE） | |
| mode（Qt Creator UI 模式） | 模式 | 欢迎/编辑/设计/调试/项目/分析/帮助模式，首次括注英文 UI 名 |
| mode selector | 模式选择器 | |
| session | 会话（session） | Qt Creator 语境 |
| output pane | 输出面板 | |
| cross-compiler | 交叉编译器 | |
| syntax highlighting | 语法高亮 | |
| code completion | 代码补全 | |
| quick-fix | 快速修复 | |
| code refactoring | 代码重构 | |
| plug-in / plugin | 插件 | |
| stub | 桩代码 | |
| wizard | 向导 | |
| template（项目模板） | 模板 / 应用模板 | 向导内模板名保持英文 |
| console | 控制台 | |
| wildcard | 通配符 | |
| shortcut | 快捷键 | |
| settings dialog | 设置对话框 | |
| pop-up | 弹窗 | |
| profiling | 性能分析 | |
| memory leak | 内存泄漏 | |
| Locator | Locator（定位器） | Qt Creator 产品名保留英文，首次括注 |
| follow symbol | 跟进符号 | |
| Summary（章节标题） | 小结 | |
| Quick Start（标题） | 快速入门 | |
| Build from Source（标题） | 从源码构建 | |

## 专有名称决策

- The Qt Company、Qt Project、Qt Wiki：保持英文，作为专有名称处理。
- Hello World（示例程序名，对应 `HelloWorld.qml`）：保持英文。
- Qt Creator 各 UI 模式名（Welcome/Edit/Design/Debug/Projects/Analyze/Help）：
  中文模式名 + 首次括注英文 UI 名。
- 项目模板名、向导 UI 名：保持英文。
- 快捷键键名（Ctrl、Shift、Alt、功能键）：保持英文。
## 待决术语

（暂无。翻译过程中若出现表中未覆盖且影响一致性的术语，在此登记后使用。）
