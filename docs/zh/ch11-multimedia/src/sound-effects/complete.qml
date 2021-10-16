import QtQuick
import QtQuick.Controls
import QtMultimedia

Window {
    width: 500
    height: 500
    visible: true

    SoundEffect { id: beep; source: "file:beep.wav"}
    SoundEffect { id: swosh; source: "file:swosh.wav" }

    Rectangle {
        id: rectangle

        anchors.centerIn: parent

        width: 300
        height: width

        color: "red"
        state: "DEFAULT"

        states: [
            State {
                name: "DEFAULT"
                PropertyChanges { target: rectangle; rotation: 0; }
            },
            State {
                name: "REVERSE"
                PropertyChanges { target: rectangle; rotation: 180; }
            }
        ]

        transitions: [
            Transition {
                to: "DEFAULT"
                ParallelAnimation {
                    ScriptAction { script: swosh.play(); }
                    PropertyAnimation { properties: "rotation"; duration: 200; }
                }
            },
            Transition {
                to: "REVERSE"
                ParallelAnimation {
                    ScriptAction { script: beep.play(); }
                    PropertyAnimation { properties: "rotation"; duration: 200; }
                }
            }
        ]
    }

    Button {
        anchors.centerIn: parent
        text: "Flip!"
        onClicked: rectangle.state = rectangle.state === "DEFAULT" ? "REVERSE" : "DEFAULT"
    }
}
