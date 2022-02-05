# Graphics Shaders

Graphics is rendered using a _rendering pipeline_ split into stages. There are multiple APIs to control graphics rendering. Qt supports OpenGL, Metal, Vulcan, and Direct3D. Looking at a simplified OpenGL pipeline, we can spot a vertex and fragment shader. These concepts exist for all other rendering pipelines too.

![image](./assets/openglpipeline.png)

In the pipeline, the vertex shader receives vertex data, i.e. the location of the corners of each element that makes up the scene, and calculates a `gl_Position`. This means that the vertex shader can _move_ graphical elements. In the next stage, the vertexes are clipped, transformed and rasterized for pixel output. Then the pixels, also known as _fragments_,are passed through the fragment shader, which calculates the color of each pixel. The resulting color returned through the `gl_FragColor` variable. 

To summarize: the vertex shader is called for each corner point of your polygon (vertex = point in 3D) and is responsible for any 3D manipulation of these points. The fragment (fragment = pixel) shader is called for each pixel and determines the color of that pixel.

As Qt is independent of the underlying rendering API, Qt relies on a standard language for writing shaders. The Qt Shader Tools rely on a _Vulcan-compatible GLSL_. We will look more at this in the examples in this chapter.
