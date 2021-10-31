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
    width: 500
    height: 500
    visible: true

    // #region effects
    SoundEffect { id: beep; source: "file:beep.wav"}
    SoundEffect { id: swosh; source: "file:swosh.wav" }
    // #endregion effects

    Rectangle {
        id: rectangle

        anchors.centerIn: parent

        width: 300
        height: width

        color: "red"
        state: "DEFAULT"

        // #region states
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
        // #endregion states

        // #region transitions
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
        // #endregion transitions
    }

    Button {
        anchors.centerIn: parent
        text: "Flip!"
        onClicked: rectangle.state = rectangle.state === "DEFAULT" ? "REVERSE" : "DEFAULT"
    }
}
// #endregion global
