import QtQuick
import QtQuick.Window
import QtQuick.Controls

import PsUtils

Window {
    id: root
    
    width: 640
    height: 480
    visible: true
    title: "CPU Load"
    
    ListView {
        anchors.fill: parent
        model: CpuLoadModel { }
        delegate: Rectangle { 
            width: parent.width; 
            height: 30;
            color: "white"
            
            Rectangle {
                id: bar
                
                width: parent.width * display / 100.0
                height: 30
                color: "green"
            }
            
            Text {
                anchors.verticalCenter: parent.verticalCenter
                x: Math.min(bar.x + bar.width + 5, parent.width-width)
                
                text: display + "%"
            }   
        }
    }
}
