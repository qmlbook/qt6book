# Animations

Animations are applied to property changes. An animation defines the interpolation curve from one value to another value when a property value changes. These animation curves create smooth transitions from one value to another. 

An animation is defined by a series of target properties to be animated, an easing curve for the interpolation curve, and a duration. All animations in Qt Quick are controlled by the same timer and are therefore synchronized. This improves the performance and visual quality of animations.

::: tip Animations control how properties change using value interpolation

This is a fundamental concept. QML is based on elements, properties, and scripting. Every element provides dozens of properties, each property is waiting to get animated by you. In the book, you will see this is a spectacular playing field. 

You will catch yourself looking at some animations and just admiring their beauty, and your creative genius, too. Please remember then: *animations control property changes and every element has dozens of properties at your disposal*.

**Unlock the power!**
:::

![](./assets/animation_sequence.png)

<<< @/docs/ch05-fluid/src/animation/AnimationExample.qml#global

The example above shows a simple animation applied on the `x` and `rotation` properties. Each animation has a duration of 4000 milliseconds (msec). The animation on `x` moves the x-coordinate from the object gradually over to 240px. The animation on rotation runs from the current angle to 360 degrees. Both animations run in parallel and are started when the `MouseArea` is clicked.

You can play around with the animation by changing the `to` and `duration` properties, or you could add another animation (for example, on the `opacity` or even the `scale`). **Combining these it could look like the object is disappearing into deep space. Try it out!**

## Animation Elements

There are several types of animation elements, each optimized for a specific use case. Here is a list of the most prominent animations:


* `PropertyAnimation` - Animates changes in property values

* `NumberAnimation` - Animates changes in qreal-type values

* `ColorAnimation` - Animates changes in color values

* `RotationAnimation` - Animates changes in rotation values

Besides these basic and widely used animation elements, Qt Quick also provides more specialized animations for specific use cases:


* `PauseAnimation` - Provides a pause for an animation

* `SequentialAnimation` - Allows animations to be run sequentially

* `ParallelAnimation` - Allows animations to be run in parallel

* `AnchorAnimation` - Animates changes in anchor values

* `ParentAnimation` - Animates changes in parent values

* `SmoothedAnimation` - Allows a property to smoothly track a value

* `SpringAnimation` - Allows a property to track a value in a spring-like motion

* `PathAnimation` - Animates an item alongside a path

* `Vector3dAnimation` - Animates changes in QVector3d values

Later we will learn how to create a sequence of animations. While working on more complex animations, there is sometimes a need to change a property or to run a script during an ongoing animation. For this Qt Quick offers the action elements, which can be used everywhere where the other animation elements can be used:


* `PropertyAction` - Specifies immediate property changes during animation

* `ScriptAction` - Defines scripts to be run during an animation

The major animation types will be discussed in this chapter using small, focused examples.

## Applying Animations

Animation can be applied in several ways:


* **Animation on property** - runs automatically after the element is fully loaded

* **Behavior on property** - runs automatically when the property value changes

* **Standalone Animation** - runs when the animation is explicitly started using `start()` or `running` is set to true (e.g. by a property binding)

*Later we will also see how animations can be used inside state transitions.*

## Clickable Image V2

To demonstrate the usage of animations we reuse our ClickableImage component from an earlier chapter and extended it with a text element.

<<< @/docs/ch05-fluid/src/animation/ClickableImageV2.qml#global

To organize the element below the image we used a Column positioner and calculated the width and height based on the column’s childrenRect property. We exposed text and image source properties, and a clicked signal. We also wanted the text to be as wide as the image, and for it to wrap. We achieve the latter by using the Text element's `wrapMode` property.

::: tip Parent/child geometry dependency
Due to the inversion of the geometry-dependency (parent geometry depends on child geometry), we can’t set a `width`/`height` on the ClickableImageV2, as this will break our `width`/`height` binding. 

You should prefer the child’s geometry to depend on the parent’s geometry if the item is more like a container for other items and should adapt to the parent's geometry.
:::

### The objects ascending

![](./assets/animationtypes_start.png)

The three objects are all at the same y-position (`y=200`). They all need to travel to `y=40`, each of them using a different method with different side-effects and features.

### First object

The first object travels using the `Animation on <property>` strategy. The animation starts immediately. 

<<< @/docs/ch05-fluid/src/animation/AnimationTypesExample.qml#animation-on-property

When an object is clicked, its y-position is reset to the start position, and this applies to all of the objects. On the first object, the reset does not have any effect as long as the animation is running. 

This can be visually disturbing, as the y-position is set to a new value for a fraction of a second before the animation starts. *Such competing property changes should be avoided*.

### Second object

The second object travels using a `Behavior on` animation. This behavior tells the property it should animate each change in value. The behavior can be disabled by setting `enabled: false` on the `Behavior` element. 

<<< @/docs/ch05-fluid/src/animation/AnimationTypesExample.qml#behavior-on

The object will start traveling when you click it (its y-position is then set to 40). Another click has no influence, as the position is already set. 

You could try to use a random value (e.g. `40 + (Math.random() \* (205-40)`) for the y-position. You will see that the object will always animate to the new position and adapt its speed to match the 4 seconds to the destination defined by the duration of the animation.

### Third object

The third object uses a standalone animation. The animation is defined as its own element and can be almost anywhere in the document. 

<<< @/docs/ch05-fluid/src/animation/AnimationTypesExample.qml#standalone

The click will start the animation using the animation's `start()` function. Each animation has start(), stop(), resume(), and restart() functions. The animation itself contains much more information than the other animation types earlier. 

We need to define the `target`, which is the element to be animated, along with the names of the properties that we want to animate. We also need to define a `to` value, and, in this case, a `from` value, which allows a restart of the animation.

![](./assets/animationtypes.png)

A click on the background will reset all objects to their initial position. The first object cannot be restarted except by re-starting the program which triggers the re-loading of the element.

::: tip Other ways to control Animations

Another way to start/stop an animation is to bind a property to the `running` property of an animation. This is especially useful when the user-input is in control of properties:

```qml
NumberAnimation {
    // [...]
    // animation runs when mouse is pressed
    running: area.pressed
}
MouseArea {
    id: area
}
```
:::

## Easing Curves

The value change of a property can be controlled by an animation. Easing attributes allow influencing the interpolation curve of a property change. 

All animations we have defined by now use a linear interpolation because the initial easing type of an animation is `Easing.Linear`. It’s best visualized with a small plot, where the y-axis is the property to be animated and the x-axis is the time (*duration*). A linear interpolation would draw a straight line from the `from` value at the start of the animation to the `to` value at the end of the animation. So the easing type defines the curve of change. 

Easing types should be carefully chosen to support a natural fit for a moving object. For example, when a page slides out, the page should initially slide out slowly and then gain momentum to finally slide out at high speed, similar to turning the page of a book.

:::tip Animations should not be overused. 

As with other aspects of UI design, animations should be designed carefully to support the UI flow, not dominate it. The eye is very sensitive to moving objects and animations can easily distract the user.
:::

In the next example, we will try some easing curves. Each easing curve is displayed by a clickable image and, when clicked, will set a new easing type on the `square` animation and then trigger a `restart()` to run the animation with the new curve.

![](./assets/automatic/easingcurves.png)

The code for this example was made a little bit more complicated. We first create a grid of `EasingTypes` and a `Box` which is controlled by the easing types. An easing type just displays the curve which the box shall use for its animation. When the user clicks on an easing curve the box moves in a direction according to the easing curve. The animation itself is a standalone animation with the target set to the box and configured for x-property animation with a duration of 2 seconds.

::: tip
The internals of the EasingType renders the curve in real time, and the interested reader can look it up in the `EasingCurves` example.
:::

<<< @/docs/ch05-fluid/src/easing/EasingCurves.qml#global

Please play with the example and observe the change of speed during an animation. Some animations feel more natural for the object and some feel irritating.

Besides the `duration` and `easing.type`, you are able to fine-tune animations. For example, the general `PropertyAnimation` type (from which most animations inherit) additionally supports `easing.amplitude`, `easing.overshoot`, and `easing.period` properties, which allow you to fine-tune the behavior of particular easing curves. 

Not all easing curves support these parameters. Please consult the [easing table](http://doc.qt.io/qt-6/qml-qtquick-propertyanimation.html#easing-prop) from the `PropertyAnimation` documentation to check if an easing parameter has an influence on an easing curve.

::: tip Choose the right Animation

Choosing the right animation for the element in the user interface context is crucial for the outcome. Remember the animation shall support the UI flow; not irritate the user.
:::

## Grouped Animations

Often animations will be more complex than just animating one property. You might want to run several animations at the same time or one after another or even execute a script between two animations. 

For this, grouped animations can be used. As the name suggests, it’s possible to group animations. Grouping can be done in two ways: parallel or sequential. You can use the `SequentialAnimation` or the `ParallelAnimation` element, which act as animation containers for other animation elements. These grouped animations are animations themselves and can be used exactly as such.

![](./assets/groupedanimation.png)

### Parallel animations

All direct child animations of a parallel animation run in parallel when started. This allows you to animate different properties at the same time.

<<< @/docs/ch05-fluid/src/animation/ParallelAnimationExample.qml#global

![](./assets/parallelanimation_sequence.png)

### Sequential animations

A sequential animation runs each child animation in the order in which it is declared: top to bottom.

<<< @/docs/ch05-fluid/src/animation/SequentialAnimationExample.qml#global

![](./assets/sequentialanimation_sequence.png)

### Nested animations

Grouped animations can also be nested. For example, a sequential animation can have two parallel animations as child animations, and so on. We can visualize this with a soccer ball example. The idea is to throw a ball from left to right and animate its behavior.

![](./assets/soccer_init.png)

To understand the animation we need to dissect it into the integral transformations of the object. We need to remember that animations animate property changes. Here are the different transformations:

* An x-translation from left-to-right (`X1`)

* A y-translation from bottom to top (`Y1`) followed by a translation from up to down (`Y2`) with some bouncing

* A rotation of 360 degrees over the entire duration of the animation (`ROT1`)

The whole duration of the animation should take three seconds.

![](./assets/soccer_plan.png)

We start with an empty item as the root element of the width of 480 and height of 300.

```qml
import QtQuick

Item {
    id: root

    property int duration: 3000

    width: 480
    height: 300

    // [...]
}
```

We have defined our total animation duration as a reference to better synchronize the animation parts.

The next step is to add the background, which in our case are 2 rectangles with green and blue gradients.

<<< @/docs/ch05-fluid/src/animation/BouncingBallExample.qml#background

![](./assets/soccer_stage1.png)

The upper blue rectangle takes 200 pixels of the height and the lower one is anchored to the bottom of the sky and to the bottom of the root element.

Let’s bring the soccer ball onto the green. The ball is an image, stored under “assets/soccer_ball.png”. For the beginning, we would like to position it in the lower left corner, near the edge.

<<< @/docs/ch05-fluid/src/animation/BouncingBallExample.qml#soccer-ball

![](./assets/soccer_stage2.png)

The image has a mouse area attached to it. If the ball is clicked, the position of the ball will reset and the animation is restarted.

Let’s start with a sequential animation for the two y translations first.

```qml
SequentialAnimation {
    id: anim
    NumberAnimation {
        target: ball
        properties: "y"
        to: 20
        duration: root.duration * 0.4
    }
    NumberAnimation {
        target: ball
        properties: "y"
        to: 240
        duration: root.duration * 0.6
    }
}
```

![](./assets/soccer_stage3.png)

This specifies that 40% of the total animation duration is the up animation and 60% the down animation, with each animation running after the other in sequence. The transformations are animated on a linear path but there is no curving currently. Curves will be added later using the easing curves, at the moment we’re concentrating on getting the transformations animated.

Next, we need to add the x-translation. The x-translation shall run in parallel with the y-translation, so we need to encapsulate the sequence of y-translations into a parallel animation together with the x-translation.

```qml
ParallelAnimation {
    id: anim
    SequentialAnimation {
        // ... our Y1, Y2 animation
    }
    NumberAnimation { // X1 animation
        target: ball
        properties: "x"
        to: 400
        duration: root.duration
    }
}
```

![](./assets/soccer_stage4.png)

In the end, we would like the ball to be rotating. For this, we need to add another animation to the parallel animation. We choose `RotationAnimation`, as it’s specialized for rotation.

```qml
ParallelAnimation {
    id: anim
    SequentialAnimation {
        // ... our Y1, Y2 animation
    }
    NumberAnimation { // X1 animation
        // X1 animation
    }
    RotationAnimation {
        target: ball
        properties: "rotation"
        to: 720
        duration: root.duration
    }
}
```

That’s the whole animation sequence. The one thing that's left is to provide the correct easing curves for the movements of the ball. For the *Y1* animation, we use a `Easing.OutCirc` curve, as this should look more like a circular movement. *Y2* is enhanced using an `Easing.OutBounce` to give the ball its bounce, and the bouncing should happen at the end (try with `Easing.InBounce` and you will see that the bouncing starts right away).

The *X1* and *ROT1* animation are left as-is, with a linear curve.

Here is the final animation code for your reference:

<<< @/docs/ch05-fluid/src/animation/BouncingBallExample.qml#parallel-animation
