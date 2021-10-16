# JS Objects

While working with JS there are some objects and methods which are more frequently used. This is a small collection of them.


* `Math.floor(v)`, `Math.ceil(v)`, `Math.round(v)` - largest, smallest, rounded integer from float

* `Math.random()` - create a random number between 0 and 1

* `Object.keys(o)` - get keys from object (including QObject)

* `JSON.parse(s)`, `JSON.stringify(o)` - conversion between JS object and JSON string

* `Number.toFixed(p)` - fixed precision float

* `Date` - Date manipulation

You can find them also at: [JavaScript reference](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference)

Here some small and limited examples of how to use JS with QML. They should give you an idea how you can use JS inside QML

## Print all keys from QML Item

```qml
Item {
    id: root
    Component.onCompleted: {
        var keys = Object.keys(root);
        for(var i=0; i<keys.length; i++) {
            var key = keys[i];
            // prints all properties, signals, functions from object
            console.log(key + ' : ' + root[key]);
        }
    }
}
```

## Parse an object to a JSON string and back

```qml
Item {
    property var obj: {
        key: 'value'
    }

    Component.onCompleted: {
        var data = JSON.stringify(obj);
        console.log(data);
        var obj = JSON.parse(data);
        console.log(obj.key); // > 'value'
    }
}
```

## Current Date

```qml
Item {
    Timer {
        id: timeUpdater
        interval: 100
        running: true
        repeat: true
        onTriggered: {
            var d = new Date();
            console.log(d.getSeconds());
        }
    }
}
```

## Call a function by name

```qml
Item {
    id: root

    function doIt() {
        console.log("doIt()")
    }

    Component.onCompleted: {
        // Call using function execution
        root["doIt"]();
        var fn = root["doIt"];
        // Call using JS call method (could pass in a custom this object and arguments)
        fn.call()
    }
}
```

