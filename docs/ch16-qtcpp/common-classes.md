# Common Qt Classes

The `QObject` class forms the foundations of Qt, but there are many more classes in the framework. Before we continue looking at QML and how to extend it, we will look at some basic Qt classes that are useful to know about.

The code examples shown in this section are written using the Qt Test library. It offers a great way to explore the Qt API and store it for later reference. `QVERIFY`, `QCOMPARE` are functions provided by the test library to assert a certain condition. We will use `{}` scopes to avoid name collisions. So do not get confused.

## QString

In general, text handling in Qt is Unicode based. For this, you use the `QString` class. It comes with a variety of great functions which you would expect from a modern framework. For 8-bit data, you would use normally the `QByteArray` class and for ASCII identifiers the `QLatin1String` to preserve memory. For a list of strings you can use a `QList<QString>` or simply the `QStringList` class (which is derived from `QList<QString>`).

Here are some examples of how to use the `QString` class. QString can be created on the stack but it stores its data on the heap. Also when assigning one string to another, the data will not be copied - only a reference to the data. So this is really cheap and lets the developer concentrate on the code and not on the memory handling. `QString` uses reference counters to know when the data can be safely deleted. This feature is called [Implicit Sharing](http://doc.qt.io/qt-5//implicit-sharing.html) and it is used in many Qt classes.

```cpp
QString data("A,B,C,D"); // create a simple string
// split it into parts
QStringList list = data.split(",");
// create a new string out of the parts
QString out = list.join(",");
// verify both are the same
QVERIFY(data == out);
// change the first character to upper case
QVERIFY(QString("A") == out[0].toUpper());
```

Here we will show how to convert a number to a string and back. There are also conversion functions for float or double and other types. Just look for the function in the Qt documentation used here and you will find the others.

```cpp
// create some variables
int v = 10;
int base = 10;
// convert an int to a string
QString a = QString::number(v, base);
// and back using and sets ok to true on success
bool ok(false);
int v2 = a.toInt(&ok, base);
// verify our results
QVERIFY(ok == true);
QVERIFY(v = v2);
```

Often in a text, you need to have parameterized text. One option could be to use `QString("Hello" + name)` but a more flexible method is the `arg` marker approach.  It preserves the order also during translation when the order might change.

```cpp
// create a name
QString name("Joe");
// get the day of the week as string
QString weekday = QDate::currentDate().toString("dddd");
// format a text using paramters (%1, %2)
QString hello = QString("Hello %1. Today is %2.").arg(name).arg(weekday);
// This worked on Monday. Promise!
if(Qt::Monday == QDate::currentDate().dayOfWeek()) {
    QCOMPARE(QString("Hello Joe. Today is Monday."), hello);
} else {
    QVERIFY(QString("Hello Joe. Today is Monday.") !=  hello);
}
```

Sometimes you want to use Unicode characters directly in your code. For this, you need to remember how to mark them for the `QChar` and `QString` classes.

```cpp
// Create a unicode character using the unicode for smile :-)
QChar smile(0x263A);
// you should see a :-) on you console
qDebug() << smile;
// Use a unicode in a string
QChar smile2 = QString("\u263A").at(0);
QVERIFY(smile == smile2);
// Create 12 smiles in a vector
QVector<QChar> smilies(12);
smilies.fill(smile);
// Can you see the smiles
qDebug() << smilies;
```

This gives you some examples of how to easily treat Unicode aware text in Qt. For non-Unicode, the `QByteArray` class also has many helper functions for conversion. Please read the Qt documentation for `QString` as it contains tons of good examples.

## Sequential Containers

A list, queue, vector or linked-list is a sequential container. The mostly used sequential container is the `QList` class. It is a template based class and needs to be initialized with a type. It is also implicit shared and stores the data internally on the heap. All container classes should be created on the stack. Normally you never want to use `new QList<T>()`, which means never use `new` with a container.

The `QList` is as versatile as the `QString` class and offers a great API to explore your data. Below is a small example of how to use and iterate over a list using some new C++ 11 features.

```cpp
// Create a simple list of ints using the new C++11 initialization
// for this you need to add "CONFIG += c++11" to your pro file.
QList<int> list{1,2};

// append another int
list << 3;

// We are using scopes to avoid variable name clashes

{ // iterate through list using Qt for each
    int sum(0);
    foreach (int v, list) {
        sum += v;
    }
    QVERIFY(sum == 6);
}
{ // iterate through list using C++ 11 range based loop
    int sum = 0;
    for(int v : list) {
        sum+= v;
    }
    QVERIFY(sum == 6);
}

{ // iterate through list using JAVA style iterators
    int sum = 0;
    QListIterator<int> i(list);

    while (i.hasNext()) {
        sum += i.next();
    }
    QVERIFY(sum == 6);
}

{ // iterate through list using STL style iterator
    int sum = 0;
    QList<int>::iterator i;
    for (i = list.begin(); i != list.end(); ++i) {
        sum += *i;
    }
    QVERIFY(sum == 6);
}


// using std::sort with mutable iterator using C++11
// list will be sorted in descending order
std::sort(list.begin(), list.end(), [](int a, int b) { return a > b; });
QVERIFY(list == QList<int>({3,2,1}));


int value = 3;
{ // using std::find with const iterator
    QList<int>::const_iterator result = std::find(list.constBegin(), list.constEnd(), value);
    QVERIFY(*result == value);
}

{ // using std::find using C++ lambda and C++ 11 auto variable
    auto result = std::find_if(list.constBegin(), list.constBegin(), [value](int v) { return v == value; });
    QVERIFY(*result == value);
}
```

## Associative Containers

A map, a dictionary, or a set are examples of associative containers. They store a value using a key. They are known for their fast lookup. We demonstrate the use of the most used associative container the `QHash` also demonstrating some new C++ 11 features.

```cpp
QHash<QString, int> hash({{"b",2},{"c",3},{"a",1}});
qDebug() << hash.keys(); // a,b,c - unordered
qDebug() << hash.values(); // 1,2,3 - unordered but same as order as keys

QVERIFY(hash["a"] == 1);
QVERIFY(hash.value("a") == 1);
QVERIFY(hash.contains("c") == true);

{ // JAVA iterator
    int sum =0;
    QHashIterator<QString, int> i(hash);
    while (i.hasNext()) {
        i.next();
        sum+= i.value();
        qDebug() << i.key() << " = " << i.value();
    }
    QVERIFY(sum == 6);
}

{ // STL iterator
    int sum = 0;
    QHash<QString, int>::const_iterator i = hash.constBegin();
    while (i != hash.constEnd()) {
        sum += i.value();
        qDebug() << i.key() << " = " << i.value();
        i++;
    }
    QVERIFY(sum == 6);
}

hash.insert("d", 4);
QVERIFY(hash.contains("d") == true);
hash.remove("d");
QVERIFY(hash.contains("d") == false);

{ // hash find not successfull
    QHash<QString, int>::const_iterator i = hash.find("e");
    QVERIFY(i == hash.end());
}

{ // hash find successfull
    QHash<QString, int>::const_iterator i = hash.find("c");
    while (i != hash.end()) {
        qDebug() << i.value() << " = " << i.key();
        i++;
    }
}

// QMap
QMap<QString, int> map({{"b",2},{"c",2},{"a",1}});
qDebug() << map.keys(); // a,b,c - ordered ascending

QVERIFY(map["a"] == 1);
QVERIFY(map.value("a") == 1);
QVERIFY(map.contains("c") == true);

// JAVA and STL iterator work same as QHash
```

## File IO

It is often required to read and write from files. `QFile` is actually a `QObject` but in most cases, it is created on the stack. `QFile` contains signals to inform the user when data can be read. This allows reading chunks of data asynchronously until the whole file is read. For convenience, it also allows reading data in blocking mode. This should only be used for smaller amounts of data and not large files. Luckily we only use small amounts of data in these examples.

Besides reading raw data from a file into a `QByteArray` you can also read data types using the `QDataStream` and Unicode string using the `QTextStream`. We will show you how.

```cpp
QStringList data({"a", "b", "c"});
{ // write binary files
    QFile file("out.bin");
    if(file.open(QIODevice::WriteOnly)) {
        QDataStream stream(&file);
        stream << data;
    }
}
{ // read binary file
    QFile file("out.bin");
    if(file.open(QIODevice::ReadOnly)) {
        QDataStream stream(&file);
        QStringList data2;
        stream >> data2;
        QCOMPARE(data, data2);
    }
}
{ // write text file
    QFile file("out.txt");
    if(file.open(QIODevice::WriteOnly)) {
        QTextStream stream(&file);
        QString sdata = data.join(",");
        stream << sdata;
    }
}
{ // read text file
    QFile file("out.txt");
    if(file.open(QIODevice::ReadOnly)) {
        QTextStream stream(&file);
        QStringList data2;
        QString sdata;
        stream >> sdata;
        data2 = sdata.split(",");
        QCOMPARE(data, data2);
    }
}
```

## More Classes

Qt is a rich application framework. As such it has thousands of classes. It takes some time to get used to all of these classes and how to use them. Luckily Qt has a very good documentation with many useful examples includes. Most of the time you search for a class and the most common use cases are already provided as snippets. Which means you just copy and adapt these snippets. Also, Qt’s examples in the Qt source code are a great help. Make sure you have them available and searchable to make your life more productive. Do not waste time. The Qt community is always helpful. When you ask, it is very helpful to ask exact questions and provide a simple example which displays your needs. This will drastically improve the response time of others. So invest a little bit of time to make the life of others who want to help you easier :-).

Here some classes whose documentation the author thinks are a must read: 
* [QObject](http://doc.qt.io/qt-5//qobject.html), [QString](http://doc.qt.io/qt-5//qstring.html), [QByteArray](http://doc.qt.io/qt-5//qbytearray.html)
* [QFile](http://doc.qt.io/qt-5//qfile.html), [QDir](http://doc.qt.io/qt-5//qdir.html), [QFileInfo](http://doc.qt.io/qt-5//qfileinfo.html), [QIODevice](http://doc.qt.io/qt-5//qiodevice.html)
* [QTextStream](http://doc.qt.io/qt-5//qtextstream.html), [QDataStream](http://doc.qt.io/qt-5//qdatastream.html) 
* [QDebug](http://doc.qt.io/qt-5//qdebug.html), [QLoggingCategory](http://doc.qt.io/qt-5//qloggingcategory.html)
* [QTcpServer](http://doc.qt.io/qt-5//qtcpserver.html), [QTcpSocket](http://doc.qt.io/qt-5//qtcpsocket.html), [QNetworkRequest](http://doc.qt.io/qt-5//qnetworkrequest.html), [QNetworkReply](http://doc.qt.io/qt-5//qnetworkreply.html)
* [QAbstractItemModel](http://doc.qt.io/qt-5//qabstractitemmodel.html), [QRegExp](http://doc.qt.io/qt-5//qregexp.html)
* [QList](http://doc.qt.io/qt-5//qlist.html), [QHash](http://doc.qt.io/qt-5//qhash.html)
* [QThread](http://doc.qt.io/qt-5//qthread.html), [QProcess](http://doc.qt.io/qt-5//qprocess.html)
* [QJsonDocument](http://doc.qt.io/qt-5//qjsondocument.html), [QJSValue](http://doc.qt.io/qt-5//qjsvalue.html)

That should be enough for the beginning.

