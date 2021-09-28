import QtQuick
import QtQuick.Window
import QtQuick.Controls

Window {
    id: root
    
    width: 640
    height: 480
    visible: true
    title: "Hello Python World!"
    
    Column {
        Flow {
            Button {
                text: "Give me a number!"
                onClicked: numberGenerator.updateNumber()
            }
            Label {
                id: numberLabel
                text: numberGenerator.number
            }
        }
        Flow {
            Slider {
                from: 0
                to: 99
                value: numberGenerator.maxNumber
                onValueChanged: numberGenerator.setMaxNumber(value)
            }
        }
    }
}
