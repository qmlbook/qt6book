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

// #region import
import "colorservice.js" as Service
// #endregion import

Rectangle {
    width: 480
    height: 320
    color: '#000'

    ListModel {
        id: gridModel
    }
    StatusLabel {
        id: message
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
    GridView {
        id: view
        anchors.top: parent.top
        anchors.bottom: message.top
        anchors.left: parent.left
        anchors.right: sideBar.left
        anchors.margins: 8
        model: gridModel
        cellWidth: 64
        cellHeight: 64
        delegate: Rectangle {
            required property var model
            width: 64
            height: 64
            color: model.value
        }
    }
    Column {
        id: sideBar
        width: 160
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 8
        spacing: 8
        // #region read-colors
        Button {
            text: 'Read Colors'
            onClicked: {
                Service.getColors(function(response) {
                    print('handle get colors response: ' + JSON.stringify(response))
                    gridModel.clear()
                    const entries = response.data
                    for(let i=0; i<entries.length; i++) {
                        gridModel.append(entries[i])
                    }
                })
            }
        }
        // #endregion read-colors
        // #region create-color
        Button {
            text: 'Create New'
            onClicked: {
                const index = gridModel.count - 1
                const entry = {
                    name: 'color-' + index,
                    value: Qt.hsla(Math.random(), 0.5, 0.5, 1.0).toString()
                }
                Service.createColor(entry, function(response) {
                    print('handle create color response: ' + JSON.stringify(response))
                    gridModel.append(response)
                })
            }
        }
        // #endregion create-color
        // #region read-color
        Button {
            text: 'Read Last Color'
            onClicked: {
                const index = gridModel.count - 1
                const name = gridModel.get(index).name
                Service.getColor(name, function(response) {
                    print('handle get color response:' + JSON.stringify(response))
                    message.text = response.value
                })
            }
        }
        // #endregion read-color
        // #region update-color
        Button {
            text: 'Update Last Color'
            onClicked: {
                const index = gridModel.count - 1
                const name = gridModel.get(index).name
                const entry = {
                    value: Qt.hsla(Math.random(), 0.5, 0.5, 1.0).toString()
                }
                Service.updateColor(name, entry, function(response) {
                    print('handle update color response: ' + JSON.stringify(response))
                    gridModel.setProperty(gridModel.count - 1, 'value', response.value)
                })
            }
        }
        // #endregion update-color
        // #region delete-color
        Button {
            text: 'Delete Last Color'
            onClicked: {
                const index = gridModel.count - 1
                const name = gridModel.get(index).name
                Service.deleteColor(name)
                gridModel.remove(index, 1)
            }
        }
        // #endregion delete-color
    }
}

// #endregion global
