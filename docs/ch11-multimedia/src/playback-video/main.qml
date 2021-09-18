import QtQuick
import QtMultimedia

Window {
    width: 1920
    height: 1080
    visible: true

    MediaPlayer {
        id: player
        source: "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1920_18MG.mp4"
        audioOutput: AudioOutput {}
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        anchors.margins: 20
    }

    Component.onCompleted: {
        player.play()
    }
}
