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
            position: Qt.vector3d(0, 0, -500)
            Component.onCompleted: lookAt(Qt.vector3d(0, 0, 0))
        }

        DirectionalLight {
            eulerRotation.x: -20
            eulerRotation.y: -110
        }
    }
}

