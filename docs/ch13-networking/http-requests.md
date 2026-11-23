# HTTP 请求

在 Qt 中，HTTP 请求通常在 C++ 一侧用 `QNetworkRequest` 和 `QNetworkReply` 完成，然后通过 Qt/C++ 集成把响应推送到 QML 的空间。这里我们尝试再往前推进一步，用 Qt Quick 现有的工具与网络端点（endpoint）通信。为此，我们使用一个辅助对象来完成一次 HTTP 请求-响应循环。它以 JavaScript 的 `XMLHttpRequest` 对象的形式出现。

`XMLHttpRequest` 对象允许用户注册一个响应处理函数和一个 URL。可以用某个 HTTP 方法（get、post、put、delete……）发送请求。响应到达时会调用处理函数。处理函数会被调用多次：每当请求状态发生变化时（例如响应头已到达，或请求已完成），都会调用一次。

下面是一个简短示例：

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

对于响应，可以获取 XML 格式，也可以只取原始文本。可以遍历返回的 XML，但如今更常见的是取原始文本，用于 JSON 格式的响应。JSON 文档会用 `JSON.parse(text)` 把文本转换为 JS 对象。

```js
/* ... */
} else if(xhr.readyState === XMLHttpRequest.DONE) {
    var object = JSON.parse(xhr.responseText.toString());
    print(JSON.stringify(object, null, 2));
}
```

在响应处理函数中，我们访问原始响应文本并把它转换成 JavaScript 对象。这个 JSON 对象现在是一个有效的 JS 对象（在 JavaScript 中，对象可以是对象，也可以是数组）。

::: tip
看来先做 `toString()` 转换会让代码更稳定。不做显式转换时，我遇到过多次解析器错误。不确定原因是什么。
:::

## Flickr 调用

来看一个更接近真实世界的例子。一个典型例子是使用 Flickr 服务获取最新上传图片的公共订阅源（feed）。为此，可以使用 `http://api.flickr.com/services/feeds/photos_public.gne` 这个 URL。可惜它默认返回 XML 流，虽然用 QML 中的 `XmlListModel` 可以轻松解析。为了示例起见，我们想专注于 JSON 数据。要得到干净的 JSON 响应，需要给请求附加一些参数：`http://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1`。这会返回不带 JSON 回调的 JSON 响应。

::: tip
JSON 回调（callback）会把 JSON 响应包装进一次函数调用。这是 HTML 编程中的一种捷径，用 script 标签发起 JSON 请求。响应会触发由回调定义的本地函数。QML 中没有能与 JSON 回调配合使用的机制。
:::

先用 curl 检查一下响应：

```sh
curl "http://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags=munich"
```

响应大致如下：

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

返回的 JSON 文档有确定的结构：一个带有 title 和 items 属性的对象。其中 title 是字符串，items 是对象数组。把这段文本转换成 JSON 文档后，就可以访问各个条目，因为它是一个有效的 JS 对象/数组结构。

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

作为有效的 JS 数组，`obj.items` 数组也可以用作列表视图的模型。我们现在就来实现这一点。首先需要获取响应并把它转换为有效的 JS 对象，然后把 `response.items` 属性设置为列表视图的模型。

<<< @/docs/ch13-networking/src/httprequest/httprequest.qml#request

下面是完整源代码，在组件加载时创建请求。请求响应用作我们简单列表视图的模型。

<<< @/docs/ch13-networking/src/httprequest/httprequest.qml#global

文档完全加载后（`Component.onCompleted`），我们向 Flickr 请求最新的订阅源内容。内容到达后，解析 JSON 响应，并把 `items` 数组设置为视图的模型。列表视图有一个委托，在一行中显示缩略图图标和标题文本。

另一种做法是使用占位的 `ListModel`，把每个条目追加到列表模型上。要支持更大的模型，就需要支持分页（例如第 1 页，共 10 页）以及惰性内容获取。
