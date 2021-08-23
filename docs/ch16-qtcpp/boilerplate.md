# A Boilerplate Application

The best way to understand Qt is to start from a small example. This application creates a simple `"Hello World!"` string and writes it into a file using Unicode characters.

```cpp
#include <QCoreApplication>
#include <QString>
#include <QFile>
#include <QDir>
#include <QTextStream>
#include <QDebug>


int main(int argc, char *argv[])
{
    QCoreApplication app(argc, argv);

    // prepare the message
    QString message("Hello World!");

    // prepare a file in the users home directory named out.txt
    QFile file(QDir::home().absoluteFilePath("out.txt"));
    // try to open the file in write mode
    if(!file.open(QIODevice::WriteOnly)) {
        qWarning() << "Can not open file with write access";
        return -1;
    }
    // as we handle text we need to use proper text codecs
    QTextStream stream(&file);
    // write message to file via the text stream
    stream << message;

    // do not start the eventloop as this would wait for external IO
    // app.exec();

    // no need to close file, closes automatically when scope ends
    return 0;
}
```

The example demonstrates the use of file access and the how to write text to a a file using text codecs using a text stream. For binary data, there is a cross-platform binary stream called `QDataStream` that takes care of endianess and other details. The different classes we use are included using their class name at the top of the file. You can also include classes using the module and class name e.g. `#include <QtCore/QFile>`. For the lazy, there is also the possibility to include all the clases from a module using `#include <QtCore>`. For instance, in `QtCore` you have the most common classes used for an application that are not UI related. Have a look at the [QtCore class list](http://doc.qt.io/qt-5/qtcore-module.html) or the [QtCore overview](http://doc.qt.io/qt-5/qtcore-index.html).

You build the application using CMake and make. CMake reads a project file, `CMakeLists.txt` and generates a Makefile which is used to build the application. CMake supports other build systems too, for example ninja. The project file is platform independent and CMake has some rules to apply the platform specific settings to the generated makefile. The project can also contain platform scopes for platform-specific rules, which are required in some specific cases. Here is an example of a simple project file.

```sh

TODO

```

We will not go into depth into this topic. Just remember Qt uses CMake's `CMakeLists.txt` files to generate  platform-specific makefiles, that are then used to build a project.

The simple code example above just writes the text and exits the application. For a command line tool, this is good enough. For a user interface you need an event loop which waits for user input and somehow schedules draw operations. Here follows the same example now uses a button to trigger the writing.

Our `main.cpp` surprisingly got smaller. We moved code into an own class to be able to use Qt's signal and slots for the user input, i.e. to handle the button click. The signal and slot mechanism normally needs an object instance as you will see shortly, but it can also be used with C++ lambdas.

```cpp
#include <QtCore>
#include <QtGui>
#include <QtWidgets>
#include "mainwindow.h"


int main(int argc, char** argv)
{
    QApplication app(argc, argv);

    MainWindow win;
    win.resize(320, 240);
    win.setVisible(true);

    return app.exec();
}
```

In the `main` function we create the application object, a window, and then start the event loop using `exec()`. For now, the application sits in the event loop and waits for user input.

```cpp
int main(int argc, char** argv)
{
    QApplication app(argc, argv); // init application

    // create the ui

    return app.exec(); // execute event loop
}
```

Using Qt, you can build user interfaces in both QML and Widgets. In this book we focus on QML, but in this chapter, we will look at Widgets. This lets us create the program only C++. 

![image](./images/storecontent.png)

The main window itself is a widget. It becomes a top-level window as it does not have any parent. This comes from how Qt sees a user interface as a tree of UI elements. In this case, the main window is the root element, thus becomes a window, while the push button, that is a child of the main window, becomes a widget inside the window.

```cpp
#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QtWidgets>

class MainWindow : public QMainWindow
{
public:
    MainWindow(QWidget* parent=0);
    ~MainWindow();
public slots:
    void storeContent();
private:
    QPushButton *m_button;
};

#endif // MAINWINDOW_H
```

Additionally, we define a public slot called `storeContent()` in a custom section in the header file. Slots can be public, protected, or private, and can be called just like any other class method. You may also encounter a `signals` section with a set of signal signatures. These methods should not be called and must not be implemented. Both signals and slots are handled by the Qt meta information system and can be introspected and called dynamically at run-time.

The purpose of the `storeContent()` slot is that is is called when the button is clicked. Let's make that happen!

```cpp
#include "mainwindow.h"

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
{
    m_button = new QPushButton("Store Content", this);

    setCentralWidget(m_button);
    connect(m_button, &QPushButton::clicked, this, &MainWindow::storeContent);
}

MainWindow::~MainWindow()
{

}

void MainWindow::storeContent()
{
    qDebug() << "... store content";
    QString message("Hello World!");
    QFile file(QDir::home().absoluteFilePath("out.txt"));
    if(!file.open(QIODevice::WriteOnly)) {
        qWarning() << "Can not open file with write access";
        return;
    }
    QTextStream stream(&file);
    stream << message;
}

```

In the main window, we first create the push button and then register the signal `clicked()` with the slot `storeContent()` using the connect method. Every time the signal `clicked` is emitted the slot `storeContent()` is called. And now, the two objects communicate via signal and slots despite not being aware of each other. This is called loose coupling and is made possible using the `QObject` base class which most Qt classes derive from.
