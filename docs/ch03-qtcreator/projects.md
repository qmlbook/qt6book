# Managing Projects

Qt Creator manages your source code in projects. You can create a new project by using `File ‣ New File or Project`. When you create a project you have many choices of application templates. Qt Creator is capable of creating desktop, embedded, mobile applications and even python projects using Qt for Python. There are templates for applications which uses Widgets or Qt Quick or even bare-bone projects just using a console. For a beginner, it is difficult to choose, so we have picked five project types for you.

* **Other Project ‣ QtQuick UI Prototype**: Great for playing around with QML as there is no C++ build step involved. Mostly suitable for prototyping only.

* **Application (Qt) ‣ Qt Quick Application**: Creates a bare C++ project with cmake support and a QML main document to render an empty window. This is the typical default starting point for all native QML application. 

* **Library ‣ Qt Quick 2 Extension Plugin**: Use this wizard to create a stub for a plug-in for your Qt Quick UI. A plug-in is used to extend Qt Quick with native elements. This is ideally to create a re-usable Qt Quick library. 

* **Application (Qt) ‣ Qt Widgets Application**: Creates a starting point for a desktop application using Qt Widgets. This would be your starting point if you plan to create a traditional C++ widgets based application.

* **Application (Qt) ‣ Qt Console Application**: Creates a starting point for a desktop application without any user interface. This would be your starting point if you plan to create a traditional C++ command line tool using Qt C++.


::: tip
During the first parts of the book, we will mainly use the **QtQuick UI Prototype** type or the **Qt Quick Application**, depending on whether we also use some C++ code with Qt Quick. Later to describe some c++ aspects we will use the **Qt Console Application** type. For extending Qt Quick with our own native plug-ins we will use the *Qt Quick 2.0 Extension Plug-in* wizard type.
:::
