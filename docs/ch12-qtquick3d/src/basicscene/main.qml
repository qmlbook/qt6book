import QtQuick
import QtQuick3D

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Basic Scene")

    View3D {
        anchors.fill: parent

        environment: SceneEnvironment {
            clearColor: "#222222"
            backgroundMode: SceneEnvironment.Color
        }

        Model {
            position: Qt.vector3d(0, 0, 0)
            scale: Qt.vector3d(1, 1.25, 1)
            source: "#Cone"
            materials: [ DefaultMaterial { diffuseColor: "yellow"; } ]
        }

        Model {
            position: Qt.vector3d(-80, 0, -50)
            source: "#Sphere"
            materials: [ DefaultMaterial { diffuseColor: "green"; } ]
        }

        PerspectiveCamera {
            position: Qt.vector3d(0, 200, -300)
            Component.onCompleted: lookAt(Qt.vector3d(0, 0, 0))
        }

        DirectionalLight {
            eulerRotation.x: -20
            eulerRotation.y: -110

            castsShadow: true
        }
    }
}
