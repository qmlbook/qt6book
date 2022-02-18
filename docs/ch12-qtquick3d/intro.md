# Qt Quick 3d

- Introduction
    - capabilities
        - fancy 3D
        - mix with 2D
    - abstracting rendering backends
        - OpenGL 3 or higher (3.3+ recommended)
        - OpenGL ES 2 or higher (3.0+ recommended) (ES 2 - very limited feature set)
        - Direct3D 11.1
        - Vulcan 1.0 or higher
        - Metal 1.2 or higher
        - (Qt Quick Software Adaptation, i.e. CPU based rendering, does not support 3D contents)

## Outline

- Working with assets
    - Balsam Asset Import Tool
    - Importing contents from Blender
- Making Stuff Pretty (working name)
    - Materials
    - Physically-Based Rendering (PBR)
        - PrincipedMaterial
        - DefaultMaterial
    - Image based lighting (IBL)
    - Anti-aliasing
- Animations
    - Skeletal animations (vertex skinning)
        - https://doc.qt.io/qt-6/quick3d-vertex-skinning.html
    - Morphing animations
        - https://doc.qt.io/qt-6/quick3d-morphing.html
- Mixing 2D and 3D Contents
    - A 2D scene with 3D contents
    - 2D contents in a 3D scene
    
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
