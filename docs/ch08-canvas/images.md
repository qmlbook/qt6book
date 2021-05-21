# Images

The QML canvas supports image drawing from several sources. To use an image inside the canvas the image needs to be loaded first. We will use the `Component.onCompleted` handler to load the image in our example.

```qml
onPaint: {
    var ctx = getContext("2d")


    // draw an image
    ctx.drawImage('assets/ball.png', 10, 10)

    // store current context setup
    ctx.save()
    ctx.strokeStyle = '#ff2a68'
    // create a triangle as clip region
    ctx.beginPath()
    ctx.moveTo(110,10)
    ctx.lineTo(155,10)
    ctx.lineTo(135,55)
    ctx.closePath()
    // translate coordinate system
    ctx.clip()  // create clip from the path
    // draw image with clip applied
    ctx.drawImage('assets/ball.png', 100, 10)
    // draw stroke around path
    ctx.stroke()
    // restore previous context
    ctx.restore()

}

Component.onCompleted: {
    loadImage("assets/ball.png")
}
```

The left shows our ball image painted at the top-left position of 10x10. The right image shows the ball with a clipping path applied. Images and any other path can be clipped using another path. The clipping is applied by defining a path and calling the `clip()` function. All following drawing operations will now be clipped by this path. The clipping is disabled again by restoring the previous state or by setting the clip region to the whole canvas.



![image](./assets/canvas_image.png)

