/*
 * Copyright (c) 2023, Johan Thelin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the editors nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

import QtQuick
import QtQuick3D

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Translations")

    View3D {
        anchors.fill: parent

        environment: SceneEnvironment {
            clearColor: "#222222"
            backgroundMode: SceneEnvironment.Color
        }
        Model {
            position: Qt.vector3d(250, 0, 0)
            eulerRotation.z: 30
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "orange"; } ]
        }

        Model {
            position: Qt.vector3d(125, 0, 0)
            eulerRotation.z: 15
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "orange"; } ]
        }

        Model {
            position: Qt.vector3d(0, 0, 0)
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "yellow"; } ]
        }

        Model {
            position: Qt.vector3d(-125, 0, 0)
            eulerRotation.z: -15
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "orange"; } ]
        }

        Model {
            position: Qt.vector3d(-250, 0, 0)
            eulerRotation.z: -30
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "orange"; } ]
        }

        Model {
            position: Qt.vector3d(0, -250, 0)
            eulerRotation.x: -30
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "orange"; } ]
        }

        Model {
            position: Qt.vector3d(0, -125, 0)
            eulerRotation.x: -15
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "orange"; } ]
        }

        Model {
            position: Qt.vector3d(0, 125, 0)
            eulerRotation.x: 15
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "orange"; } ]
        }

        Model {
            position: Qt.vector3d(0, 250, 0)
            eulerRotation.x: 30
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "orange"; } ]
        }

        PerspectiveCamera {
            position: Qt.vector3d(0, 0, 500)
            Component.onCompleted: lookAt(Qt.vector3d(0, 0, 0))
        }

        DirectionalLight {
            eulerRotation.x: -45
            eulerRotation.y: 60
        }
    }
}

