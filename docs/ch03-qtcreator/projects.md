# Managing Projects

Qt Creator manages your source code in projects. You can create a new project by using File ‣ New File or Project. When you create a project you have many choices of application templates. Qt Creator is capable of creating desktop, mobile applications. An application which uses Widgets or Qt Quick or Qt Quick and controls or even bare-bone projects. Also, a project for HTML5 and Python are supported. For a beginner, it is difficult to choose, so we pick three project types for you.


* **Applications / Qt Quick 2.0 UI**: This will create a QML/JS only project for you, without any C++ code. Take this if you want to sketch a new user interface or plan to create a modern UI application where the native parts are delivered by plug-ins.

* **Libraries / Qt Quick 2.0 Extension Plug-in**: Use this wizard to create a stub for a plug-in for your Qt Quick UI. A plug-in is used to extend Qt Quick with native elements.

* **Other Project / Empty Qt Project**: A bare-bones empty project. Take this if you want to code your application with c++ from scratch. Be aware you need to know what you are doing here.

::: tip
During the first parts of the book, we will mainly use the Qt Quick 2.0 UI project type. Later to describe some c++ aspects we will use the Empty-Qt-Project type or something similar. For extending Qt Quick with our own native plug-ins we will use the *Qt Quick 2.0 Extension Plug-in* wizard type.
:::
