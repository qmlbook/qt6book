# Qt 常用类

大多数 Qt 类都派生自 `QObject` 类。它封装了 Qt 的核心概念。但框架中还有更多的类。在继续研究 QML 以及如何扩展它之前，我们先来看一些值得了解的基础 Qt 类。

本节中的代码示例使用 Qt Test 库编写。这样我们无需围绕它们构造完整的程序，就能确保代码可以工作。测试库中的 `QVERIFY` 和 `QCOMPARE` 函数用于断言某个条件。我们将使用 `{}` 作用域来避免名称冲突。别被这一点弄糊涂。

## QString

一般来说，Qt 中的文本处理基于 Unicode。为此你会使用 `QString` 类。它提供了现代框架应有的各种出色函数。对于 8 位数据，通常使用 `QByteArray` 类；对于 ASCII 标识符，则使用 `QLatin1String` 以节省内存。对于字符串列表，可以使用 `QList<QString>`，或者直接使用 `QStringList` 类（它派生自 `QList<QString>`）。

下面是一些使用 `QString` 类的示例。QString 可以在栈上创建，但它的数据存储在堆上。此外，把一个字符串赋给另一个字符串时，数据不会被复制——只复制对数据的引用。因此这非常廉价，让开发者可以专注于代码而不是内存处理。`QString` 使用引用计数来判断数据何时可以被安全删除。这一特性称为[隐式共享](http://doc.qt.io/qt-6/implicit-sharing.html)（Implicit Sharing），它被用于许多 Qt 类中。

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M1

下面可以看到如何把数字转换为字符串以及转回来。也有用于 float、double 和其他类型的转换函数。只要在 Qt 文档中查找这里用到的函数，就能找到其他函数。

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M2

文本中经常需要参数化的文本。一种选择是使用 `QString("Hello" + name)`，但更灵活的方法是 `arg` 标记方式。在翻译过程中即使顺序可能发生变化，它也能保持顺序。

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M3

有时你想在代码中直接使用 Unicode 字符。为此，你需要记住如何为 `QChar` 和 `QString` 类标记它们。

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M4

以上给出了在 Qt 中轻松处理 Unicode 文本的一些示例。对于非 Unicode 文本，`QByteArray` 类也有许多转换辅助函数。请阅读 Qt 中 `QString` 的文档，其中包含大量优秀示例。

## 顺序容器

列表、队列、向量或链表都是顺序容器。最常用的顺序容器是 `QList` 类。它是一个基于模板的类，需要用一个类型来初始化。它也是隐式共享的，数据内部存储在堆上。所有容器类都应当在栈上创建。通常你绝不会想使用 `new QList<T>()`，也就是说永远不要对容器使用 `new`。

`QList` 像 `QString` 类一样用途广泛，提供了探索数据的优秀 API。下面是一个小示例，展示如何使用一些新的 C++ 11 特性来使用和遍历列表。

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M5

## 关联容器

映射、字典或集合都是关联容器的例子。它们用键来存储值，以快速查找著称。我们演示最常用的关联容器 `QHash` 的使用，同时也展示一些新的 C++ 11 特性。

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M6

## 文件 IO

经常需要对文件进行读写。`QFile` 实际上是一个 `QObject`，但在大多数情况下它在栈上创建。`QFile` 包含信号，用于通知使用者何时可以读取数据。这允许异步读取数据块，直到读完整个文件。为方便起见，它也允许以阻塞模式读取数据。这只应用于较小的数据量，而不要用于大文件。幸好在这些示例中我们只使用少量数据。

除了把文件中的原始数据读入 `QByteArray`，你还可以用 `QDataStream` 读取数据类型，用 `QTextStream` 读取 Unicode 字符串。我们将向你展示如何做到。

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M7

## 更多类

Qt 是一个丰富的应用程序框架，因此它有数以千计的类。要习惯所有这些类及其用法需要一些时间。幸运的是，Qt 有非常好的文档，其中包含许多有用的示例。大多数时候，你搜索一个类，最常见的用例已经以代码片段的形式给出。也就是说，你只需复制并调整这些片段。此外，Qt 源代码中的 Qt 示例也是很大的帮助。确保它们可用且可搜索，会让你的工作更高效。不要浪费时间。Qt 社区总是乐于助人。提问时，提出精确的问题并提供一个展示你需求的简单示例，会非常有帮助。这将大大缩短别人回复你的时间。所以，花一点时间，让那些想帮助你的人更轻松一些 :-)。

以下是作者认为必读的一些类的文档：
* [QObject](http://doc.qt.io/qt-6/qobject.html), [QString](http://doc.qt.io/qt-6/qstring.html), [QByteArray](http://doc.qt.io/qt-6/qbytearray.html)
* [QFile](http://doc.qt.io/qt-6/qfile.html), [QDir](http://doc.qt.io/qt-6/qdir.html), [QFileInfo](http://doc.qt.io/qt-6/qfileinfo.html), [QIODevice](http://doc.qt.io/qt-6/qiodevice.html)
* [QTextStream](http://doc.qt.io/qt-6/qtextstream.html), [QDataStream](http://doc.qt.io/qt-6/qdatastream.html) 
* [QDebug](http://doc.qt.io/qt-6/qdebug.html), [QLoggingCategory](http://doc.qt.io/qt-6/qloggingcategory.html)
* [QTcpServer](http://doc.qt.io/qt-6/qtcpserver.html), [QTcpSocket](http://doc.qt.io/qt-6/qtcpsocket.html), [QNetworkRequest](http://doc.qt.io/qt-6/qnetworkrequest.html), [QNetworkReply](http://doc.qt.io/qt-6/qnetworkreply.html)
* [QAbstractItemModel](http://doc.qt.io/qt-6/qabstractitemmodel.html), [QRegularExpression](http://doc.qt.io/qt-6/qregularexpression.html)
* [QList](http://doc.qt.io/qt-6/qlist.html), [QHash](http://doc.qt.io/qt-6/qhash.html)
* [QThread](http://doc.qt.io/qt-6/qthread.html), [QProcess](http://doc.qt.io/qt-6/qprocess.html)
* [QJsonDocument](http://doc.qt.io/qt-6/qjsondocument.html), [QJSValue](http://doc.qt.io/qt-6/qjsvalue.html)

对入门来说，这些应该足够了。

