# Animating Shapes

One of the nice aspects of using Qt Quick Shapes, is that the paths drawn are defined directly in QML. This means that their properties can be bound, transitioned and animated, just like any other property in QML.

![](./assets/automatic/animation.png)

In the example below, we reuse the basic shape from the very first section of this chapter, but we introduce a variable, ``t``, that we animate from ``0.0`` to ``1.0`` in a loop. We then use this variable to offset the position of the small circles, as well as the size of the top and bottom circle. This creates an animation in which it seems that the circles appear at the top and disappear towards the bottom.

<<< @/docs/ch09-shapes/src/shapes/animation.qml#global

Notice that instead of using a ``NumberAnimation`` on ``t``, any other binding can be used, e.g. to a slider, an external state, and so on. Your imagination is the limit.
