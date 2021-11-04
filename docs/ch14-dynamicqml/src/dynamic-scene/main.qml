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

import QtQml.XmlListModel

// #region M1
import QtQuick
import "create-object.js" as CreateObject

Item {
    id: root

    ListModel {
        id: objectsModel
    }

    function addUfo() {
        CreateObject.create("ufo.qml", root, itemAdded)
    }

    function addRocket() {
        CreateObject.create("rocket.qml", root, itemAdded)
    }

    function itemAdded(obj, source) {
        objectsModel.append({"obj": obj, "source": source})
    }
// #endregion M1

    width: 1024
    height: 600

// #region M2
    function clearItems() {
        while(objectsModel.count > 0) {
            objectsModel.get(0).obj.destroy()
            objectsModel.remove(0)
        }
    }
// #endregion M2

// #region M3
    function serialize() {
        var res = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n<scene>\n"

        for(var ii=0; ii < objectsModel.count; ++ii) {
            var i = objectsModel.get(ii)
            res += "  <item>\n    <source>" + i.source + "</source>\n    <x>" + i.obj.x + "</x>\n    <y>" + i.obj.y + "</y>\n  </item>\n"
        }

        res += "</scene>"

        return res
    }
// #endregion M3

// #region M4
    XmlListModel {
        id: xmlModel
        query: "/scene/item"
        XmlListModelRole { name: "source"; elementName: "source" }
        XmlListModelRole { name: "x"; elementName: "x" }
        XmlListModelRole { name: "y"; elementName: "y" }
    }

    function deserialize() {
        dsIndex = 0
        CreateObject.create(xmlModel.get(dsIndex).source, root, dsItemAdded)
    }

    function dsItemAdded(obj, source) {
        itemAdded(obj, source)
        obj.x = xmlModel.get(dsIndex).x
        obj.y = xmlModel.get(dsIndex).y

        dsIndex++

        if (dsIndex < xmlModel.count) {
            CreateObject.create(xmlModel.get(dsIndex).source, root, dsItemAdded)
        }
    }

    property int dsIndex
// #endregion M4
    Column {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 10

        spacing: 10

        width: 100

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "ufo.png"

            MouseArea {
                anchors.fill: parent
                onClicked: root.addUfo()
            }
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            source: "rocket.png"

            MouseArea {
                anchors.fill: parent
                onClicked: root.addRocket()
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter

            width: 100
            height: 40

            color: "#53d769"

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    xmlModel.xml = root.serialize()
                    root.clearItems()
                }
            }
        }

        Rectangle {
            anchors.horizontalCenter: parent.horizontalCenter

            width: 100
            height: 40

            color: "#fed958"

            MouseArea {
                anchors.fill: parent
                onClicked: root.deserialize()
            }
        }
    }
}
