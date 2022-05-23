# Local Storage - SQL

Qt Quick supports a local storage API known from the web browsers the local storage API. the API is available under “import QtQuick.LocalStorage 2.0”.

In general, it stores the content into an SQLite database in a system-specific location in a unique ID based file based on the given database name and version. It is not possible to list or delete existing databases. You can find the storage location from `QQmlEngine::offlineStoragePath()`.

You use the API by first creating a database object and then creating transactions on the database. Each transaction can contain one or more SQL queries. The transaction will roll-back when a SQL query will fail inside the transaction.

For example, to read from a simple notes table with a text column you could use the local storage like this:

<<< @/docs/ch14-storage/src/db-snippet/main.qml#global

## Crazy Rectangle

As an example assume we would like to store the position of a rectangle on our scene.

![image](./images/crazy_rect.png)

Here is the base of the example. It contains a rectangle called `crazy` that is draggable and shows its current `x` and `y` position as text.

<<< @/docs/ch14-storage/src/rectangle/main.qml#M1

You can drag the rectangle freely around. When you close the application and launch it again the rectangle is at the same position.

Now we would like to add that the x/y position of the rectangle is stored inside the SQL DB. For this, we need to add an `init`, `read` and `store` database function. These functions are called when on component completed and on component destruction.

```qml
import QtQuick
import QtQuick.LocalStorage 2.0

Item {
    // reference to the database object
    property var db

    function initDatabase() {
        // initialize the database object
    }

    function storeData() {
        // stores data to DB
    }

    function readData() {
        // reads and applies data from DB
    }

    Component.onCompleted: {
        initDatabase()
        readData()
    }

    Component.onDestruction: {
        storeData()
    }
}
```

You could also extract the DB code in an own JS library, which does all the logic. This would be the preferred way if the logic gets more complicated.

In the database initialization function, we create the DB object and ensure the SQL table is created. Notice that the database functions are quite talkative so that you can follow along on the console.

<<< @/docs/ch14-storage/src/rectangle/main.qml#M2

The application next calls the read function to read existing data back from the database. Here we need to differentiate if there is already data in the table. To check we look into how many rows the select clause has returned.

<<< @/docs/ch14-storage/src/rectangle/main.qml#M4

We expect the data is stored in a JSON string inside the value column. This is not typical SQL like, but works nicely with JS code. So instead of storing the x,y as properties in the table, we store them as a complete JS object using the JSON stringify/parse methods. In the end, we get a valid JS object with x and y properties, which we can apply on our crazy rectangle.

To store the data, we need to differentiate the update and insert cases. We use update when a record already exists and insert if no record under the name “crazy” exists.

<<< @/docs/ch14-storage/src/rectangle/main.qml#M3

Instead of selecting the whole recordset we could also use the SQLite count function like this: `SELECT COUNT(*) from data where name = "crazy"` which would return use one row with the number of rows affected by the select query. Otherwise, this is common SQL code. As an additional feature, we use the SQL value binding using the `?` in the query.

Now you can drag the rectangle and when you quit the application the database stores the x/y position and applies it on the next application run.

