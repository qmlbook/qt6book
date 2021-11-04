# Sound Effects

When playing sound effects, the response time from requesting playback until actually playing becomes important. In this situation, the `SoundEffect` element comes in handy. By setting up the `source` property, a simple call to the `play` function immediately starts playback.

This can be utilized for audio feedback when tapping the screen, as shown below.

```qml
import QtQuick
import QtMultimedia

Window {
    width: 300
    height: 200
    visible: true

    SoundEffect {
        id: beep
        source: "file:beep.wav"
    }

    Rectangle {
        id: button

        anchors.centerIn: parent

        width: 200
        height: 100

        color: "red"

        MouseArea {
            anchors.fill: parent
            onClicked: beep.play()
        }
    }
}
```

The element can also be utilized to accompany a transition with audio. To trigger playback from a transition, the `ScriptAction` element is used.

The following example shows how sound effects elements can be used to accompany transition between visual states using animations:

```qml
import QtQuick
import QtQuick.Controls
import QtMultimedia

Window {
    width: 500
    height: 500
    visible: true

    SoundEffect { id: beep; source: "file:beep.wav"}
    SoundEffect { id: swosh; source: "file:swosh.wav" }

    Rectangle {
        id: rectangle

        anchors.centerIn: parent

        width: 300
        height: width

        color: "red"
        state: "DEFAULT"

        states: [
            State {
                name: "DEFAULT"
                PropertyChanges { target: rectangle; rotation: 0; }
            },
            State {
                name: "REVERSE"
                PropertyChanges { target: rectangle; rotation: 180; }
            }
        ]

        transitions: [
            Transition {
                to: "DEFAULT"
                ParallelAnimation {
                    ScriptAction { script: swosh.play(); }
                    PropertyAnimation { properties: "rotation"; duration: 200; }
                }
            },
            Transition {
                to: "REVERSE"
                ParallelAnimation {
                    ScriptAction { script: beep.play(); }
                    PropertyAnimation { properties: "rotation"; duration: 200; }
                }
            }
        ]
    }

    Button {
        anchors.centerIn: parent
        text: "Flip!"
        onClicked: rectangle.state = rectangle.state === "DEFAULT" ? "REVERSE" : "DEFAULT"
    }
}
```

In this example, we want to apply a 180 rotation animation to our `Rectangle` whenever the "Flip!" button is clicked. We also want to play a different sound when the rectangle flips in one direction or the other.

To do so, we first start by loading our effects: 

```qml
SoundEffect { id: beep; source: "file:beep.wav"}
SoundEffect { id: swosh; source: "file:swosh.wav" }
```

Then we define two states for our rectangle, `DEFAULT` and `REVERSE`, specifying the expected rotation angle for each state: 

```qml
states: [
    State {
        name: "DEFAULT"
        PropertyChanges { target: rectangle; rotation: 0; }
    },
    State {
        name: "REVERSE"
        PropertyChanges { target: rectangle; rotation: 180; }
    }
]
```

To provide between-states animation, we define two transitions:
```qml
transitions: [
    Transition {
        to: "DEFAULT"
        ParallelAnimation {
            ScriptAction { script: swosh.play(); }
            PropertyAnimation { properties: "rotation"; duration: 200; }
        }
    },
    Transition {
        to: "REVERSE"
        ParallelAnimation {
            ScriptAction { script: beep.play(); }
            PropertyAnimation { properties: "rotation"; duration: 200; }
        }
    }
]
```

Notice the `ScriptAction { script: swosh.play(); }` line. Using the `ScriptAction` component we can run an arbitrary script as part of the animation, which allows us to play the desired sound effect as part of the animation.

::: tip
In addition to the `play` function, a number of properties similar to the ones offered by `MediaPlayer` are available. Examples are `volume` and `loops`. The latter can be set to `SoundEffect.Infinite` for infinite playback. To stop playback, call the `stop` function.
:::

::: warning
When the PulseAudio backend is used, `stop` will not stop instantaneously, but only prevent further loops. This is due to limitations in the underlying API.
:::

