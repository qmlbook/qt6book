import QtQuick 2.5
import QtQuick.Layouts
import QtQuick.Controls

RowLayout {
    id: root
    signal append(string color)

    signal up()
    signal down()

    TextField {
        id: colorField
        Layout.fillWidth: true
        text: 'orange'
        focus: true
        onAccepted: {
            root.append(colorField.text)
            selectAll()
        }
        Keys.onUpPressed: root.up()
        Keys.onDownPressed: root.down()
    }
    Button {
        text: 'Add'
        onClicked: {
            root.append(colorField.text)
        }
    }
}
