# Curtain Effect

In the last example for custom shader effects, I would like to bring you the curtain effect. This effect was published first in May 2011 as part of [Qt labs for shader effects](http://labs.qt.nokia.com/2011/05/03/qml-shadereffectitem-on-qgraphicsview/).

![image](./assets/curtain.png)

At that time I really loved these effects and the curtain effect was my favorite out of them. I just love how the curtain opens and hide the background object.

For this chapter, the effect has been adapted for Qt 6. It has also been slightly simplified to make it a better showcase.

The curtain image is called `fabric.png`. The effect then uses a vertex shader to swing the curtain forth and back and a fragment shader to apply shadows to show how the fabric folds.

The diagram below shows how the shader works. The waves are computed through a sin curve with 7 periods (7\*PI=21.99…). The other part is the swinging. The `topWidht` of the curtain is animated when the curtain is opened or closed. The `bottomWidth` follows the `topWidth` using a `SpringAnimation`. This creates the effect of the bottom part of the curtain swinging freely. The calculated `swing` component is the strength of the swing based on the y-component of the vertexes.

![image](./assets/curtain_diagram.png)

The curtain effect is implemented in the `CurtainEffect.qml` file where the fabric image act as the texture source. In the QML code, the `mesh` property is adjusted to make sure that the number of vertices is increased to give a smoother result.

<<< @/docs/ch10-effects/src/effects/curtain/CurtainEffect.qml#M1

The vertex shader, shown below, reshapes the curtain based on the `topWidth` and `bottomWidth` properties, extrapolating the shift based on the y-coordinate. It also calculates the `shade` value, which is used in the fragment shader. The `shade` property is passed through an additional output in `location` 1.

<<< @/docs/ch10-effects/src/effects/curtain/curtain.vert#M1

In the fragment shader below, the `shade` is picked up as an input in `location` 1 and is then used to calculate the `fragColor`, which is used to draw the pixel in question.

<<< @/docs/ch10-effects/src/effects/curtain/curtain.frag#M1

The combination of QML animations and passing variables from the vertex shader to the fragment shader demonstrates how QML and shaders can be used together to build complex, animated, effects.

The effect itself is used from the `curtaindemo.qml` file shown below.

<<< @/docs/ch10-effects/src/effects/curtain/curtaindemo.qml#M1

The curtain is opened through a custom `open` property on the curtain effect. We use a `MouseArea` to trigger the opening and closing of the curtain when the user clicks or taps the area.
