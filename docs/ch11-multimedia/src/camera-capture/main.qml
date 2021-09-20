import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle {
    id: root

    width: 1024
    height: 600

    color: "black"

    CaptureSession {
        id: captureSession
        videoOutput: output
        camera: Camera {} 
        imageCapture: ImageCapture {
            onImageSaved: function (id, path) {
                imagePaths.append({"path": path})
                listView.positionViewAtEnd()
            }
        }
    }

    MediaDevices {
        id: mediaDevices
    }

    ListModel {
        id: imagePaths
    }

    VideoOutput {
        id: output
        anchors.fill: parent
    }
    
    Image {
        id: image
        anchors.fill: parent
    }

    Window {
        width: 200
        height: 200
        visible: true
        Image {
            id: testImage
            anchors.fill: parent
            source: captureSession.imageCapture.preview
        }
    }

    ListView {
        id: listView

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10

        height: 100

        orientation: ListView.Horizontal
        spacing: 10

        model: imagePaths

        delegate: Image {
            height: 100
            source: path
            fillMode: Image.PreserveAspectFit
        }

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: -10

            color: "black"
            opacity: 0.5
        }
    }

    Column {
        id: controls

        property int buttonWidth: 170
        property int buttonHeight: 50

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10

        spacing: 0

        ComboBox {
            id: cameraComboBox

            width: parent.buttonWidth
            height: parent.buttonHeight

            model: mediaDevices.videoInputs
            textRole: "description"

            displayText: captureSession.camera.cameraDevice.description

            onActivated: function (index) {
                captureSession.camera.cameraDevice = cameraComboBox.currentValue
            }
        }

        Button {
            id: shotButton
            
            width: parent.buttonWidth
            height: parent.buttonHeight

            text: "Take Photo"
            onClicked: {
                captureSession.imageCapture.captureToFile()
            }
        }

        Button {
            id: playButton

            width: parent.buttonWidth
            height: parent.buttonHeight

            text: "Play Sequence"
            onClicked: {
                startPlayback()
            }
        }

        Button {
            id: clearButton

            width: parent.buttonWidth
            height: parent.buttonHeight

            text: "Clear Sequence"
            onClicked: {
                imagePaths.clear()
            }
        }
    }

    property int _imageIndex: -1

    function startPlayback() {
        root.state = "playing"
        setImageIndex(0)
        playTimer.start()
    }

    function setImageIndex(i) {
        _imageIndex = i

        if (_imageIndex >= 0 && _imageIndex < imagePaths.count) {
            image.source = imagePaths.get(_imageIndex).path
        } else {
            image.source = ""
        }
    }

    Timer {
        id: playTimer

        interval: 200
        repeat: false

        onTriggered: {
            if (_imageIndex + 1 < imagePaths.count) {
                setImageIndex(_imageIndex + 1)
                playTimer.start()
            } else {
                setImageIndex(-1)
                root.state = ""
            }
        }
    }

    states: [
        State {
            name: "playing"
            PropertyChanges { target: buttons; opacity: 0 }
            PropertyChanges { target: listView; opacity: 0 }
        }
    ]

    transitions: [
        Transition { 
            PropertyAnimation { properties: "opacity"; duration: 200 }
        }
    ]

    Component.onCompleted: {
        captureSession.camera.start()
    }
}
