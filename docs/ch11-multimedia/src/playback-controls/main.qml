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

Window {
    id: root
    width: 1920
    height: 1080
    visible: true

    MediaPlayer {
        id: player
        source: Qt.resolvedUrl("sample-5s.mp4")
        audioOutput: audioOutput
        videoOutput: videoOutput
    }

    // #region audio-output
    AudioOutput {
        id: audioOutput
        volume: volumeSlider.value
    }
    // #endregion audio-output

    VideoOutput {
        id: videoOutput
        width: videoOutput.sourceRect.width
        height: videoOutput.sourceRect.height
        anchors.horizontalCenter: parent.horizontalCenter
    }

    // #region volume-slider
    Slider {
        id: volumeSlider
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        orientation: Qt.Vertical
        value: 0.5
    }
    // #endregion volume-slider

    Item {
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        // #region button
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
        // #endregion button

        // #region progress-slider
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
        // #endregion progress-slider
    }

    Component.onCompleted: {
        player.play()
    }
}
// #endregion global
