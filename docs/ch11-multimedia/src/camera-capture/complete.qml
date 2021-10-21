/*
Copyright (c) 2012-2021, Juergen Bocklage Ryannel and Johan Thelin
All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
   this list of conditions and the following disclaimer in the documentation 
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
   may be used to endorse or promote products derived from this software 
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// #region global
import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle {
    id: root

    width: 1024
    height: 600

    color: "black"

    // #region viewfinder
    // #region capture-session
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
    // #endregion capture-session

    VideoOutput {
        id: output
        anchors.fill: parent
    }
    // #endregion viewfinder
    
    Image {
        id: image
        anchors.fill: parent
    }

    // #region model-view
    ListModel {
        id: imagePaths
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
            required property string path
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
    // #endregion model-view

    Column {
        id: controls

        property int buttonWidth: 170
        property int buttonHeight: 50

        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10

        spacing: 0

        // #region switching-devices
        MediaDevices {
            id: mediaDevices
        }

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
        // #endregion switching-devices

        // #region button-shot
        Button {
            id: shotButton
            
            width: parent.buttonWidth
            height: parent.buttonHeight

            text: qsTr("Take Photo")
            onClicked: {
                captureSession.imageCapture.captureToFile()
            }
        }
        // #endregion button-shot

        Button {
            id: playButton

            width: parent.buttonWidth
            height: parent.buttonHeight

            text: qsTr("Play Sequence")
            onClicked: {
                root.startPlayback()
            }
        }

        Button {
            id: clearButton

            width: parent.buttonWidth
            height: parent.buttonHeight

            text: qsTr("Clear Sequence")
            onClicked: {
                imagePaths.clear()
            }
        }
    }

    // #region playback
    property int _imageIndex: -1

    function startPlayback() {
        root.state = "playing"
        root.setImageIndex(0)
        playTimer.start()
    }

    function setImageIndex(i) {
        root._imageIndex = i

        if (root._imageIndex >= 0 && root._imageIndex < imagePaths.count) {
            image.source = imagePaths.get(root._imageIndex).path
        } else {
            image.source = ""
        }
    }

    Timer {
        id: playTimer

        interval: 200
        repeat: false

        onTriggered: {
            if (root._imageIndex + 1 < imagePaths.count) {
                root.setImageIndex(root._imageIndex + 1)
                playTimer.start()
            } else {
                root.setImageIndex(-1)
                root.state = ""
            }
        }
    }
    // #endregion playback

    states: [
        State {
            name: "playing"
            PropertyChanges { target: controls; opacity: 0 }
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
// #endregion global
