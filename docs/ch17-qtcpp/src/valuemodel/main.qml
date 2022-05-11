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
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts

// our module
import org.example 1.0

Window {
    id: root

    property alias letter: letterFilter.text

    visible: true
    width: 480
    height: 480

    onLetterChanged: {
        adaptiveModel.applyFilter()
    }

    Background { // a dark background
        id: background
    }

    // our dyanmic model
    ValueModel {
        id: valueModel
        QtObject {
            property string text: "One"
            property string group: 'A'
        }
        QtObject {
            property string text: "Two"
            property string group: 'A'
        }
    }
    
    AdaptiveModel {
        id: adaptiveModel
        filter: function(v) { return v.group === root.letter }
        source: valueModel
        onFilterChanged: function(filter) { print('new filter: ' + filter) }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 8
        SplitView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            ScrollView {
                SplitView.minimumWidth: 150
                ListView {
                    id: view
                    // set our dynamic model to the views model property
                    model: valueModel
                    delegate: ListDelegate {
                        required property int index
                        required property var object
                        width: ListView.view.width
                        // construct a string based on the models proeprties
                        text: object.text + ' / ' + object.group

                        onClicked: {
                            // make this delegate the current item
                            root.selectItem(index)
                        }
                        onRemove: {
                            // remove the current entry from the model
                            valueModel.remove(index)
                        }
                    }
                    highlight: ListHighlight {
                    }
                }
            }
            ScrollView {
                SplitView.minimumWidth: 150
                ListView {
                    id: rightView
                    // set our dynamic model to the views model property
                    model: adaptiveModel
                    delegate: ListDelegate {
                        required property int index
                        required property var object
                        width: ListView.view.width
                        // construct a string based on the models proeprties
                        text: object.text + ' / ' + object.group

                        onClicked: {
                            // make this delegate the current item
                            ListView.view.currentIndex = index
                            ListView.view.focus = true
                            const text = JSON.stringify(valueModel.get(index))
                            textEntry.setEditValue(index, text)
                        }
                        onRemove: {
                            // remove the current entry from the model
                            const sourceRow = adaptiveModel.mapToSourceRow(index)
                            valueModel.remove(sourceRow)
                        }
                    }
                    highlight: ListHighlight {
                    }
                }
            }
        }
        RowLayout {
            Layout.fillWidth: true
            Label {
                text: 'Filter:'
                color: '#ffffff'
            }
            TextField {
                id: letterFilter
                Layout.fillWidth: true
                text: 'A'
            }
        }
        TextEntry {
            id: textEntry
            onAppend: function(text) {
                console.log(text)
                const js = JSON.parse(text)
                valueModel.append(js)
            }
            onEdit: function(index, text) {
                const js = JSON.parse(text)
                valueModel.set(index, js)
            }

            onUp: {
                // called when the user presses up while the text field is focused
                root.selectItem(Math.max(0, view.currentIndex - 1))
            }
            onDown: {
                // same for down
                root.selectItem(Math.min(view.count - 1, view.currentIndex + 1))
            }

            Component.onCompleted: {
                setAppendValue('{ "text": "Three", "group": "A" }')
            }
        }
    }

    function selectItem(index) {
        view.currentIndex = index
        view.focus = true
        const text = JSON.stringify(valueModel.get(index))
        textEntry.setEditValue(index, text)
    }
}
