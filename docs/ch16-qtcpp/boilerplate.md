# A Boilerplate Application

The best way to understand Qt is to start from a small demonstration application. This application creates a simple `"Hello World!"` string and writes it into a file using Unicode characters.

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

The simple example demonstrates the use of file access and the correct way of writing text into a file using text codecs via the text stream. For binary data, there is a cross-platform binary stream called `QDataStream`. The different classes we use are included using their class name. Another possibility would be to use a module and class name e.g. `#include <QtCore/QFile>`. For the lazy, there is also the possibility to include a whole module using `#include <QtCore>`. E.g. in `QtCore` you have the most common classes used for an application, which are not UI dependent. Have a look at the [QtCore class list](http://doc.qt.io/qt-5/qtcore-module.html) or the [QtCore overview](http://doc.qt.io/qt-5/qtcore-index.html).

You build the application using qmake and make. QMake reads a project file and generates a Makefile which then can be called using make. The project file is platform independent and qmake has some rules to apply the platform specific settings to the generated makefile. The project can also contain platform scopes for platform-specific rules, which are required in some specific cases. Here is an example of a simple project file.

```sh
# build an application
TEMPLATE = app

# use the core module and do not use the gui module
QT       += core
QT       -= gui

# name of the executable
TARGET = CoreApp

# allow console output
CONFIG   += console

# for mac remove the application bundling
macx {
    CONFIG   -= app_bundle
}

# sources to be build
SOURCES += main.cpp
```

We will not go into depth into this topic. Just remember Qt uses project files for projects and qmake generates the platform-specific makefiles from these project files.

The simple code example above just writes the text and exits the application. For a command line tool, this is good enough. For a user interface you would need an event loop which waits for user input and somehow schedules re-draw operations. So here follows the same example now uses a desktop button to trigger the writing.

Our `main.cpp` surprisingly got smaller. We moved code into an own class to be able to use signal/slots for the user input, e.g. the button click. The signal/slot mechanism normally needs an object instance as you will see shortly.

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

In the `main` function we simply create the application object and start the event loop using `exec()`. For now, the application sits in the event loop and waits for user input.

```cpp
int main(int argc, char** argv)
{
    QApplication app(argc, argv); // init application

    // create the ui

    return app.exec(); // execute event loop
}
```

Qt offers several UI technologies. For this example, we use the Desktop Widgets user interface library using pure Qt C++. We create the main window which will host a push button to trigger the functionality and also the main window will host our core functionality which we know from the previous example.



![image](./images/storecontent.png)

The main window itself is a widget. It becomes a top-level window as it does not have any parent. This comes from how Qt sees a user interface as a tree of UI elements. In this case, the main window is the root element, thus becomes a window, while the push button a child of the main window and becomes a widget inside the window.

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

Additionally, we define a public slot called `storeContent()` which shall be called when the button is clicked. A slot is a C++ method which is registered with the Qt meta object system and can be dynamically called.

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

In the main window, we first create the push button and then register the signal `clicked()` with the slot `storeContent()` using the connect method. Every time the signal clicked is emitted the slot `storeContent()` is called. As simple as this, objects communicate via signal and slots with loose coupling.

