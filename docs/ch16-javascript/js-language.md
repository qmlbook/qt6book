# JS Language

This chapter will not give you a general introduction to JavaScript. There are other books out there for a general introduction to JavaScript, please visit this great side on [Mozilla Developer Network](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript).

On the surface JavaScript is a very common language and does not differ a lot from other languages:

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

But be warned JS has function scope and not block scope as in C++ (see [Functions and function scope](https://developer.mozilla.org/it/docs/Web/JavaScript/Reference/Functions_and_function_scope)).

The statements `if ... else`, `break`, `continue` also work as expected. The switch case can also compare other types and not just integer values:

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

JS knows several values which can be false, e.g. `false`, `0`, `""`, `undefined`, `null`). For example, a function returns by default `undefined`. To test for false use the `===` identity operator. The `==` equality operator will do type conversion to test for equality. If possible use the faster and better `===` strict equality operator which will test for identity (see [Comparison operators](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Comparison_Operators)).

Under the hood, javascript has its own ways of doing things. For example arrays:

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

Also for people coming from C++ or Java which are used to an OO language JS just works differently. JS is not purely an OO language it is a so-called prototype based language. Each object has a prototype object. An object is created based on his prototype object. Please read more about this in the book [Javascript the Good Parts by Douglas Crockford](http://javascript.crockford.com).

To test some small JS snippets you can use the online [JS Console](http://jsconsole.com) or just build a little piece of QML code:

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

