## Tracking Dynamic Objects

Working with dynamic objects, it is often necessary to track the created objects. Another common feature is to be able to store and restore the state of the dynamic objects. Both these tasks are easily handled using an `XmlListModel` that is dynamically populated.

In the example shown below two types of elements, rockets and UFOs can be created and moved around by the user. In order to be able to manipulate the entire scene of dynamically created elements, we use a model to track the items.

The model, a `XmlListModel`, is populated as the items are created. The object reference is tracked alongside the source URL used when instantiating it. The latter is not strictly needed for tracking the objects but will come in handy later.

<<< @/docs/ch15-dynamicqml/src/dynamic-scene/main.qml#M1

As you can tell from the example above, the `create-object.js` is a more generalized form of the JavaScript introduced earlier. The `create` method uses three arguments: a source URL, a root element, and a callback to invoke when finished. The callback gets called with two arguments: a reference to the newly created object and the source URL used.

This means that each time `addUfo` or `addRocket` functions are called, the `itemAdded` function will be called when the new object has been created. The latter will append the object reference and source URL to the `objectsModel` model.

The `objectsModel` can be used in many ways. In the example in question, the `clearItems` function relies on it. This function demonstrates two things. First, how to iterate over the model and perform a task, i.e. calling the `destroy` function for each item to remove it. Secondly, it highlights the fact that the model is not updated as objects are destroyed. Instead of removing the model item connected to the object in question, the `obj` property of that model item is set to `null`. To remedy this, the code explicitly has to clear the model item as the objects are removed.

<<< @/docs/ch15-dynamicqml/src/dynamic-scene/main.qml#M2

Having a model representing all dynamically created items, it is easy to create a function that serializes the items. In the example code, the serialized information consists of the source URL of each object along its `x` and `y` properties. These are the properties that can be altered by the user. The information is used to build an XML document string.

<<< @/docs/ch15-dynamicqml/src/dynamic-scene/main.qml#M3

::: tip
Currently, the `XmlListModel` of Qt 6 lacks the `xml` property and `get()` function needed to make serialization and deserialization work.
:::

The XML document string can be used with an `XmlListModel` by setting the `xml` property of the model. In the code below, the model is shown along the `deserialize` function. The `deserialize` function kickstarts the deserialization by setting the `dsIndex` to refer to the first item of the model and then invoking the creation of that item. The callback, `dsItemAdded` then sets that `x` and `y` properties of the newly created object. It then updates the index and creates the next object, if any.

<<< @/docs/ch15-dynamicqml/src/dynamic-scene/main.qml#M4

The example demonstrates how a model can be used to track created items, and how easy it is to serialize and deserialize such information. This can be used to store a dynamically populated scene such as a set of widgets. In the example, a model was used to track each item.

An alternate solution would be to use the `children` property of the root of a scene to track items. This, however, requires the items themselves to know the source URL to use to re-create them. It also requires us to implement a way to be able to tell dynamically created items apart from the items that are a part of the original scene, so that we can avoid attempting to serialize and later deserialize any of the original items.
