# REST API

To use a web-service, we first need to create one. We will use Flask ([https://flask.palletsprojects.com](https://flask.palletsprojects.com)) a simple HTTP app server based on python to create a simple color web-service. You could also use every other web server which accepts and returns JSON data. The idea is to have a list of named colors, which can be managed via the web-service. Managed in this case means CRUD (create-read-update-delete).

A simple web-service in Flask can be written in one file. We start with an empty `server.py` file. Inside this file, we create some boiler-code and load our initial colors from an external JSON file. See also the Flask [quickstart](https://flask.palletsprojects.com/en/2.0.x/quickstart/) documentation.

<<< @/docs/ch13-networking/src/restservice/server.py#setup
```python
# Services registration & implementation...
```
<<< @/docs/ch13-networking/src/restservice/server.py#main

When you run this script, it will provide a web-server at [http://localhost:5000](http://localhost:5000), which does not serve anything useful yet.

We will now start adding our CRUD (Create,Read,Update,Delete) endpoints to our little web-service.

## Read Request

To read data from our web-server, we will provide a GET method for all colors.

<<< @/docs/ch13-networking/src/restservice/server.py#get-colors

This will return the colors under the ‘/colors’ endpoint. To test this we can use curl to create an HTTP request.

```sh
curl -i -GET http://localhost:5000/colors
```

Which will return us the list of colors as JSON data.

## Read Entry

To read an individual color by name we provide the details endpoint, which is located under `/colors/<name>`. The name is a parameter to the endpoint, which identifies an individual color.

<<< @/docs/ch13-networking/src/restservice/server.py#get-color

And we can test it with using curl again. For example to get the red color entry.

```sh
curl -i -GET http://localhost:5000/colors/red
```

It will return one color entry as JSON data.

## Create Entry

Till now we have just used HTTP GET methods. To create an entry on the server side, we will use a POST method and pass the new color information with the POST data. The endpoint location is the same as to get all colors. But this time we expect a POST request.

<<< @/docs/ch13-networking/src/restservice/server.py#create-color

Curl is flexible enough to allow us to provide JSON data as the new entry inside the POST request.

```sh
curl -i -H "Content-Type: application/json" -X POST -d '{"name":"gray1","value":"#333"}' http://localhost:5000/colors
```

## Update Entry

To update an individual entry we use the PUT HTTP method. The endpoint is the same as to retrieve an individual color entry. When the color was updated successfully we return the updated color as JSON data.

<<< @/docs/ch13-networking/src/restservice/server.py#update-color

In the curl request, we only provide the values to be updated as JSON data and then a named endpoint to identify the color to be updated.

```sh
curl -i -H "Content-Type: application/json" -X PUT -d '{"value":"#666"}' http://localhost:5000/colors/red
```


## Delete Entry

Deleting an entry is done using the DELETE HTTP verb. It also uses the same endpoint for an individual color, but this time the DELETE HTTP verb.

<<< @/docs/ch13-networking/src/restservice/server.py#delete-color

This request looks similar to the GET request for an individual color.

```sh
curl -i -X DELETE http://localhost:5000/colors/red
```

## HTTP Verbs

Now we can read all colors, read a specific color, create a new color, update a color and delete a color. Also, we know the HTTP endpoints to our API.

```sh
# Read All
GET    http://localhost:5000/colors
# Create Entry
POST   http://localhost:5000/colors
# Read Entry
GET    http://localhost:5000/colors/${name}
# Update Entry
PUT    http://localhost:5000/colors/${name}
# Delete Entry
DELETE http://localhost:5000/colors/${name}
```

Our little REST server is complete now and we can focus on QML and the client side. To create an easy to use API we need to map each action to an individual HTTP request and provide a simple API to our users.

## Client REST

To demonstrate a REST client we write a small color grid. The color grid displays the colors retrieved from the web-service via HTTP requests. Our user interface provides the following commands:

* Get a color list
* Create color
* Read the last color
* Update last color
* Delete the last color

We bundle our API into an own JS file called `colorservice.js` and import it into our UI as `Service`. Inside the service module (`colorservice.js`), we create a helper function to make the HTTP requests for us:

<<< @/docs/ch13-networking/src/rest/colorservice.js#request

It takes four arguments. The `verb`, which defines the HTTP verb to be used (GET, POST, PUT, DELETE). The second parameter is the endpoint to be used as a postfix to the BASE address (e.g. ‘[http://localhost:5000/colors](http://localhost:5000/colors)’). The third parameter is the optional obj, to be sent as JSON data to the service. The last parameter defines a callback to be called when the response returns. The callback receives a response object with the response data. Before we send the request, we indicate that we send and accept JSON data by modifying the request header.

Using this request helper function we can implement the simple commands we defined earlier (create, read, update, delete). This code resides in the service implementation:

<<< @/docs/ch13-networking/src/rest/colorservice.js#services

In the UI we use the service to implement our commands. We have a `ListModel` with the id `gridModel` as a data provider for the `GridView`. The commands are indicated using a `Button` UI element.

Importing our service library is pretty straightforward:

<<< @/docs/ch13-networking/src/rest/rest.qml#import

Reading the color list from the server:

<<< @/docs/ch13-networking/src/rest/rest.qml#read-colors

Create a new color entry on the server:

<<< @/docs/ch13-networking/src/rest/rest.qml#create-color

Reading a color based on its name:

<<< @/docs/ch13-networking/src/rest/rest.qml#read-color

Update a color entry on the server based on the color name:

<<< @/docs/ch13-networking/src/rest/rest.qml#update-color

Delete a color by the color name:

<<< @/docs/ch13-networking/src/rest/rest.qml#delete-color

This concludes the CRUD (create, read, update, delete) operations using a REST API. There are also other possibilities to generate a Web-Service API. One could be module based and each module would have one endpoint. And the API could be defined using JSON RPC ([http://www.jsonrpc.org/](http://www.jsonrpc.org/)). Sure also XML based API is possible, but the JSON approach has great advantages as the parsing is built into the QML/JS as part of JavaScript.



