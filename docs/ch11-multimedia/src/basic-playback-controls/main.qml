import QtQuick
import QtQuick.Controls
import QtMultimedia

Window {
    id: root
    width: 960
    height: 400
    visible: true

    MediaPlayer {
        id: player
        source: "file:///path-to-your-video-file.mp4"
        audioOutput: audioOutput
        videoOutput: videoOutput
    }

    AudioOutput {
        id: audioOutput
        volume: volumeSlider.value
    }

    VideoOutput {
        id: videoOutput
        width: videoOutput.sourceRect.width
        height: videoOutput.sourceRect.height
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Slider {
        id: volumeSlider
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        orientation: Qt.Vertical
        value: 0.5
    }

    Item {
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: player.playbackState ===  MediaPlayer.PlayingState ? qsTr("Pause") : qsTr("Play")
            onClicked: {
                switch(player.playbackState) {
                    case MediaPlayer.PlayingState: player.pause(); break;
                    case MediaPlayer.PausedState: player.play(); break;
                    case MediaPlayer.StoppedState: player.play(); break;
                }
            }
        }

        Slider {
            id: progressSlider
            width: parent.width
            anchors.bottom: parent.bottom
            enabled: player.seekable
            value: player.duration > 0 ? player.position / player.duration : 0
            background: Rectangle {
                implicitHeight: 8
                color: "white"
                radius: 3
                Rectangle {
                    width: progressSlider.visualPosition * parent.width
                    height: parent.height
                    color: "#1D8BF8"
                    radius: 3
                }
            }
            handle: Item {}
            onMoved: function () {
                player.position = player.duration * progressSlider.position
            }
        }
    }

    Component.onCompleted: {
        player.play()
    }
}
