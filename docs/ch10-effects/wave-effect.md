# Wave Effect

In this more complex example, we will create a wave effect with the fragment shader. The waveform is based on the sinus curve and it influences the texture coordinates used for the color.

The qml file defines the properties and animation.

<<< @/docs/ch10-effects/src/effects/wave/wave.qml#M1

The fragment shader takes the properties and calculates the color of each pixel based on the properties.

<<< @/docs/ch10-effects/src/effects/wave/wave.frag#M1

The wave calculation is based on a pulse and the texture coordinate manipulation. The pulse equation gives us a sine wave depending on the current time and the used texture coordinate:

```glsl
vec2 pulse = sin(ubuf.time - ubuf.frequency * qt_TexCoord0);
```

Without the time factor, we would just have a distortion but not a traveling distortion like waves are.

For the color we use the color at a different texture coordinate:

```glsl
vec2 coord = qt_TexCoord0 + ubuf.amplitude * vec2(pulse.x, -pulse.x);
```

The texture coordinate is influenced by our pulse x-value. The result of this is a moving wave.

![image](./assets/wave.png)

In this example we use a fragment shader, meaning that we move the pixels inside the texture of the rectangular item. If we wanted the entire item to move as a wave we would have to use a vertex shader.
