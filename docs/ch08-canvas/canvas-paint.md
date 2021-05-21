# Canvas Paint

In this example, we would like to create a small paint application using the `Canvas` element.



![image](./assets/canvaspaint.png)

For this, we arrange four color squares on the top of our scene using a row positioner. A color square is a simple rectangle filled with a mouse area to detect clicks.

```qml
Row {
    id: colorTools
    anchors {
        horizontalCenter: parent.horizontalCenter
        top: parent.top
        topMargin: 8
    }
    property variant activeSquare: red
    property color paintColor: "#33B5E5"
    spacing: 4
    Repeater {
        model: ["#33B5E5", "#99CC00", "#FFBB33", "#FF4444"]
        ColorSquare {
            id: red
            color: modelData
            active: parent.paintColor == color
            onClicked: {
                parent.paintColor = color
            }
        }
    }
}
```

The colors are stored in an array and the paint color. When one the user clicks in one of the squares the color of the square is assigned to the `paintColor` property of the row named *colorTools*.

To enable tracking of the mouse events on the canvas we have a `MouseArea` covering the canvas element and hooked up the pressed and position changed handlers.

```qml
Canvas {
    id: canvas
    anchors {
        left: parent.left
        right: parent.right
        top: colorTools.bottom
        bottom: parent.bottom
        margins: 8
    }
    property real lastX
    property real lastY
    property color color: colorTools.paintColor

    onPaint: {
        var ctx = getContext('2d')
        ctx.lineWidth = 1.5
        ctx.strokeStyle = canvas.color
        ctx.beginPath()
        ctx.moveTo(lastX, lastY)
        lastX = area.mouseX
        lastY = area.mouseY
        ctx.lineTo(lastX, lastY)
        ctx.stroke()
    }
    MouseArea {
        id: area
        anchors.fill: parent
        onPressed: {
            canvas.lastX = mouseX
            canvas.lastY = mouseY
        }
        onPositionChanged: {
            canvas.requestPaint()
        }
    }
}
```

A mouse press stores the initial mouse position into the *lastX* and *lastY* properties. Every change on the mouse position triggers a paint request on the canvas, which will result in calling the *onPaint* handler.

To finally draw the users stroke, in the *onPaint* handler we begin a new path and move to the last position. Then we gather the new position from the mouse area and draw a line with the selected color to the new position. The mouse position is stored as the new *last* position.

