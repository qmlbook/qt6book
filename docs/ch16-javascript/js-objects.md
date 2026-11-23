# JS 对象

在使用 JS 时，有一些对象和方法使用得更为频繁。这里是其中的一个小集合。


* `Math.floor(v)`、`Math.ceil(v)`、`Math.round(v)` - 从浮点数获取最大整数、最小整数、四舍五入后的整数

* `Math.random()` - 生成 0 到 1 之间的随机数

* `Object.keys(o)` - 从对象（包括 QObject）获取键

* `JSON.parse(s)`、`JSON.stringify(o)` - JS 对象与 JSON 字符串之间的转换

* `Number.toFixed(p)` - 指定精度的浮点数

* `Date` - 日期操作

你也可以在以下位置找到它们：[JavaScript 参考文档](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference)

下面是一些关于如何在 QML 中使用 JS 的简短而有限的示例。它们应该能让你了解如何在 QML 中使用 JS。

## 打印 QML Item 的所有键

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

## 将对象解析为 JSON 字符串并还原

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

## 当前日期

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

## 按名称调用函数

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
