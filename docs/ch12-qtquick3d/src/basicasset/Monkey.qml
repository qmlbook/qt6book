import QtQuick
import QtQuick3D
Node {
    id: scene
    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
    Model {
        id: suzanne
        source: "meshes/suzanne.mesh"

        DefaultMaterial {
            id: defaultMaterial_material
            diffuseColor: "#ff999999"
        }
        materials: [
            defaultMaterial_material
        ]
    }
    PerspectiveCamera {
        id: camera
        x: 7.35889
        y: -6.92579
        z: 4.95831
        rotation: Qt.quaternion(0.780483, 0.483536, 0.208704, 0.336872)
        clipNear: 0.1
        clipFar: 100
        fieldOfView: 39.5978
        fieldOfViewOrientation: PerspectiveCamera.Horizontal
    }
    PointLight {
        id: light
        x: 4.07624
        y: 1.00545
        z: 5.90386
        rotation: Qt.quaternion(0.570948, 0.169076, 0.272171, 0.75588)
        brightness: 1000
        quadraticFade: 0
    }
}
