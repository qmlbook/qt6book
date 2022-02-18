import QtQuick
import QtQuick3D

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Meshes")

    View3D {
        anchors.fill: parent

        environment: SceneEnvironment {
            clearColor: "#222222"
            backgroundMode: SceneEnvironment.Color
        }

        Model {
            position: Qt.vector3d(-200, 100, 0)
            source: "#Cone"
            materials: [ DefaultMaterial { diffuseColor: "yellow"; } ]
        }

        Model {
            position: Qt.vector3d(200, 100, 0)
            source: "#Cube"
            materials: [ DefaultMaterial { diffuseColor: "orange"; } ]
        }

        Model {
            position: Qt.vector3d(-200, -100, 0)
            eulerRotation.x: -135
            source: "#Rectangle"
            materials: [ DefaultMaterial { diffuseColor: "red"; } ]
        }

        Model {
            position: Qt.vector3d(200, -100, 0)
            source: "#Cylinder"
            materials: [ DefaultMaterial { diffuseColor: "blue"; } ]
        }

        Model {
            position: Qt.vector3d(0, 0, 0)
            source: "#Sphere"
            materials: [ DefaultMaterial { diffuseColor: "green"; } ]
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
