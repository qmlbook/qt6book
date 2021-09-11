# Shader Effects

Shaders allow us to create awesome rendering effects on top of the SceneGraph API leveraging directly the power of OpenGL running on the GPU. Shaders are implemented using the ShaderEffect and ShaderEffectSource elements. The shader algorithm itself is implemented using the OpenGL Shading Language.

Practically it means you mix QML code with shader code. On execution will the shader code be sent over to the GPU and compiled and executed on the GPU. The shader QML elements allow you to interact through properties with the OpenGL shader implementation.

Let’s first have a look what OpenGL shaders are.


::: tip

Resources

* [http://doc.qt.io/qt-5/qml-qtquick-shadereffect.html](http://doc.qt.io/qt-5/qml-qtquick-shadereffect.html)
* [http://www.opengl.org/registry/doc/GLSLangSpec.4.20.6.clean.pdf](http://www.opengl.org/registry/doc/GLSLangSpec.4.20.6.clean.pdf)
* [http://www.khronos.org/registry/gles/specs/2.0/GLSL_ES_Specification_1.0.17.pdf](http://www.khronos.org/registry/gles/specs/2.0/GLSL_ES_Specification_1.0.17.pdf)
* [http://www.lighthouse3d.com/tutorials/](http://www.lighthouse3d.com/tutorials/)
* [http://wiki.delphigl.com/index.php/Tutorial_glsl](http://wiki.delphigl.com/index.php/Tutorial_glsl)
:::

