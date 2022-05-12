# Common Qt Classes

Most Qt classes are derived from the `QObject` class. It encapsulates the central concepts of Qt. But there are many more classes in the framework. Before we continue looking at QML and how to extend it, we will look at some basic Qt classes that are useful to know about.

The code examples shown in this section are written using the Qt Test library. This way, we can ensure that the code works, without constructing entire programs around it. The `QVERIFY` and `QCOMPARE` functions from the test library to assert a certain condition. We will use `{}` scopes to avoid name collisions. Don't let this confuse you.

## QString

In general, text handling in Qt is Unicode based. For this, you use the `QString` class. It comes with a variety of great functions which you would expect from a modern framework. For 8-bit data, you would use normally the `QByteArray` class and for ASCII identifiers the `QLatin1String` to preserve memory. For a list of strings you can use a `QList<QString>` or simply the `QStringList` class (which is derived from `QList<QString>`).

Below are some examples of how to use the `QString` class. QString can be created on the stack but it stores its data on the heap. Also when assigning one string to another, the data will not be copied - only a reference to the data. So this is really cheap and lets the developer concentrate on the code and not on the memory handling. `QString` uses reference counters to know when the data can be safely deleted. This feature is called [Implicit Sharing](http://doc.qt.io/qt-6/implicit-sharing.html) and it is used in many Qt classes.

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M1

Below you can see how to convert a number to a string and back. There are also conversion functions for float or double and other types. Just look for the function in the Qt documentation used here and you will find the others.

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M2

Often in a text, you need to have parameterized text. One option could be to use `QString("Hello" + name)` but a more flexible method is the `arg` marker approach.  It preserves the order also during translation when the order might change.

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M3

Sometimes you want to use Unicode characters directly in your code. For this, you need to remember how to mark them for the `QChar` and `QString` classes.

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M4

This gives you some examples of how to easily treat Unicode aware text in Qt. For non-Unicode, the `QByteArray` class also has many helper functions for conversion. Please read the Qt documentation for `QString` as it contains tons of good examples.

## Sequential Containers

A list, queue, vector or linked-list is a sequential container. The mostly used sequential container is the `QList` class. It is a template based class and needs to be initialized with a type. It is also implicit shared and stores the data internally on the heap. All container classes should be created on the stack. Normally you never want to use `new QList<T>()`, which means never use `new` with a container.

The `QList` is as versatile as the `QString` class and offers a great API to explore your data. Below is a small example of how to use and iterate over a list using some new C++ 11 features.

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M5

## Associative Containers

A map, a dictionary, or a set are examples of associative containers. They store a value using a key. They are known for their fast lookup. We demonstrate the use of the most used associative container the `QHash` also demonstrating some new C++ 11 features.

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M6

## File IO

It is often required to read and write from files. `QFile` is actually a `QObject` but in most cases, it is created on the stack. `QFile` contains signals to inform the user when data can be read. This allows reading chunks of data asynchronously until the whole file is read. For convenience, it also allows reading data in blocking mode. This should only be used for smaller amounts of data and not large files. Luckily we only use small amounts of data in these examples.

Besides reading raw data from a file into a `QByteArray` you can also read data types using the `QDataStream` and Unicode string using the `QTextStream`. We will show you how.

<<< @/docs/ch17-qtcpp/src/qtfoundation/tst_foundation.cpp#M7

## More Classes

Qt is a rich application framework. As such it has thousands of classes. It takes some time to get used to all of these classes and how to use them. Luckily Qt has a very good documentation with many useful examples includes. Most of the time you search for a class and the most common use cases are already provided as snippets. Which means you just copy and adapt these snippets. Also, Qt’s examples in the Qt source code are a great help. Make sure you have them available and searchable to make your life more productive. Do not waste time. The Qt community is always helpful. When you ask, it is very helpful to ask exact questions and provide a simple example which displays your needs. This will drastically improve the response time of others. So invest a little bit of time to make the life of others who want to help you easier :-).

Here some classes whose documentation the author thinks are a must read: 
* [QObject](http://doc.qt.io/qt-6/qobject.html), [QString](http://doc.qt.io/qt-6/qstring.html), [QByteArray](http://doc.qt.io/qt-6/qbytearray.html)
* [QFile](http://doc.qt.io/qt-6/qfile.html), [QDir](http://doc.qt.io/qt-6/qdir.html), [QFileInfo](http://doc.qt.io/qt-6/qfileinfo.html), [QIODevice](http://doc.qt.io/qt-6/qiodevice.html)
* [QTextStream](http://doc.qt.io/qt-6/qtextstream.html), [QDataStream](http://doc.qt.io/qt-6/qdatastream.html) 
* [QDebug](http://doc.qt.io/qt-6/qdebug.html), [QLoggingCategory](http://doc.qt.io/qt-6/qloggingcategory.html)
* [QTcpServer](http://doc.qt.io/qt-6/qtcpserver.html), [QTcpSocket](http://doc.qt.io/qt-6/qtcpsocket.html), [QNetworkRequest](http://doc.qt.io/qt-6/qnetworkrequest.html), [QNetworkReply](http://doc.qt.io/qt-6/qnetworkreply.html)
* [QAbstractItemModel](http://doc.qt.io/qt-6/qabstractitemmodel.html), [QRegularExpression](http://doc.qt.io/qt-6/qregularexpression.html)
* [QList](http://doc.qt.io/qt-6/qlist.html), [QHash](http://doc.qt.io/qt-6/qhash.html)
* [QThread](http://doc.qt.io/qt-6/qthread.html), [QProcess](http://doc.qt.io/qt-6/qprocess.html)
* [QJsonDocument](http://doc.qt.io/qt-6/qjsondocument.html), [QJSValue](http://doc.qt.io/qt-6/qjsvalue.html)

That should be enough for the beginning.

