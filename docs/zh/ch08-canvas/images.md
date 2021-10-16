# Images

The QML canvas supports image drawing from several sources. To use an image inside the canvas the image needs to be loaded first. We use the `Component.onCompleted` handler to load the image in our example below.

<<< @/docs/ch08-canvas/src/canvas/image.qml#M1

The left shows our ball image painted at the top-left position of 10x10. The right image shows the ball with a clipping path applied. Images and any other path can be clipped using another path. The clipping is applied by defining a path and calling the `clip()` function. All following drawing operations will now be clipped by this path. The clipping is disabled again by restoring the previous state or by setting the clip region to the whole canvas.

![image](./assets/canvas_image.png)
