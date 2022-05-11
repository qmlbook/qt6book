# Copyright (c) 2012-2021, Juergen Bocklage Ryannel and Johan Thelin
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice, 
#    this list of conditions and the following disclaimer in the documentation 
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
#    may be used to endorse or promote products derived from this software 
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#region global
import psutil
import sys

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine, qmlRegisterType
from PySide6.QtCore import Qt, QUrl, QTimer, QAbstractListModel

class CpuLoadModel(QAbstractListModel):
    def __init__(self):
        QAbstractListModel.__init__(self)
        
        self.__cpu_count = psutil.cpu_count()
        self.__cpu_load = [0] * self.__cpu_count
        
        self.__update_timer = QTimer(self)
        self.__update_timer.setInterval(1000)
        self.__update_timer.timeout.connect(self.__update)
        self.__update_timer.start()
        
        # The first call returns invalid data
        psutil.cpu_percent(percpu=True)
            
    def __update(self):
        self.__cpu_load = psutil.cpu_percent(percpu=True)
        self.dataChanged.emit(self.index(0,0), self.index(self.__cpu_count-1, 0))
        
    def rowCount(self, parent):
        return self.__cpu_count
    
    def data(self, index, role):
        if (role == Qt.DisplayRole and
            index.row() >= 0 and
            index.row() < len(self.__cpu_load) and
            index.column() == 0):
            return self.__cpu_load[index.row()]
        else:
            return None

if __name__ == '__main__':
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    
    qmlRegisterType(CpuLoadModel, 'PsUtils', 1, 0, 'CpuLoadModel')
    
    engine.load(QUrl("main.qml"))
    
    if not engine.rootObjects():
        sys.exit(-1)    
    
    sys.exit(app.exec())
#endregion global
