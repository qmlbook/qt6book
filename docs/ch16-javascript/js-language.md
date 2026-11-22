# JS 语言

本章不会为你提供 JavaScript 的通用入门介绍。市面上有其他书籍介绍 JavaScript 基础，请访问 [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript) 上这个优秀的网站。

从表面上看，JavaScript 是一种非常普通的语言，与其他语言差异不大：

```js
function countDown() {
  for(var i=0; i<10; i++) {
    console.log('index: ' + i)
  }
}

function countDown2() {
  var i=10;
  while( i>0 ) {
    i--;
  }
}
```

但请注意，JS 具有函数作用域（function scope），而不是像 C++ 那样的块作用域（block scope）（参见[函数和函数作用域](https://developer.mozilla.org/it/docs/Web/JavaScript/Reference/Functions_and_function_scope)）。

`if ... else`、`break`、`continue` 语句也能按预期工作。switch case 还可以比较其他类型，而不仅仅是整数值：

```js
function getAge(name) {
  // switch over a string
  switch(name) {
  case "father":
    return 58;
  case "mother":
    return 56;
  }
  return unknown;
}
```

JS 有若干可以视为假的值，例如 `false`、`0`、`""`、`undefined`、`null`。例如，函数默认返回 `undefined`。要测试假值，请使用 `===` 恒等运算符。`==` 相等运算符会进行类型转换来测试相等性。如果可能，请使用更快更好的 `===` 严格相等运算符，它测试的是恒等性（参见[比较运算符](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators)）。

在底层，JavaScript 有自己的处理方式。例如数组：

```js
function doIt() {
  var a = [] // empty arrays
  a.push(10) // addend number on arrays
  a.push("Monkey") // append string on arrays
  console.log(a.length) // prints 2
  a[0] // returns 10
  a[1] // returns Monkey
  a[2] // returns undefined
  a[99] = "String" // a valid assignment
  console.log(a.length) // prints 100
  a[98] // contains the value undefined
}
```

此外，对于来自 C++ 或 Java、习惯于面向对象（OO）语言的人来说，JS 的工作方式截然不同。JS 不是纯粹的面向对象语言，它是一种所谓的基于原型（prototype based）的语言。每个对象都有一个原型对象。对象基于其原型对象创建。请阅读 Douglas Crockford 所著的 [JavaScript the Good Parts](http://javascript.crockford.com) 一书了解更多信息。

要测试一些小的 JS 代码片段，你可以使用在线 [JS Console](http://jsconsole.com)，或者只需构建一小段 QML 代码：

```qml
import QtQuick 2.5

Item {
  function runJS() {
    console.log("Your JS code goes here");
  }
  Component.onCompleted: {
    runJS();
  }
}
```
