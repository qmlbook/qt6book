import QtQuick
import QtQuick.Controls

Page {
    title: qsTr("Profile")

    Column {
        anchors.centerIn: parent
        spacing: 10
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Profile")
        }
        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Edit");
            onClicked: stackView.push("EditProfile.qml")
        }
    }
}
