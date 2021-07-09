import QtQuick
import QtQuick.Controls

Page {
    header: Label {
        text: qsTr("Current")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Label {
        text: qsTr("Current activity")
        anchors.centerIn: parent
    }
}
