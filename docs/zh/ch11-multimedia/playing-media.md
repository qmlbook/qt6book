# Playing Media

The most basic case of multimedia integration in a QML application is for it to playback media. The `QtMultimedia` module supports this by providing a dedicated QML component: the `MediaPlayer`.

The `MediaPlayer` component is a non-visual item that connects a media source to one or several output channel(s). Depending on the nature of the media (i.e. audio, image or video) various output channel(s) can be configured.

## Playing audio

In the following example, the `MediaPlayer` plays a mp3 sample audio file from a remote URL in an empty window:

```qml
import QtQuick
import QtMultimedia

Window {
    width: 1024
    height: 768
    visible: true

    MediaPlayer {
        id: player
        source: "https://file-examples-com.github.io/uploads/2017/11/file_example_MP3_2MG.mp3"
        audioOutput: AudioOutput {}
    }

    Component.onCompleted: {
        player.play()
    }
}
```

In this example, the `MediaPlayer` defines two attributes: 

- `source`: it contains the URL of the media to play. It can either be embedded (`qrc://`), local (`file://`) or remote (`https://`).
- `audioOutput`: it contains an audio output channel, `AudioOutput`, connected to a physical output device. By default, it will use the default audio output device of the system.

As soon as the main component has been fully initialized, the player’s `play` function is called:

```qml
Component.onCompleted: {
    player.play()
}
```

## Playing a video

If you want to play visual media such as pictures or videos, you must also define a `VideoOutput` element to place the resulting image or video in the user interface.

In the following example, the `MediaPlayer` plays a mp4 sample video file from a remote URL and centers the video content in the window:

```qml
import QtQuick
import QtMultimedia

Window {
    width: 1920
    height: 1080
    visible: true

    MediaPlayer {
        id: player
        source: "https://file-examples-com.github.io/uploads/2017/04/file_example_MP4_1920_18MG.mp4"
        audioOutput: AudioOutput {}
        videoOutput: videoOutput
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        anchors.margins: 20
    }

    Component.onCompleted: {
        player.play()
    }
}
```

In this example, the `MediaPlayer` defines a third attribute:

- `videoOutput`: it contains the video output channel, `VideoOutput`, representing the visual space reserved to display the video in the user interface.

::: warning
Please note that the `VideoOutput` component is a visual item. As such, it's essential that it is created within the visual components hierarchy and not within the `MediaPlayer` itself.
:::


## Controlling the playback

The `MediaPlayer` component offers several useful properties. For instance, the `duration` and `position` properties can be used to build a progress bar. If the `seekable` property is `true`, it is even possible to update the `position` when the progress bar is tapped.

It's also possible to leverage `AudioOutput` and `VideoOutput` properties to customize the experience and provide, for instance, volume control.

The following example adds custom controls for the playback:

* a volume slider
* a play/pause button
* a progress slider

```qml
import QtQuick
import QtQuick.Controls
import QtMultimedia

Window {
    id: root
    width: 960
    height: 400
    visible: true

    MediaPlayer {
        id: player
        source: "file:///path-to-your-video-file.mp4"
        audioOutput: audioOutput
        videoOutput: videoOutput
    }

    AudioOutput {
        id: audioOutput
        volume: volumeSlider.value
    }

    VideoOutput {
        id: videoOutput
        width: videoOutput.sourceRect.width
        height: videoOutput.sourceRect.height
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Slider {
        id: volumeSlider
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 20
        orientation: Qt.Vertical
        value: 0.5
    }

    Item {
        height: 50
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        Button {
            anchors.horizontalCenter: parent.horizontalCenter
            text: player.playbackState ===  MediaPlayer.PlayingState ? qsTr("Pause") : qsTr("Play")
            onClicked: {
                switch(player.playbackState) {
                    case MediaPlayer.PlayingState: player.pause(); break;
                    case MediaPlayer.PausedState: player.play(); break;
                    case MediaPlayer.StoppedState: player.play(); break;
                }
            }
        }

        Slider {
            id: progressSlider
            width: parent.width
            anchors.bottom: parent.bottom
            enabled: player.seekable
            value: player.duration > 0 ? player.position / player.duration : 0
            background: Rectangle {
                implicitHeight: 8
                color: "white"
                radius: 3
                Rectangle {
                    width: progressSlider.visualPosition * parent.width
                    height: parent.height
                    color: "#1D8BF8"
                    radius: 3
                }
            }
            handle: Item {}
            onMoved: function () {
                player.position = player.duration * progressSlider.position
            }
        }
    }

    Component.onCompleted: {
        player.play()
    }
}
```

### The volume slider
A vertical `Slider` component is added on the top right corner of the window, allowing the user to control the volume of the media:

```qml
Slider {
    id: volumeSlider
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.margins: 20
    orientation: Qt.Vertical
    value: 0.5
}
```

The volume attribute of the `AudioOutput` is then mapped to the value of the slider:

```qml
AudioOutput {
    id: audioOutput
    volume: volumeSlider.value
}
```

### Play / Pause

A `Button` component reflects the playback state of the media and allows the user to control this state: 

```qml
Button {
    anchors.horizontalCenter: parent.horizontalCenter
    text: player.playbackState ===  MediaPlayer.PlayingState ? qsTr("Pause") : qsTr("Play")
    onClicked: {
        switch(player.playbackState) {
            case MediaPlayer.PlayingState: player.pause(); break;
            case MediaPlayer.PausedState: player.play(); break;
            case MediaPlayer.StoppedState: player.play(); break;
        }
    }
}
```

Depending on the playback state, a different text will be displayed in the button. When clicked, the corresponding action will be triggered and will either play or pause the media.

::: tip
The possible playback states are listed below: 
* `MediaPlayer.PlayingState`: The media is currently playing.
* `MediaPlayer.PausedState`: Playback of the media has been suspended.
* `MediaPlayer.StoppedState`: Playback of the media is yet to begin.
::: 


### Interactive progress slider

A `Slider` component is added to reflect the current progress of the playback. It also allows the user to control the current position of the playback.

```qml
Slider {
    id: progressSlider
    width: parent.width
    anchors.bottom: parent.bottom
    enabled: player.seekable
    value: player.duration > 0 ? player.position / player.duration : 0
    background: Rectangle {
        implicitHeight: 8
        color: "white"
        radius: 3
        Rectangle {
            width: progressSlider.visualPosition * parent.width
            height: parent.height
            color: "#1D8BF8"
            radius: 3
        }
    }
    handle: Item {}
    onMoved: function () {
        player.position = player.duration * progressSlider.position
    }
}
```

This slider will only be enabled when the media is `seekable`:

```qml
Slider {
    /* ... */
    enabled: player.seekable
    /* ... */
}
```

Its value will be set to the current media progress, i.e. `player.position / player.duration`:

```qml
Slider {
    /* ... */
    value: player.duration > 0 ? player.position / player.duration : 0
    /* ... */
}
```

When the slider is moved by the user, the media position will be updated:
```qml
Slider {
    /* ... */
    onMoved: function () {
        player.position = player.duration * progressSlider.position
    }
    /* ... */
}
```

## The media status

When using `MediaPlayer` to build a media player, it is good to monitor the `status` property of the player. Here is an enumeration of the possible statuses, ranging from `MediaPlayer.Buffered` to `MediaPlayer.InvalidMedia`. The possible values are summarized in the bullets below:

* `MediaPlayer.NoMedia`. No media has been set. Playback is stopped.
* `MediaPlayer.Loading`. The media is currently being loaded.
* `MediaPlayer.Loaded`. The media has been loaded. Playback is stopped.
* `MediaPlayer.Buffering`. The media is buffering data.
* `MediaPlayer.Stalled`. The playback has been interrupted while the media is buffering data.
* `MediaPlayer.Buffered`. The media has been buffered, this means that the player can start playing the media.
* `MediaPlayer.EndOfMedia`. The end of the media has been reached. Playback is stopped.
* `MediaPlayer.InvalidMedia`. The media cannot be played. Playback is stopped.
* `MediaPlayer.UnknownStatus`. The status of the media is unknown.

As mentioned in the bullets above, the playback state can vary over time. Calling `play`, `pause` or `stop` alters the state, but the media in question can also have an effect. For example, the end can be reached, or it can be invalid, causing playback to stop. 

::: tip
It is also possible to let the `MediaPlayer` to loop a media item. The `loops` property controls how many times the `source` is to be played. Setting the property to `MediaPlayer.Infinite` causes endless looping. Great for continuous animations or a looping background song.
:::
