/*
Copyright (c) 2021, Johan Thelin
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
import QtQuick 2.0

Rectangle {
    width: 480
    height: 272

    CityModel {
        id: cityModel
    }

    Component {
        id: cityDelegate

        Item {
            width: 480
            height: 45

            Column {
                spacing: 2
                Text {
                    text: model.name
                    x: 10
                    font: Qt.font({
                            pixelSize: 24,
                            unicodeCoverage: [Font.UnicodeBlock_BasicLatin]
                        })
                }
                Text {
                    text: model.country
                    x: 10
                    color: "gray"
                    font: Qt.font({
                            pixelSize: 12,
                            unicodeCoverage: [Font.UnicodeBlock_BasicLatin]
                        })
                }
                Rectangle {
                    color: "lightGreen"
                    x: 10
                    width: 460
                    height: 1
                }
            }
        }
    }

    ListView {
        anchors.fill: parent
        model: cityModel
        delegate: cityDelegate
        spacing: 5
    }
}
// #endregion global
