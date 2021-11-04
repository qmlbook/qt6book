import random
import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide6.QtCore import QUrl, QObject, Signal, Slot


class NumberGenerator(QObject):
    def __init__(self):
        QObject.__init__(self)
    
    nextNumber = Signal(int, arguments=['number'])

    @Slot()
    def giveNumber(self):
        self.nextNumber.emit(random.randint(0, 99))


if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    qmlRegisterType(NumberGenerator, 'Generators', 1, 0, 'NumberGenerator')
    
    engine.load(QUrl("main.qml"))
    
    if not engine.rootObjects():
        sys.exit(-1)    
    
    sys.exit(app.exec())
