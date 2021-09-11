# Transformation

The canvas allows you to transform the coordinate system in several ways. This is very similar to the transformation offered by QML items. You have the possibility to `scale`, `rotate`, `translate` the coordinate system. Indifference to QML the transform origin is always the canvas origin. For example to scale a path around its center you would need to translate the canvas origin to the center of the path. It is also possible to apply a more complex transformation using the transform method.

<<< @/docs/ch08-canvas/src/canvas/transform.qml#M1

![image](./assets/transform.png)

Besides translate the canvas allows also to scale using `scale(x,y)` around x and y-axis, to rotate using `rotate(angle)`, where the angle is given in radius (*360 degree = 2\*Math.PI*) and to use a matrix transformation using the `setTransform(m11, m12, m21, m22, dx, dy)`.

::: tip
To reset any transformation you can call the `resetTransform()` function to set the transformation matrix back to the identity matrix:

```js
ctx.resetTransform()
```
:::
