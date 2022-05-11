## Summary

In this chapter, we have looked at creating QML elements dynamically. This lets us create QML scenes freely, opening the door for user configurable and plug-in based architectures.

The easiest way to dynamically load a QML element is to use a `Loader` element. This acts as a placeholder for the contents being loaded.

For a more dynamic approach, the `Qt.createQmlObject` function can be used to instantiate a string of QML. This approach does, however, have limitations. The full-blown solution is to dynamically create a `Component` using the `Qt.createComponent` function. Objects are then created by calling the `createObject` function of a `Component`.

As bindings and signal connections rely on the existence of an object `id`, or access to the object instantiation, an alternate approach must be used for dynamically created objects. To create a binding, the `Binding` element is used. The `Connections` element makes it possible to connect to signals of a dynamically created object.

One of the challenges of working with dynamically created items is to keep track of them. This can be done using a model. By having a model tracking the dynamically created items, it is possible to implement functions for serialization and deserialization, making it possible to store and restore dynamically created scenes.
