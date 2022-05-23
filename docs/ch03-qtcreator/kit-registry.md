# Registering your Qt Kit

The Qt Kit is probably the most difficult aspect when it comes to working with Qt Creator initially. A Qt Kit is a set of a Qt version, compiler and device and some other settings. It is used to uniquely identify the combination of tools for your project build. A typical kit for the desktop would contain a C++ compiler and a Qt version (e.g. Qt 6.xx.yy) and a device (“Desktop”). After you have created a project you need to assign a kit to a project before Qt Creator can build the project. Before you are able to create a kit first you need to have a compiler installed and have a Qt version registered. A Qt version is registered by specifying the path to the `qmake` executable. Qt Creator then queries `qmake` for information required to identify the Qt version. This is also true for Qt 6 where CMake is the preferred build tool.

Adding a kit and registering a Qt version is done in the `Settings ‣ Kits` entry. There you can also see which compilers are registered.

::: tip
Please first check if your Qt Creator has already the correct Qt version registered and then ensure a Kit for your combination of compiler and Qt and device is specified. **You can not build a project without a kit.**
:::
