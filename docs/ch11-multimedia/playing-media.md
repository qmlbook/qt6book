# Playing Media

The most basic case of multimedia integration in a QML application is for it to playback media. This can be achieved using the `MediaPlayer` element. This QML component has a `source` property pointing at the media to play. When a media source has been bound, it is simply a matter of calling the `play` function to start playing it.

If you want to play visual media such as pictures or videos, you must also set up a `VideoOutput` element to place the resulting image in the user interface. The `MediaPlayer` running the playback is bound to the video output through the `source` property.

In the example shown below, the `MediaPlayer` is given a file with video contents as `source`. A `VideoOutput` is created and bound to the media player. As soon as the main component has been fully initialized, i.e. at `Component.onCompleted`, the player’s `play` function is called.

```qml
import QtQuick 6.2
import QtMultimedia

Item {
    width: 1024
    height: 600

    MediaPlayer {
        id: player
        source: "trailer_400p.ogg"
    }

    VideoOutput {
        anchors.fill: parent
        source: player
    }

    Component.onCompleted: {
        player.play();
    }
}
```

Basic operations such as altering the volume when playing media are controlled through the `volume` property of the `MediaPlayer` element. There are other useful properties as well. For instance, the `duration` and `position` properties can be used to build a progress bar. If the `seekable` property is `true`, it is even possible to update the `position` when the progress bar is tapped. However, the `position` property is read-only, instead we must use the `seek` method. The example below shows how this is added to the basic playback example above.

```qml
Rectangle {
    id: progressBar

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    anchors.margins: 100

    height: 30

    color: "lightGray"

    Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        width: player.duration>0?parent.width*player.position/player.duration:0

        color: "darkGray"
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if (player.seekable) {
                player.seek(player.duration * mouse.x/width);
            }
        }
    }
}
```

The `position` property is only updated once per second in the default case. This means that the progress bar will update in large steps unless the duration of the media is long enough, compared to the number of pixels that the progress bar is wide. This can, however, be changed through accessing the `mediaObject` property and its `notifyInterval` property. It can be set to the number of milliseconds between each position update, increasing the smoothness of the user interface.

```qml
Connections {
    target: player
    onMediaObjectChanged: {
        if (player.mediaObject) {
            player.mediaObject.notifyInterval = 50;
        }
    }
}
```

When using `MediaPlayer` to build a media player, it is good to monitor the `status` property of the player. It is an enumeration of the possible statuses, ranging from `MediaPlayer.Buffered` to `MediaPlayer.InvalidMedia`. The possible values are summarized in the bullets below:


* `MediaPlayer.UnknownStatus`. The status is unknown.


* `MediaPlayer.NoMedia`. The player has no media source assigned. Playback is stopped.


* `MediaPlayer.Loading`. The player is loading the media.


* `MediaPlayer.Loaded`. The media has been loaded. Playback is stopped.


* `MediaPlayer.Stalled`. The loading of media has stalled.


* `MediaPlayer.Buffering`. The media is being buffered.


* `MediaPlayer.Buffered`. The media has been buffered, this means that the player can start playing the media.


* `MediaPlayer.EndOfMedia`. The end of the media has been reached. Playback is stopped.


* `MediaPlayer.InvalidMedia`. The media cannot be played. Playback is stopped.

As mentioned in the bullets above, the playback state can vary over time. Calling `play`, `pause` or `stop` alters the state, but the media in question can also have an effect. For example, the end can be reached, or it can be invalid, causing playback to stop. The current playback state can be tracked through the `playbackState` property. The values can be `MediaPlayer.PlayingState`, `MediaPlayer.PausedState` or `MediaPlayer.StoppedState`.

Using the `autoPlay` property, the `MediaPlayer` can be made to attempt go to the playing state as soon as the `source` property is changed. A similar property is the `autoLoad` causing the player to try to load the media as soon as the `source` property is changed. The latter property is enabled by default.

It is also possible to let the `MediaPlayer` to loop a media item. The `loops` property controls how many times the `source` is to be played. Setting the property to `MediaPlayer.Infinite` causes endless looping. Great for continuous animations or a looping background song.

