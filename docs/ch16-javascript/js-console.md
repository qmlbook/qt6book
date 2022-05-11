# Creating a JS Console

As a little example, we will create a JS console. We need an input field where the user can enter his JS expressions and ideally there should be a list of output results. As this should more look like a desktop application we use the Qt Quick Controls module.

::: tip
A JS console inside your next project can be really beneficial for testing. Enhanced with a Quake-Terminal effect it is also good to impress customers. To use it wisely you need to control the scope the JS console evaluates in, e.g. the currently visible screen, the main data model, a singleton core object or all together.
:::



![image](./assets/jsconsole.png)

We use Qt Creator to create a Qt Quick UI project using Qt Quick controls. We call the project JSConsole. After the wizard has finished we have already a basic structure for the application with an application window and a menu to exit the application.

For the input, we use a TextField and a Button to send the input for evaluation. The result of the expression evaluation is displayed using a ListView with a ListModel as the model and two labels to display the expression and the evaluated result.

Our application will be split in two files: 
* `JSConsole.qml`: the main view of the app
* `jsconsole.js`: the javascript library responsible for evaluating user statements


## JSConsole.qml

### Application window
<<< @/docs/ch16-javascript/src/JSConsole/JSConsole.qml#application-window

### Form

<<< @/docs/ch16-javascript/src/JSConsole/JSConsole.qml#form{12,19,40-42,45,50,54-55}

### Calling the library

The evaluation function `jsCall` does the evaluation not by itself this has been moved to a JS module (`jsconsole.js`) for clearer separation.

<<< @/docs/ch16-javascript/src/JSConsole/JSConsole.qml#import

<<< @/docs/ch16-javascript/src/JSConsole/JSConsole.qml#js-call

::: tip
For safety, we do not use the `eval` function from JS as this would allow the user to modify the local scope. We use the Function constructor to create a JS function on runtime and pass in our scope as this variable. As the function is created every time it does not act as a closure and stores its own scope, we need to use `this.a = 10` to store the value inside this scope of the function. This scope is set by the script to the scope variable.
:::

## jsconsole.js

<<< @/docs/ch16-javascript/src/JSConsole/jsconsole.js#global

The data return from the call function is a JS object with a result, expression and error property: `data: { expression: "", result: "", error: "" }`. We can use this JS object directly inside the ListModel and access it then from the delegate, e.g. `delegate.model.expression` gives us the input expression.
