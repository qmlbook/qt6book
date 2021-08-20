import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Dialogs

import org.example.io 1.0

ApplicationWindow {
    id: root
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true

// #region actions
    Action {
        id: save
        text: qsTr("&Save")
        shortcut: StandardKey.Save
        onTriggered: {
            saveDocument()
        }
    }

    Action {
        id: open
        text: qsTr("&Open")
        shortcut: StandardKey.Open
        onTriggered: openDialog.open()
    }

    Action {
        id: exit
        text: qsTr("E&xit")
        onTriggered: Qt.quit();
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")
            MenuItem { action: open }
            MenuItem { action: save }
            MenuSeparator {}
            MenuItem { action: exit }
        }
    }

    FileDialog {
        id: openDialog
        onAccepted: {
            root.readDocument()
        }
    }
// #endregion actions

// #region readwrite
    FileIO {
        id: io
    }

    function readDocument() {
        io.source = openDialog.fileUrl
        io.read()
        view.model = JSON.parse(io.text)
    }

    function saveDocument() {
        var data = view.model
        io.text = JSON.stringify(data, null, 4)
        io.write()
    }
// #endregion readwrite

    TableView {
        id: view
        anchors.fill: parent
        TableViewColumn {
            role: 'city'
            title: "City"
            width: 120
        }
        TableViewColumn {
            role: 'country'
            title: "Country"
            width: 120
        }
        TableViewColumn {
            role: 'area'
            title: "Area"
            width: 80
        }
        TableViewColumn {
            role: 'population'
            title: "Population"
            width: 80
        }
        TableViewColumn {
            delegate: Item {
                Image {
                    anchors.centerIn: parent
                    source: 'flags/' + styleData.value
                }
            }
            role: 'flag'
            title: "Flag"
            width: 40
        }
        TableViewColumn {
            delegate: Button {
                iconSource: "remove.png"
                onClicked: {
                    var data = view.model
                    data.splice(styleData.row, 1)
                    view.model = data
                }
            }
            width: 40
        }
    }

}
