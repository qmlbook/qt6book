# Pixel Buffers

When working with the canvas you are able to retrieve pixel data from the canvas to read or manipulate the pixels of your canvas. To read the image data use `createImageData(sw,sh)` or `getImageData(sx,sy,sw,sh)`. Both functions return an `ImageData` object with a `width`, `height` and a `data` variable. The data variable contains a one-dimensional array of the pixel data retrieved in the *RGBA* format, where each value varies in the range of 0 to 255. To set pixels on the canvas you can use the `putImageData(imagedata, dx, dy)` function.

Another way to retrieve the content of the canvas is to store the data into an image. This can be achieved with the `Canvas` functions `save(path)` or `toDataURL(mimeType)`, where the later function returns an image URL, which can be used to be loaded by an `Image` element.

```qml
import QtQuick 2.5

Rectangle {
    width: 240; height: 120
    Canvas {
        id: canvas
        x: 10; y: 10
        width: 100; height: 100
        property real hue: 0.0
        onPaint: {
            var ctx = getContext("2d")
            var x = 10 + Math.random(80)*80
            var y = 10 + Math.random(80)*80
            hue += Math.random()*0.1
            if(hue > 1.0) { hue -= 1 }
            ctx.globalAlpha = 0.7
            ctx.fillStyle = Qt.hsla(hue, 0.5, 0.5, 1.0)
            ctx.beginPath()
            ctx.moveTo(x+5,y)
            ctx.arc(x,y, x/10, 0, 360)
            ctx.closePath()
            ctx.fill()
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                var url = canvas.toDataURL('image/png')
                print('image url=', url)
                image.source = url
            }
        }
    }

    Image {
        id: image
        x: 130; y: 10
        width: 100; height: 100
    }

    Timer {
        interval: 1000
        running: true
        triggeredOnStart: true
        repeat: true
        onTriggered: canvas.requestPaint()
    }
}
```

In our little example, we paint every second a small circle on the left canvas. When the user clicks on the mouse area the canvas content is stored and an image URL is retrieved. On the right side of our example, the image is then displayed.

::: tip
Retrieving image data seems not to work currently in the Qt 5 Alpha SDK.
:::

