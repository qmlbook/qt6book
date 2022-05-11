## Creating and Destroying Objects

The `Loader` element makes it possible to populate part of a user interface dynamically. However, the overall structure of the interface is still static. Through JavaScript, it is possible to take one more step and to instantiate QML elements completely dynamically.

Before we dive into the details of creating elements dynamically, we need to understand the workflow. When loading a piece of QML from a file or even over the Internet, a component is created. The component encapsulates the interpreted QML code and can be used to create items. This means that loading a piece of QML code and instantiating items from it is a two-stage process. First, the QML code is parsed into a component. Then the component is used to instantiate actual item objects.

In addition to creating elements from QML code stored in files or on servers, it is also possible to create QML objects directly from text strings containing QML code. The dynamically created items are then treated in a similar fashion once instantiated.

### Dynamically Loading and Instantiating Items

When loading a piece of QML, it is first interpreted as a component. This includes loading dependencies and validating the code. The location of the QML being loaded can be either a local file, a Qt resource, or even a distance network location specified by a URL. This means that the loading time can be everything from instant, for instance, a Qt resource located in RAM without any non-loaded dependencies, to very long, meaning a piece of code located on a slow server with multiple dependencies that need to be loaded.

The status of a component being created can be tracked by it is `status` property. The available values are `Component.Null`, `Component.Loading`, `Component.Ready` and `Component.Error`. The `Null` to `Loading` to `Ready` is the usual flow. At any stage, the `status` can change to `Error`. In that case, the component cannot be used to create new object instances. The `Component.errorString()` function can be used to retrieve a user-readable error description.

When loading components over slow connections, the `progress` property can be of use. It ranges from `0.0`, meaning nothing has been loaded, to `1.0` indicating that all have been loaded. When the component’s `status` changes to `Ready`, the component can be used to instantiate objects. The code below demonstrates how that can be achieved, taking into account the event of the component becoming ready or failing to be created directly, as well as the case where a component is ready slightly later.

<<< @/docs/ch15-dynamicqml/src/load-component/create-component.js#M1

The code above is kept in a separate JavaScript source file, referenced from the main QML file.

<<< @/docs/ch15-dynamicqml/src/load-component/main.qml#M1

The `createObject` function of a component is used to create object instances, as shown above. This not only applies to dynamically loaded components but also `Component` elements inlined in the QML code. The resulting object can be used in the QML scene like any other object. The only difference is that it does not have an `id`.

The `createObject` function takes two arguments. The first is a `parent` object of the type `Item`. The second is a list of properties and values on the format `{"name": value, "name": value}`. This is demonstrated in the example below. Notice that the properties argument is optional.

```js
var image = component.createObject(root, {"x": 100, "y": 100});
```

::: tip
A dynamically created component instance is not different to an in-line `Component` element. The in-line `Component` element also provides functions to instantiate objects dynamically.
:::

#### Incubating Components

When components are created using `createObject` the creation of the object component is blocking. This means that the instantiation of a complex element may block the main thread, causing a visible glitch. Alternatively, complex components may have to be broken down and loaded in stages using `Loader` elements.

To resolve this problem, a component can be instantiated using the `incubateObject` method. This might work just as `createObject` and return an instance immediately, or it may call back when the component is ready. Depending on your exact setup, this may or may not be a good way to solve instantiation related animation glitches.

To use an incubator, simply use it as `createComponent`. However, the returned object is an incubator and not the object instance itself. When the incubator’s status is `Component.Ready`, the object is available through the `object` property of the incubator. All this is shown in the example below:

```js
function finishCreate() {
    if (component.status === Component.Ready) {
        var incubator = component.incubateObject(root, {"x": 100, "y": 100});
        if (incubator.status === Component.Ready) {
            var image = incubator.object; // Created at once
        } else {
            incubator.onStatusChanged = function(status) {
                if (status === Component.Ready) {
                    var image = incubator.object; // Created async
                }
            };
        }
    }
}
```

### Dynamically Instantiating Items from Text

Sometimes, it is convenient to be able to instantiate an object from a text string of QML. If nothing else, it is quicker than putting the code in a separate source file. For this, the `Qt.createQmlObject` function is used.

The function takes three arguments: `qml`, `parent` and `filepath`. The `qml` argument contains the string of QML code to instantiate. The `parent` argument provides a parent object to the newly created object. The `filepath` argument is used when reporting any errors from the creation of the object. The result returned from the function is either a new object or `null`.

::: warning
The `createQmlObject` function always returns immediately. For the function to succeed, all the dependencies of the call must be loaded. This means that if the code passed to the function refers to a non-loaded component, the call will fail and return `null`. To better handle this, the `createComponent` / `createObject` approach must be used.
:::

The objects created using the `Qt.createQmlObject` function resembles any other dynamically created object. That means that it is identical to every other QML object, apart from not having an `id`. In the example below, a new `Rectangle` element is instantiated from in-line QML code when the `root` element has been created.

<<< @/docs/ch15-dynamicqml/src/create-object/main.qml#M1

### Managing Dynamically Created Elements

Dynamically created objects can be treated as any other object in a QML scene. However, there are some pitfalls that we need to be aware of. The most important is the concept of the creation contexts.

The creation context of a dynamically created object is the context within it is being created. This is not necessarily the same context as the parent exists in. When the creation context is destroyed, so are the bindings concerning the object. This means that it is important to implement the creation of dynamic objects in a place in the code which will be instantiated during the entire lifetime of the objects.

Dynamically created objects can also be dynamically destroyed. When doing this, there is a rule of thumb: never attempt to destroy an object that you have not created. This also includes elements that you have created, but not using a dynamic mechanism such as `Component.createObject` or `createQmlObject`.

An object is destroyed by calling its `destroy` function. The function takes an optional argument which is an integer specifying how many milliseconds the objects shall exist before being destroyed. This is useful too, for instance, let the object complete a final transition.

```js
item = Qt.createQmlObject(...)
...
item.destroy()
```

::: tip
It is possible to destroy an object from within, making it possible to create self-destroying popup windows for instance.
:::

