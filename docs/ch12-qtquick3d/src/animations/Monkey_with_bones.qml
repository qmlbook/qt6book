import QtQuick
import QtQuick3D
// #region hack
Node {
    id: scene

    property alias left_ear_euler: armature_left_ear.eulerRotation.y
    property alias right_ear_euler: armature_right_ear.eulerRotation.y
// #endregion hack
    rotation: Qt.quaternion(0.707107, -0.707107, 0, 0)
// #region armature
    Node {
        id: armature
        z: -0.874189
        Skeleton {
            id: qmlskeleton
            Joint {
                id: armature_Bone
                rotation: Qt.quaternion(0.707107, 0.707107, 0, 0)
                index: 0
                skeletonRoot: qmlskeleton
                Joint {
                    id: armature_Bone_001
                    y: 1
// #endregion armature
                    rotation: Qt.quaternion(0.696901, -0.119706, -0.119706, 0.696901)
                    scale.x: 1
                    index: 1
                    skeletonRoot: qmlskeleton
                    Joint {
                        id: armature_right_ear
                        x: 7.03373e-09
                        y: 0.944052
                        z: -2.98023e-08
                        rotation: Qt.quaternion(0.987782, -0.0199007, -0.0031134, -0.154537)
                        scale.z: 1
                        index: 2
                        skeletonRoot: qmlskeleton
                    }
                }
                Joint {
                    id: armature_Bone_003
                    y: 1
                    rotation: Qt.quaternion(0.696426, -0.122438, 0.122438, -0.696426)
                    index: 3
                    skeletonRoot: qmlskeleton
                    Joint {
                        id: armature_left_ear
                        y: 0.946709
                        rotation: Qt.quaternion(0.985939, 0.0158208, -0.002669, 0.166334)
                        scale.x: 1
                        scale.y: 1
                        scale.z: 1
                        index: 4
                        skeletonRoot: qmlskeleton
                    }
                }
                Joint {
                    id: armature_Bone_005
                    y: 1
                    index: 5
                    skeletonRoot: qmlskeleton
                }
            }
        }
// #region model
        Model {
            id: suzanne
            skeleton: qmlskeleton
            inverseBindPoses: [
                Qt.matrix4x4(1, 0, 0, 0, 0, 0, 1, 0.748378, 0, -1, 0, 0, 0, 0, 0, 1),
                Qt.matrix4x4(),
                Qt.matrix4x4(0.283576, -0.11343, 0.952218, 1.00072, -0.884112, 0.353645, 0.305421, -0.669643, -0.371391, -0.928477, 1.19209e-07, -0.0380237, 0, 0, 0, 1),
                Qt.matrix4x4(),
                Qt.matrix4x4(0.311833, 0.101945, -0.944652, -1.01739, 0.897887, 0.29354, 0.328074, -0.648326, 0.310739, -0.950495, 0, 0.0303747, 0, 0, 0, 1),
                Qt.matrix4x4()
            ]
            source: "meshes/suzanne.mesh"
// #endregion model
            DefaultMaterial {
                id: defaultMaterial_material
                diffuseColor: "#ff999999"
            }
            materials: [
                defaultMaterial_material
            ]
        }
    }
}
