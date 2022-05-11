# Qt Quick 3D

The Qt Quick 3D module takes the power of QML to the third dimension. Using Qt Quick 3D you can create three dimensional scenes and use the property bindings, state management, animations, and more from QML to make the scene interactive. You can even mix 2D and 3D contents in various way to create a mixed environment.

Just as Qt provides an abstraction for 2D graphics, Qt Quick 3D relies on an abstraction layer for the various rendering APIs supported. In order to use Qt Quick 3D it is recommended to use a platform provding at least one of the following APIs:

- OpenGL 3.3+ (support from 3.0)
- OpenGL ES 3.0+ (limited support for OpenGL ES 2)
- Direct3D 11.1
- Vulcan 1.0+
- Metal 1.2+

The Qt Quick Software Adaption, i.e. the software only rendering stack, does not support 3D contents.

In this chapter we will take you through the basics of Qt Quick 3D, letting you create interactive 3D scenes based on built in meshes as well as assets created in external tools. We will also look at animations and mixing of 2D and 3D contents.

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
