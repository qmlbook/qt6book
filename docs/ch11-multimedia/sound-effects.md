# Sound Effects

When playing sound effects, the response time from requesting playback until actually playing becomes important. In this situation, the `SoundEffect` element comes in handy. By setting up the `source` property, a simple call to the `play` function immediately starts playback.

This can be utilized for audio feedback when tapping the screen, as shown below.

<<< @/docs/ch11-multimedia/src/sound-effects/basic.qml#global

The element can also be utilized to accompany a transition with audio. To trigger playback from a transition, the `ScriptAction` element is used.

The following example shows how sound effects elements can be used to accompany transition between visual states using animations:

<<< @/docs/ch11-multimedia/src/sound-effects/complete.qml#global

In this example, we want to apply a 180 rotation animation to our `Rectangle` whenever the "Flip!" button is clicked. We also want to play a different sound when the rectangle flips in one direction or the other.

To do so, we first start by loading our effects: 

<<< @/docs/ch11-multimedia/src/sound-effects/complete.qml#effects

Then we define two states for our rectangle, `DEFAULT` and `REVERSE`, specifying the expected rotation angle for each state: 

<<< @/docs/ch11-multimedia/src/sound-effects/complete.qml#states

To provide between-states animation, we define two transitions:

<<< @/docs/ch11-multimedia/src/sound-effects/complete.qml#transitions

Notice the `ScriptAction { script: swosh.play(); }` line. Using the `ScriptAction` component we can run an arbitrary script as part of the animation, which allows us to play the desired sound effect as part of the animation.

::: tip
In addition to the `play` function, a number of properties similar to the ones offered by `MediaPlayer` are available. Examples are `volume` and `loops`. The latter can be set to `SoundEffect.Infinite` for infinite playback. To stop playback, call the `stop` function.
:::

::: warning
When the PulseAudio backend is used, `stop` will not stop instantaneously, but only prevent further loops. This is due to limitations in the underlying API.
:::

