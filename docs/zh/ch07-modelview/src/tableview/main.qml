import QtQuick 6.2
import "common"

Window {
    width: 320
    height: 320

    visible: true
    Background {
        anchors.fill: parent

        TableView {
            id: view
            anchors.fill: parent
            anchors.margins: 20

            rowSpacing: 5
            columnSpacing: 5

            clip: true

            model: tableModel

            delegate: cellDelegate
        }
    }

    Component {
        id: cellDelegate

        GreenBox {
            implicitHeight: 40
            implicitWidth: 40

            Text {
                anchors.centerIn: parent
                text: display
            }
        }
    }
}
