import QtQuick
import QtMultimedia

Window {
    width: 1024
    height: 768
    visible: true

    MediaPlayer {
        id: player
        source: "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_2MG.mp3"
        audioOutput: AudioOutput {}
    }

    Component.onCompleted: {
        player.play()
    }
}
