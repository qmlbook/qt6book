# Playing Media

The most basic case of multimedia integration in a QML application is for it to playback media. The `QtMultimedia` module supports this by providing a dedicated QML component: the `MediaPlayer`.

The `MediaPlayer` component is a non-visual item that connects a media source to one or several output channel(s). Depending on the nature of the media (i.e. audio, image or video) various output channel(s) can be configured.

## Playing audio

In the following example, the `MediaPlayer` plays a mp3 sample audio file from a remote URL in an empty window:

<<< @/docs/ch11-multimedia/src/playback-audio/main.qml#global

In this example, the `MediaPlayer` defines two attributes: 

- `source`: it contains the URL of the media to play. It can either be embedded (`qrc://`), local (`file://`) or remote (`https://`).
- `audioOutput`: it contains an audio output channel, `AudioOutput`, connected to a physical output device. By default, it will use the default audio output device of the system.

As soon as the main component has been fully initialized, the player’s `play` function is called:

<<< @/docs/ch11-multimedia/src/playback-audio/main.qml#play


## Playing a video

If you want to play visual media such as pictures or videos, you must also define a `VideoOutput` element to place the resulting image or video in the user interface.

In the following example, the `MediaPlayer` plays a mp4 sample video file from a remote URL and centers the video content in the window:

<<< @/docs/ch11-multimedia/src/playback-video/main.qml#global

In this example, the `MediaPlayer` defines a third attribute:

- `videoOutput`: it contains the video output channel, `VideoOutput`, representing the visual space reserved to display the video in the user interface.

::: tip
Please note that the `VideoOutput` component is a visual item. As such, it's essential that it is created within the visual components hierarchy and not within the `MediaPlayer` itself.
:::


## Controlling the playback

The `MediaPlayer` component offers several useful properties. For instance, the `duration` and `position` properties can be used to build a progress bar. If the `seekable` property is `true`, it is even possible to update the `position` when the progress bar is tapped.

It's also possible to leverage `AudioOutput` and `VideoOutput` properties to customize the experience and provide, for instance, volume control.

The following example adds custom controls for the playback:

* a volume slider
* a play/pause button
* a progress slider

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#global

### The volume slider
A vertical `Slider` component is added on the top right corner of the window, allowing the user to control the volume of the media:

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#volume-slider

The volume attribute of the `AudioOutput` is then mapped to the value of the slider:

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#audio-output

### Play / Pause

A `Button` component reflects the playback state of the media and allows the user to control this state: 

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#button

Depending on the playback state, a different text will be displayed in the button. When clicked, the corresponding action will be triggered and will either play or pause the media.

::: tip
The possible playback states are listed below: 
* `MediaPlayer.PlayingState`: The media is currently playing.
* `MediaPlayer.PausedState`: Playback of the media has been suspended.
* `MediaPlayer.StoppedState`: Playback of the media is yet to begin.
::: 


### Interactive progress slider

A `Slider` component is added to reflect the current progress of the playback. It also allows the user to control the current position of the playback.

<<< @/docs/ch11-multimedia/src/playback-controls/main.qml#progress-slider{5,6,19-21}

A few things to note on this sample: 
* This slider will only be enabled when the media is `seekable` (line 5)
* Its value will be set to the current media progress, i.e. `player.position / player.duration` (line 6)
* The media position will be *(also)* updated when the slider is moved by the user (lines 19-21)

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
