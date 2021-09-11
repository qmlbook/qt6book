# OpenGL Shaders

OpenGL uses a rendering pipeline split into stages. A simplified OpenGL pipeline would contain a vertex and fragment shader.



![image](./assets/openglpipeline.png)

The vertex shader receives vertex data and must assign it to the *gl_Position* at the end of the routine. In the next stage, the vertexes are clipped, transformed and rasterized for pixel output. From there the fragments (pixels) arrive in the fragment shader and can further be manipulated and the resulting color needs to be assigned to *gl_FragColor*. The vertex shader is called for each corner point of your polygon (vertex = point in 3D) and is responsible for any 3D manipulation of these points. The fragment (fragment = pixel) shader is called for each pixel and determines the color of that pixel.

