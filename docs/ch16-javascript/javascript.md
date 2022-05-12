# JavaScript

JavaScript is the lingua-franca on web client development. It also starts to get traction on web server development mainly by node js. As such it is a well-suited addition as an imperative language onto the side of declarative QML language. QML itself as a declarative language is used to express the user interface hierarchy but is limited to express operational code. Sometimes you need a way to express operations, here JavaScript comes into play.

::: tip
There is an open question in the Qt community about the right mixture about QML/JS/Qt C++ in a modern Qt application. The commonly agreed recommended mixture is to limit the JS part of your application to a minimum and do your business logic inside Qt C++ and the UI logic inside QML/JS.
:::

This book pushes the boundaries, which is not always the right mix for a product development and not for everyone. It is important to follow your team skills and your personal taste. In doubt follow the recommendation.

Here a short example of how JS used in QML looks like:

```qml
Button {
  width: 200
  height: 300
  property bool checked: false
  text: "Click to toggle"

  // JS function
  function doToggle() {
    checked = !checked
  }

  onClicked: {
    // this is also JavaScript
    doToggle();
    console.log('checked: ' + checked)
  }
}
```

So JavaScript can come in many places inside QML as a standalone JS function, as a JS module and it can be on every right side of a property binding.

```qml
import "util.js" as Util // import a pure JS module

Button {
  width: 200
  height: width*2 // JS on the right side of property binding

  // standalone function (not really useful)
  function log(msg) {
    console.log("Button> " + msg);
  }

  onClicked: {
    // this is JavaScript
    log();
    Qt.quit();
  }
}
```

Within QML you declare the user interface, with JavaScript you make it functional. So how much JavaScript should you write? It depends on your style and how familiar you are with JS development. JS is a loosely typed language, which makes it difficult to spot type defects. Also, functions expect all argument variations, which can be a very nasty bug to spot. The way to spot defects is rigorous unit testing or acceptance testing. So if you develop real logic (not some glue lines of code) in JS you should really start using the test-first approach. In generally mixed teams (Qt/C++ and QML/JS) are very successful when they minimize the amount of JS in the frontend as the domain logic and do the heavy lifting in Qt C++ in the backend. The backend should then be rigorous unit tested so that the frontend developers can trust the code and focus on all these little user interface requirements.

::: tip
In general: backend developers are functional driven and frontend developers are user story driven.
:::

