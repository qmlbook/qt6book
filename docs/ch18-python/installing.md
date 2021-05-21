# Installing

Qt for Python is available through PyPA using `pip` under the name `pyside2`. In the example below we setup a `venv` environment in which we will install the latest version of Qt for Python:

```sh
mkdir qt-for-python
cd qt-for-python
python3 -m venv .
source bin/activate
(qt-for-python) $ python --version
Python 3.6.6
```

When the environment is setup, we continue to install `pyside2` using `pip`:

```sh
(qt-for-python) $ pip install pyside2
Collecting pyside2
Downloading [ ... ] (166.4MB)

[ ... ]

Installing collected packages: pyside2
Successfully installed pyside2-5.11.2
```

After the installation, we can test it by running a *Hello World* example from the interactive Python prompt:

```sh
(qt-for-python) $ python
Python 3.6.6 (default, Jun 27 2018, 14:44:17)
[GCC 8.1.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> from PySide2 import QtWidgets
>>> import sys
>>> app = QtWidgets.QApplication(sys.argv)
>>> widget = QtWidgets.QLabel("Hello World!")
>>> widget.show()
>>> app.exec_()
0
>>>
```

The example results in a window such as the one shown below. To end the program, close the window.

![](./assets/pyside2-hello-world.png)

