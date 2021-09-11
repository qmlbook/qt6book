# Canvas Paint

In this example, we will create a small paint application using the `Canvas` element.

![image](./assets/canvaspaint.png)

For this, we arrange four color squares on the top of our scene using a row positioner. A color square is a simple rectangle filled with a mouse area to detect clicks.

<<< @/docs/ch08-canvas/src/canvas/paint.qml#M1

The colors are stored in an array and the paint color. When one the user clicks in one of the squares the color of the square is assigned to the `paintColor` property of the row named `colorTools`.

To enable tracking of the mouse events on the canvas we have a `MouseArea` covering the canvas element and hooked up the pressed and position changed handlers.

<<< @/docs/ch08-canvas/src/canvas/paint.qml#M2

A mouse press stores the initial mouse position into the `lastX` and `lastY` properties. Every change on the mouse position triggers a paint request on the canvas, which will result in calling the `onPaint` handler.

To finally draw the users stroke, in the `onPaint` handler we begin a new path and move to the last position. Then we gather the new position from the mouse area and draw a line with the selected color to the new position. The mouse position is stored as the new `last` position.
