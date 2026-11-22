# Qt Quick 3D

Qt Quick 3D 模块把 QML 的强大能力带入了第三维。借助 Qt Quick 3D，你可以创建三维场景，并利用 QML 的属性绑定、状态管理、动画等特性让场景具备交互性。你甚至可以用多种方式混合 2D 与 3D 内容，创造出一种混合环境。

正如 Qt 为 2D 图形提供了一层抽象，Qt Quick 3D 也依赖一个抽象层来支持各种渲染 API。要使用 Qt Quick 3D，建议所用平台至少提供以下 API 之一：

- OpenGL 3.3+（从 3.0 起提供支持）
- OpenGL ES 3.0+（对 OpenGL ES 2 的支持有限）
- Direct3D 11.1
- Vulcan 1.0+
- Metal 1.2+

Qt Quick 软件适配（Qt Quick Software Adaption），也就是纯软件渲染栈，并不支持 3D 内容。

本章将带你了解 Qt Quick 3D 的基础知识，让你能够基于内置网格（mesh）以及外部工具创建的资源（asset），构建可交互的 3D 场景。我们还将介绍动画，以及 2D 与 3D 内容的混合使用。

<!--
    
## Advanced topics

_on hold_
    
- Custom Materials
    - Shaders 
        - Fragment shader
            - Colour
            - Transparency
            - Texture (images)
        - Vertex shader
            - Basic deformation example
            - Animating the deformation
- Effects
    - Always a fragment shader, applied to the view
    - Play with colour
    - Play with distortion
    - Combine / stack effects
    - Animate effects
- Optimizations
    - Instancing
        - https://doc.qt.io/qt-6/quick3d-instancing.html
    - Improving performance using the shadergen tool
        - https://doc.qt.io/qt-6/qtquick3d-tool-shadergen.html
    - Optimizing models
        - https://doc.qt.io/qt-6/quick3d-asset-conditioning-3d-assets.html
    - Optimizing 2D contents (textures)
        - https://doc.qt.io/qt-6/quick3d-asset-conditioning-2d-assets.html

-->
