# Convenience API

For operations on rectangles, a convenience API is provided which draws directly and does need a stroke or fill call.

<<< @/docs/ch08-canvas/src/canvas/convenient.qml#M1

![image](./assets/convenient.png)

::: tip
The stroke area extends half of the line width on both sides of the path. A 4 px lineWidth will draw 2 px outside the path and 2 px inside.
:::

