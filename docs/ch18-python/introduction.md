# Introduction

The Qt for Python project provides the tooling to bind C++ and Qt to Python, and a complete Python API to Qt. This means that everything that you can do with Qt and C++, you can also do with Qt and Python. This ranges from headless services to widget based user interfaces. In this chapter, we will focus on how to integrate QML and Python.

Currently, Qt for Python is available for all desktop platforms, but not for mobile. Depending on which platform you use, the setup of Python is slightly different, but as soon as you have a [Python](https://www.python.org/) and [PyPA](https://www.pypa.io/en/latest/) environment setup, you can install Qt for Python using `pip`. This is discussed in more detail further down.

As the Qt for Python project provides an entirely new language binding for Qt, it also comes with a new set of documentation. The following resources are good to know about when exploring this module.


* Reference documentation: [https://doc.qt.io/qtforpython/](https://doc.qt.io/qtforpython/)
* Qt for Python wiki: [https://wiki.qt.io/Qt_for_Python](https://wiki.qt.io/Qt_for_Python)
* Caveats: [https://wiki.qt.io/Qt_for_Python/Considerations](https://wiki.qt.io/Qt_for_Python/Considerations)

The Qt for Python bindings are generated using the Shiboken tool. At times, it might be of interest to read about it as well to understand what is going on. The preferred point for finding information about Shiboken is the [reference documentation](https://doc.qt.io/qtforpython/shiboken6/index.html). If you want to mix your own C++ code with Python and QML, Shiboken is the tool that you need.

::: tip
Through-out this chapter we will use Python 3.7.
:::

