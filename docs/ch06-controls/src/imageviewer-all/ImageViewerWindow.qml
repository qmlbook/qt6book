import QtQuick
import QtQuick.Controls
import Qt.labs.platform as Platform


ApplicationWindow {

    // ...

    function openFileDialog() { fileOpenDialog.open(); }
    function openAboutDialog() { aboutDialog.open(); }

    visible: true
    title: qsTr("Image Viewer")

    background: Rectangle {
        color: "darkGray"
    }

    Image {
        id: image
        anchors.fill: parent
        fillMode: Image.PreserveAspectFit
        asynchronous: true
    }

    Platform.FileDialog {
        id: fileOpenDialog

        // ...

        title: "Select an image file"
        folder: Platform.StandardPaths.writableLocation(Platform.StandardPaths.DocumentsLocation)
        nameFilters: [ "Image files (*.png *.jpeg *.jpg)" ]
        onAccepted: image.source = fileOpenDialog.file;
    }

    Dialog {
        id: aboutDialog

        // ...

        title: qsTr("About")
        standardButtons: Dialog.Ok

        Label {
            anchors.fill: parent
            text: qsTr("QML Image Viewer\nA part of the QmlBook\nhttp://qmlbook.org")
            horizontalAlignment: Text.AlignHCenter
        }
    }

    // ...

}
