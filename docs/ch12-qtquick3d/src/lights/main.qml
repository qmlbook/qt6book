import QtQuick
import QtQuick3D

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Lights")

    View3D {
        anchors.fill: parent

        environment: SceneEnvironment {
            clearColor: "#222222"
            backgroundMode: SceneEnvironment.Color
        }

        Model {
            position: Qt.vector3d(0, -50, 0)
            scale: Qt.vector3d(4.0, 4.0, 4.0)
            eulerRotation.x: -90
            source: "#Rectangle"
            materials: [ DefaultMaterial { diffuseColor: "red"; } ]
        }

        Model {
            position: Qt.vector3d(0, 0, 0)
            source: "#Sphere"
            materials: [ DefaultMaterial { diffuseColor: "green"; } ]
        }

        PerspectiveCamera {
            position: Qt.vector3d(0, 200, -500)
            Component.onCompleted: lookAt(Qt.vector3d(0, 0, 0))
        }

        SpotLight {
            position: Qt.vector3d(50, 200, -150)
            eulerRotation.x: 230

            brightness: 5
            ambientColor: Qt.rgba(0.1, 0.1, 0.1, 1.0)

            castsShadow: true
        }

        PointLight {
            position: Qt.vector3d(100, 100, -50)

            castsShadow: true
        }

        DirectionalLight {
            eulerRotation.x: -20
            eulerRotation.y: -110

            castsShadow: true
        }
    }
}
