# Using FileIO

Now we can use our newly created file to access some data. In this example, we will some city data in a JSON format and display it in a table. We build this as two projects: one for the extension plugin (called `fileio`) which provides us a way to read and write text from a file, and the other, which displays the data in a table, (`CityUI`). The `CityUI` uses the `fileio`extension for reading and writing files. 

![image](./images/cityui_mock.png)

JSON data is just text that is formatted in such a way that it can be converted into a valid JS object/array and back to text. We use our `FileIO` to read the JSON formatted data and convert it into a JS object using the built-in Javascript function `JSON.parse()`. The data is later used as a model for the table view. This is implemented in the read document and write document functions shown below. 

<<< @/docs/ch18-extensions/src/CityUI/main.qml#readwrite

The JSON data used in this example is in the `cities.json` file.
It contains a list of city data entries, where each entry contains interesting data about the city such as what is shown below.

```json
[
    {
        "area": "1928",
        "city": "Shanghai",
        "country": "China",
        "flag": "22px-Flag_of_the_People's_Republic_of_China.svg.png",
        "population": "13831900"
    },
    ...
]
```

## The Application Window

We use the Qt Creator `QtQuick Application` wizard to create a Qt Quick Controls 2 based application. We will not use the new QML forms as this is difficult to explain in a book, although the new forms approach with a *ui.qml* file is much more usable than previous. So you can remove/delete the forms file for now.

The basic setup is an `ApplicationWindow` which can contain a toolbar, menubar, and status bar. We will only use the menubar to create some standard menu entries for opening and saving the document. The basic setup will just display an empty window.

```qml
import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    id: root
    title: qsTr("City UI")
    width: 640
    height: 480
    visible: true
}
```

## Using Actions

To better use/reuse our commands we use the QML `Action` type. This will allow us later to use the same action also for a potential toolbar. The open and save and exit actions are quite standard. The open and save action do not contain any logic yet, this we will come later. The menubar is created with a file menu and these three action entries. Additional we prepare already a file dialog, which will allow us to pick our city document later. A dialog is not visible when declared, you need to use the `open()` method to show it.

<<< @/docs/ch18-extensions/src/CityUI/main.qml#actions

## Formatting the Table

The content of the city data shall be displayed in a table. For this, we use the `TableView` control and declare 4 columns: city, country, area, population. Each column is a standard `TableViewColumn`. Later we will add columns for the flag and remove operation which will require a custom column delegate.

```qml
TableView {
    id: view
    anchors.fill: parent
    TableViewColumn {
        role: 'city'
        title: "City"
        width: 120
    }
    TableViewColumn {
        role: 'country'
        title: "Country"
        width: 120
    }
    TableViewColumn {
        role: 'area'
        title: "Area"
        width: 80
    }
    TableViewColumn {
        role: 'population'
        title: "Population"
        width: 80
    }
}
```

Now the application should show you a menubar with a file menu and an empty table with 4 table headers. The next step will be to populate the table with useful data using our *FileIO* extension.



![image](./images/cityui_empty.png)

The `cities.json` document is an array of city entries. Here is an example.

```json
[
    {
        "area": "1928",
        "city": "Shanghai",
        "country": "China",
        "flag": "22px-Flag_of_the_People's_Republic_of_China.svg.png",
        "population": "13831900"
    },
    ...
]
```

Our job is it to allow the user to select the file, read it, convert it and set it onto the table view.

## Reading Data

For this we let the open action open the file dialog. When the user has selected a file the `onAccepted` method is called on the file dialog. There we call the `readDocument()` function. The `readDocument()` function sets the URL from the file dialog to our `FileIO` object and calls the `read()` method. The loaded text from `FileIO` is then parsed using the `JSON.parse()` method and the resulting object is directly set onto the table view as a model. How convenient is that?

```qml
Action {
    id: open
    ...
    onTriggered: {
        openDialog.open()
    }
}

...

FileDialog {
    id: openDialog
    onAccepted: {
        root.readDocument()
    }
}

function readDocument() {
    io.source = openDialog.fileUrl
    io.read()
    view.model = JSON.parse(io.text)
}


FileIO {
    id: io
}
```

## Writing Data

For saving the document, we hook up the “save” action to the `saveDocument()` function. The save document function takes the model from the view, which is a JS object and converts it into a string using the `JSON.stringify()` function. The resulting string is set to the text property of our `FileIO` object and we call `write()` to save the data to disk. The “null” and “4” parameters on the `stringify` function will format the resulting JSON data using indentation with 4 spaces. This is just for better reading of the saved document.

```qml
Action {
    id: save
    ...
    onTriggered: {
        saveDocument()
    }
}

function saveDocument() {
    var data = view.model
    io.text = JSON.stringify(data, null, 4)
    io.write()
}

FileIO {
    id: io
}
```

This is basically the application with reading, writing and displaying a JSON document. Think about all the time spend by writing XML readers and writers. With JSON all you need is a way to read and write a text file or send receive a text buffer.



![image](./images/cityui_table.png)

## Finishing Touch

The application is not fully ready yet. We still want to show the flags and allow the user to modify the document by removing cities from the model.

In this example, the flag files are stored relative to the `main.qml` document in a *flags* folder. To be able to show them the table column needs to define a custom delegate for rendering the flag image.

```qml
TableViewColumn {
    delegate: Item {
        Image {
            anchors.centerIn: parent
            source: 'flags/' + styleData.value
        }
    }
    role: 'flag'
    title: "Flag"
    width: 40
}
```

That is all that is needed to show the flag. It exposes the flag property from the JS model as `styleData.value` to the delegate. The delegate then adjusts the image path to pre-pend `'flags/'` and displays it as an `Image` element.

For removing we use a similar technique to display a remove button.

```qml
TableViewColumn {
    delegate: Button {
        iconSource: "remove.png"
        onClicked: {
            var data = view.model
            data.splice(styleData.row, 1)
            view.model = data
        }
    }
    width: 40
}
```

For the data removal operation, we get a hold on the view model and then remove one entry using the JS `splice` function. This method is available to us as the model is from the type JS array. The splice method changes the content of an array by removing existing elements and/or adding new elements.

A JS array is unfortunately not so smart as a Qt model like the `QAbstractItemModel`, which will notify the view about row changes or data changes. The view will not show any updated data by now as it is never notified of any changes. Only when we set the data back to the view, the view recognizes there is new data and refreshes the view content. Setting the model again using `view.model = data` is a way to let the view know there was a data change.

![image](./images/cityui_populated.png)

