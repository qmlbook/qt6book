# HTTP Requests

An HTTP request is in Qt typically done using `QNetworkRequest` and `QNetworkReply` from the c++ site and then the response would be pushed using the Qt/C++ integration into the QML space. So we try to push the envelope here a little bit to use the current tools Qt Quick gives us to communicate with a network endpoint. For this, we use a helper object to make an HTTP request, response cycle. It comes in the form of the javascript `XMLHttpRequest` object.

The `XMLHttpRequest` object allows the user to register a response handler function and a URL. A request can be sent using one of the HTTP verbs (get, post, put, delete, …) to make the request. When the response arrives the handler function is called. The handler function is called several times. Every-time the request state has changed (for example headers have arrived or request is done).

Here a short example:

```js
function request() {
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (xhr.readyState === XMLHttpRequest.HEADERS_RECEIVED) {
            print('HEADERS_RECEIVED');
        } else if(xhr.readyState === XMLHttpRequest.DONE) {
            print('DONE');
        }
    }
    xhr.open("GET", "http://example.com");
    xhr.send();
}
```

For a response, you can get the XML format or just the raw text. It is possible to iterate over the resulting XML but more commonly used is the raw text nowadays for a JSON formatted response. The JSON document will be used to convert text to a JS object using `JSON.parse(text)`.

```js
/* ... */
} else if(xhr.readyState === XMLHttpRequest.DONE) {
    var object = JSON.parse(xhr.responseText.toString());
    print(JSON.stringify(object, null, 2));
}
```

In the response handler, we access the raw response text and convert it into a javascript object. This JSON object is now a valid JS object (in javascript an object can be an object or an array).

::: tip
It seems the `toString()` conversion first makes the code more stable. Without the explicit conversion, I had several times parser errors. Not sure what the cause it.
:::

## Flickr Calls

Let us have a look on a more real-world example. A typical example is to use the Flickr service to retrieve a public feed of the newly uploaded pictures. For this, we can use the `http://api.flickr.com/services/feeds/photos_public.gne` URL. Unfortunately, it returns by default an XML stream, which could be easily parsed by the `XmlListModel` in qml. For the sake of the example, we would like to concentrate on JSON data. To become a clean JSON response we need to attach some parameters to the request: `http://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1`. This will return a JSON response without the JSON callback.

::: tip
A JSON callback wraps the JSON response into a function call. This is a shortcut used on HTML programming where a script tag is used to make a JSON request. The response will trigger a local function defined by the callback. There is no mechanism which works with JSON callbacks in QML.
:::

Let us first examine the response by using curl:

```sh
curl "http://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=munich"
```

The response will be something like this:

```json
{
    "title": "Recent Uploads tagged munich",
    ...
    "items": [
        {
        "title": "Candle lit dinner in Munich",
        "media": {"m":"http://farm8.staticflickr.com/7313/11444882743_2f5f87169f_m.jpg"},
        ...
        },{
        "title": "Munich after sunset: a train full of \"must haves\" =",
        "media": {"m":"http://farm8.staticflickr.com/7394/11443414206_a462c80e83_m.jpg"},
        ...
        }
    ]
    ...
}
```

The returned JSON document has a defined structure. An object which has a title and an items property. Where the title is a string and items is an array of objects. When converting this text into a JSON document you can access the individual entries, as it is a valid JS object/array structure.

```js
// JS code
obj = JSON.parse(response);
print(obj.title) // => "Recent Uploads tagged munich"
for(var i=0; i<obj.items.length; i++) {
    // iterate of the items array entries
    print(obj.items[i].title) // title of picture
    print(obj.items[i].media.m) // url of thumbnail
}
```

As a valid JS array, we can use the `obj.items` array also as a model for a list view. We will try to accomplish this now. First, we need to retrieve the response and convert it into a valid JS object. And then we can just set the `response.items` property as a model to a list view.

<<< @/docs/ch13-networking/src/httprequest/httprequest.qml#request

Here is the full source code, where we create the request when the component is loaded. The request response is then used as the model for our simple list view.

<<< @/docs/ch13-networking/src/httprequest/httprequest.qml#global

When the document is fully loaded ( `Component.onCompleted` ) we request the latest feed content from Flickr. On arrival, we parse the JSON response and set the `items` array as the model for our view. The list view has a delegate, which displays the thumbnail icon and the title text in a row.

The other option would be to have a placeholder `ListModel` and append each item onto the list model. To support larger models it is required to support pagination (e.g. page 1 of 10) and lazy content retrieval.
