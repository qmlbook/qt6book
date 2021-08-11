import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: root
    
    width: 640
    height: 480
    visible: true
    title: "Hello Python World!"
    
    Flow {
        Button {
            text: "Give me a number!"
            onClicked: numberGenerator.giveNumber();
        }
        Label {
            id: numberLabel
            text: "no number"
        }
    }

    Connections {
        target: numberGenerator
        function onNextNumber(number) {
            numberLabel.text = number
        }
    }
}
