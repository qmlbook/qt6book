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
import QtQuick
import QtQuick.Layouts

Item {
    id: root

    property alias text: label.text
    property alias color: label.color

    signal clicked()
    signal remove()

    width: ListView.view.width
    height: 24

    Rectangle {
        anchors.fill: parent
        color: '#ffffff'
        opacity: 0.2
        border.color: Qt.darker(color)
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            Text {
                id: label
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 8
                color: '#f7f7f7'
                font.pixelSize: 14
            }
            MouseArea {
                anchors.fill: parent
                onClicked: root.clicked()
            }
        }
        Item {
            Layout.fillHeight: true
            Layout.preferredWidth: icon.width
            Image {
                id: icon
                anchors.centerIn: parent
                source: 'remove.png'
            }
            MouseArea {
                anchors.fill: parent
                onClicked: root.remove()
            }
        }
    }
}
