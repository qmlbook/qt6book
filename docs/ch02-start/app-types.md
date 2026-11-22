# 应用程序类型

本节概览用 Qt 6 可以编写的不同应用程序类型。并不局限于这里介绍的这些类型，但能让你对用 Qt 6 通常能实现什么有更清楚的认识。

## 控制台应用程序

控制台应用程序不提供图形用户界面（GUI），通常作为系统服务的一部分被调用，或从命令行调用。Qt 6 提供了一系列现成的组件，帮助你非常高效地创建跨平台控制台应用程序。例如网络与文件 API、字符串处理，以及高效的命令行解析器。由于 Qt 是构建在 C++ 之上的高层 API，你既能获得编程效率，又能获得运行速度。不要把 Qt 看作*仅仅*是一个 UI 工具包——它能提供的远不止这些！

### 字符串处理

第一个示例演示如何将 2 个常量字符串相加。诚然，这不是一个很有用的应用程序，但能让你了解一个没有事件循环的原生 C++ 应用程序可能是什么样子。

```cpp
// module or class includes
#include <QtCore>

// text stream is text-codec aware
QTextStream cout(stdout, QIODevice::WriteOnly);

int main(int argc, char** argv)
{
    // avoid compiler warnings
    Q_UNUSED(argc)
    Q_UNUSED(argv)
    QString s1("Paris");
    QString s2("London");
    // string concatenation
    QString s = s1 + " " + s2 + "!";
    cout << s << Qt::endl;
}
```

### 容器类

这个示例在应用程序中加入了列表以及列表迭代。Qt 提供了大量易于使用的容器类，它们与其他 Qt 类遵循相同的 API 范式。

```cpp
QString s1("Hello");
QString s2("Qt");
QList<QString> list;
// stream into containers
list << s1 << s2;
// Java and STL like iterators
QListIterator<QString> iter(list);
while(iter.hasNext()) {
    cout << iter.next();
    if(iter.hasNext()) {
        cout << " ";
    }
}
cout << "!" << Qt::endl;
```

这里是一个更高级的列表函数，它可以把一个字符串列表连接成单个字符串。当你需要按行处理文本输入时，这非常方便。反向操作（从字符串得到字符串列表）同样可以用 `QString::split()` 函数完成。

```cpp
QString s1("Hello");
QString s2("Qt");
// convenient container classes
QStringList list;
list <<  s1 << s2;
// join strings
QString s = list.join(" ") + "!";
cout << s << Qt::endl;
```

### 文件输入输出

在下面的代码片段中，我们从本地目录读取一个 CSV 文件，并遍历各行，从每一行中提取单元格。这样，大约 20 行代码就能从 CSV 文件中获得表格数据。文件读取得到的是字节流，为了把它转换为有效的 Unicode 文本，我们需要使用文本流，并把文件作为更低层的流传入。要写入 CSV 文件，只需以写入模式打开文件，再把各行写入文本流即可。

```cpp
QList<QStringList> data;
// file operations
QFile file("sample.csv");
if(file.open(QIODevice::ReadOnly)) {
    QTextStream stream(&file);
    // loop forever macro
    forever {
        QString line = stream.readLine();
        // test for null string 'String()'
        if(line.isNull()) {
            break;
        }
        // test for empty string 'QString("")'
        if(line.isEmpty()) {
            continue;
        }
        QStringList row;
        // for each loop to iterate over containers
        foreach(const QString& cell, line.split(",")) {
            row.append(cell.trimmed());
        }
        data.append(row);
    }
}
// No cleanup necessary.
```

以上就是关于用 Qt 编写基于控制台的应用程序这一小节的全部内容。

## C++ 窗口部件应用程序

基于控制台的应用程序非常方便，但有时你需要图形用户界面。此外，基于 GUI 的应用程序很可能还需要一个后端，用来读/写文件、通过网络通信，或把数据保存在容器中。

在这个基于窗口部件（widget）的应用程序的第一个片段中，我们用尽可能少的代码创建一个窗口并显示它。在 Qt 中，没有父对象的窗口部件就是一个窗口。我们使用作用域指针来确保指针离开作用域时该窗口部件被销毁。应用程序对象封装了 Qt 运行时，我们通过调用 `exec()` 启动事件循环。从那时起，应用程序只响应由用户输入（如鼠标或键盘）触发的事件，或网络、文件 IO 等其他事件源产生的事件。只有退出事件循环，应用程序才会结束。退出可以通过在应用程序上调用 `quit()` 或关闭窗口来完成。

运行这段代码时，你会看到一个 240 x 120 像素的窗口。仅此而已。

```cpp
include <QtGui>

int main(int argc, char** argv)
{
    QApplication app(argc, argv);
    QScopedPointer<QWidget> widget(new CustomWidget());
    widget->resize(240, 120);
    widget->show();
    return app.exec();
}
```

### 自定义窗口部件

开发用户界面时，你可能需要创建定制的窗口部件。通常，窗口部件就是一块由绘制调用填充的窗口区域。此外，窗口部件内部还知道如何处理键盘和鼠标输入，以及如何对外部触发做出反应。要在 Qt 中做到这一点，我们需要继承 QWidget，并重写若干用于绘制和事件处理的函数。

```cpp
#pragma once

include <QtWidgets>

class CustomWidget : public QWidget
{
    Q_OBJECT
public:
    explicit CustomWidget(QWidget *parent = 0);
    void paintEvent(QPaintEvent *event);
    void mousePressEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
private:
    QPoint m_lastPos;
};
```

在实现中，我们在窗口部件上绘制一个小边框，并在上一次鼠标位置处绘制一个小矩形。这是底层自定义窗口部件的典型做法。鼠标和键盘事件会改变窗口部件的内部状态，并触发重绘更新。我们不会深入讲解这段代码，但知道存在这种可能性是件好事。Qt 提供了大量现成的桌面窗口部件，所以你多半不需要这样做。

```cpp
include "customwidget.h"

CustomWidget::CustomWidget(QWidget *parent) :
    QWidget(parent)
{
}

void CustomWidget::paintEvent(QPaintEvent *)
{
    QPainter painter(this);
    QRect r1 = rect().adjusted(10,10,-10,-10);
    painter.setPen(QColor("#33B5E5"));
    painter.drawRect(r1);

    QRect r2(QPoint(0,0),QSize(40,40));
    if(m_lastPos.isNull()) {
        r2.moveCenter(r1.center());
    } else {
        r2.moveCenter(m_lastPos);
    }
    painter.fillRect(r2, QColor("#FFBB33"));
}

void CustomWidget::mousePressEvent(QMouseEvent *event)
{
    m_lastPos = event->pos();
    update();
}

void CustomWidget::mouseMoveEvent(QMouseEvent *event)
{
    m_lastPos = event->pos();
    update();
}
```

### 桌面窗口部件

Qt 开发者已经替你完成了所有这些工作，并提供了一组桌面窗口部件，在不同操作系统上都具有原生外观。于是你的任务就是把这些不同的窗口部件在窗口部件容器中排列成更大的面板。Qt 中的窗口部件也可以作为其他窗口部件的容器。这通过父子关系实现。也就是说，我们需要把按钮、复选框、单选按钮、列表、网格等现成的窗口部件，变成其他窗口部件的子对象。下面展示了实现这一点的一种方式。

下面是一个所谓窗口部件容器的头文件。

```cpp
class CustomWidget : public QWidget
{
    Q_OBJECT
public:
    explicit CustomWidget(QWidget *parent = 0);
private slots:
    void itemClicked(QListWidgetItem* item);
    void updateItem();
private:
    QListWidget *m_widget;
    QLineEdit *m_edit;
    QPushButton *m_button;
};
```

在实现中，我们使用布局来更好地排列窗口部件。当容器窗口部件改变大小时，布局管理器会按照某些大小策略重新布局这些窗口部件。在这个示例中，我们有一个列表、一个行编辑器和一个按钮，它们垂直排列，允许用户编辑一个城市列表。我们使用 Qt 的 `signal`（信号）和 `slots`（槽）来连接发送方对象和接收方对象。

```cpp
CustomWidget::CustomWidget(QWidget *parent) :
    QWidget(parent)
{
    QVBoxLayout *layout = new QVBoxLayout(this);
    m_widget = new QListWidget(this);
    layout->addWidget(m_widget);

    m_edit = new QLineEdit(this);
    layout->addWidget(m_edit);

    m_button = new QPushButton("Quit", this);
    layout->addWidget(m_button);
    setLayout(layout);

    QStringList cities;
    cities << "Paris" << "London" << "Munich";
    foreach(const QString& city, cities) {
        m_widget->addItem(city);
    }

    connect(m_widget, SIGNAL(itemClicked(QListWidgetItem*)), this, SLOT(itemClicked(QListWidgetItem*)));
    connect(m_edit, SIGNAL(editingFinished()), this, SLOT(updateItem()));
    connect(m_button, SIGNAL(clicked()), qApp, SLOT(quit()));
}

void CustomWidget::itemClicked(QListWidgetItem *item)
{
    Q_ASSERT(item);
    m_edit->setText(item->text());
}

void CustomWidget::updateItem()
{
    QListWidgetItem* item = m_widget->currentItem();
    if(item) {
        item->setText(m_edit->text());
    }
}
```

### 绘制形状

有些问题用图形呈现会更直观。如果手头的问题看起来多少有点像几何对象，那么 Qt 的图形视图（graphics view）是一个很好的候选。图形视图在一个场景中排列简单的几何形状。用户可以与这些形状交互，也可以用算法来摆放它们。要填充一个图形视图，你需要一个图形视图和一个图形场景。场景附加到视图上，并用图形项（graphics item）来填充。

下面是一个简短的示例。首先是声明视图和场景的头文件。

```cpp
class CustomWidgetV2 : public QWidget
{
    Q_OBJECT
public:
    explicit CustomWidgetV2(QWidget *parent = 0);
private:
    QGraphicsView *m_view;
    QGraphicsScene *m_scene;

};
```

在实现中，场景首先附加到视图上。视图是一个窗口部件，被排列在我们的容器窗口部件中。最后，我们向场景添加一个小矩形，它随后被渲染到视图上。

```cpp
include "customwidgetv2.h"

CustomWidget::CustomWidget(QWidget *parent) :
    QWidget(parent)
{
    m_view = new QGraphicsView(this);
    m_scene = new QGraphicsScene(this);
    m_view->setScene(m_scene);

    QVBoxLayout *layout = new QVBoxLayout(this);
    layout->setMargin(0);
    layout->addWidget(m_view);
    setLayout(layout);

    QGraphicsItem* rect1 = m_scene->addRect(0,0, 40, 40, Qt::NoPen, QColor("#FFBB33"));
    rect1->setFlags(QGraphicsItem::ItemIsFocusable|QGraphicsItem::ItemIsMovable);
}
```

## 适配数据

到目前为止，我们主要介绍了基本数据类型，以及如何使用窗口部件和图形视图。在应用程序中，你经常需要大量结构化数据，这些数据可能还需要持久存储。最后，数据还需要被显示出来。为此，Qt 使用模型。一个简单的模型是字符串列表模型，它被填入字符串，然后附加到列表视图上。

```cpp
m_view = new QListView(this);
m_model = new QStringListModel(this);
view->setModel(m_model);

QList<QString> cities;
cities << "Munich" << "Paris" << "London";
m_model->setStringList(cities);
```

另一种流行的存取数据方式是 SQL。Qt 内置了 SQLite，同时也支持其他数据库引擎（例如 MySQL 和 PostgreSQL）。首先，你需要用一个模式（schema）来创建数据库，像这样：

```sql
CREATE TABLE city (name TEXT, country TEXT);
INSERT INTO city VALUES ("Munich", "Germany");
INSERT INTO city VALUES ("Paris", "France");
INSERT INTO city VALUES ("London", "United Kingdom");
```

要使用 SQL，我们需要把 SQL 模块加入 .pro 文件

```
QT += sql
```

然后就可以用 C++ 打开数据库。首先，需要为指定的数据库引擎获取一个新的数据库对象。用这个数据库对象来打开数据库。对于 SQLite，只需指定数据库文件的路径即可。Qt 提供了一些高层数据库模型，其中之一是表模型。表模型使用表标识符和一个可选的 where 子句来选择数据。得到的模型可以像前面的模型一样，附加到列表视图上。

```cpp
QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
db.setDatabaseName("cities.db");
if(!db.open()) {
    qFatal("unable to open database");
}

m_model = QSqlTableModel(this);
m_model->setTable("city");
m_model->setHeaderData(0, Qt::Horizontal, "City");
m_model->setHeaderData(1, Qt::Horizontal, "Country");

view->setModel(m_model);
m_model->select();
```

对于更高层的模型操作，Qt 提供了一个排序过滤代理模型（sort filter proxy model），可以用来对模型进行排序、过滤和转换。

```cpp
QSortFilterProxyModel* proxy = new QSortFilterProxyModel(this);
proxy->setSourceModel(m_model);
view->setModel(proxy);
view->setSortingEnabled(true);
```

过滤基于要过滤的那一列进行，过滤参数是一个字符串。

```cpp
proxy->setFilterKeyColumn(0);
proxy->setFilterCaseSensitivity(Qt::CaseInsensitive);
proxy->setFilterFixedString(QString)
```

过滤代理模型的功能比这里演示的强大得多。目前只要记住它存在就足够了。

!!! note

    以上是用 Qt 5 可以开发的不同种类经典应用程序的概览。桌面正在演变，移动设备很快就会成为我们明天的桌面。移动设备有着不同的用户界面设计。它们比桌面应用程序简单得多。它们只做一件事，并以简洁而专注的方式去做。动画是移动体验的重要组成部分。用户界面需要让人感觉生动而流畅。传统的 Qt 技术并不适合这个市场。

*接下来：Qt Quick 来救场了。*

## Qt Quick 应用程序

现代软件开发中存在一种固有的矛盾。用户界面的变化远快于我们的后端服务。在传统技术中，所谓前端的开发与后端保持相同的节奏。当客户想在项目进行中修改用户界面，或者用户界面的想法是在项目进行中才形成时，就会产生冲突。敏捷项目需要敏捷的方法。

Qt Quick 提供了一种声明式（declarative）环境：用户界面（前端）像 HTML 一样被声明出来，后端则是原生 C++ 代码。这样你就能兼得两者之长。

下面是一个简单的 Qt Quick UI：

```qml
import QtQuick

Rectangle {
    width: 240; height: 240
    Rectangle {
        width: 40; height: 40
        anchors.centerIn: parent
        color: '#FFBB33'
    }
}
```

这种声明式语言称为 QML，它需要一个运行时来执行。Qt 提供了名为 `qml` 的标准运行时。你也可以编写自定义运行时。为此，我们需要一个 quick view（快速视图），并在 C++ 中把主 QML 文档设置为源。然后就可以显示用户界面了。

```cpp
#include <QtGui>
#include <QtQml>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine("main.qml");
    return app.exec();
}
```

让我们回到前面的示例。在一个示例中，我们使用了 C++ 城市模型。如果能在声明式 QML 代码中使用这个模型，那就太好了。

为此，我们先编写前端，看看会想怎样使用城市模型。这里，前端期望一个名为 `cityModel` 的对象，我们可以在列表视图中使用它。

```qml
import QtQuick

Rectangle {
    width: 240; height: 120
    ListView {
        width: 180; height: 120
        anchors.centerIn: parent
        model: cityModel
        delegate: Text { text: model.city }
    }
}
```

要启用 `cityModel`，我们基本可以复用之前的模型，并向根上下文添加一个上下文属性。根上下文是主文档中的另一个根元素。

```cpp
m_model = QSqlTableModel(this);
... // some magic code
QHash<int, QByteArray> roles;
roles[Qt::UserRole+1] = "city";
roles[Qt::UserRole+2] = "country";
m_model->setRoleNames(roles);
engine.rootContext()->setContextProperty("cityModel", m_model);
```


