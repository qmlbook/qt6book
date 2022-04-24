# Summary

Qt Quick 3D offers a rich way of integrating 3D contents into a Qt Quick scene, allowing a tight integration through QML. 

When working with 3D contents, the most common approach is to work with assets created in other tools such as Blender, Maya, or 3ds Max. Using the _Balsam_ tool it is possible to import meshes, materials, as well as animation skeletons, from these models into QML. This can then be used to render, as well as interacting with the models.

QML is still used to setup the scene, as well as instantiating models. This means that a scene can be built in an external tool, or be instantiated dynamically from QML using elements created using external tool. In the most basic cases, scenes can also be created from the built in meshed that come with Qt Quick 3D.

By allowing the tight integration of Qt Quick's 2D contents, and Qt Quick 3D, it is possible to create modern and intuit user interfaces. With QML's ability to bind C++ properties to QML properties, this makes it easy to connect 3D model state to underlying C++ state.

In this chapter we've only scratched the surface of what is possible using Qt Quick 3D. There are more advanced concepts ranging from custom filters and shaders, to generating meshes dynamically from C++. There is also a large set of optimization techniques that can be used to ensure good rendering performance of complex 3D contents. You can read more about this in the [Qt Quick 3D Reference Documentation](https://doc.qt.io/qt-6/qtquick3d-index.html).
