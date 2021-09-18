import QtQuick
import QtMultimedia

Window {
    width: 1024
    height: 768
    visible: true

    CaptureSession {
        id: captureSession
        camera: Camera {}
        videoOutput: output
    }

    VideoOutput {
        id: output
        anchors.fill: parent
    }

    Component.onCompleted: captureSession.camera.start()
}
