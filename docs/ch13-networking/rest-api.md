# REST API

要使用 Web 服务，我们首先需要创建一个。我们将使用 Flask（[https://flask.palletsprojects.com](https://flask.palletsprojects.com)）——一个基于 Python 的简单 HTTP 应用服务器——来创建一个简单的颜色 Web 服务。你也可以使用任何其他能接收和返回 JSON 数据的 Web 服务器。思路是维护一组命名颜色，通过 Web 服务来管理它们。这里的管理是指 CRUD（创建-读取-更新-删除）。

用 Flask 写一个简单的 Web 服务只需一个文件。我们从一个空的 `server.py` 文件开始。在这个文件里创建一些样板代码，并从一个外部 JSON 文件加载初始颜色。另见 Flask 的[快速入门](https://flask.palletsprojects.com/en/2.0.x/quickstart/)文档。

<<< @/docs/ch13-networking/src/restservice/server.py#setup
```python
# Services registration & implementation...
```
<<< @/docs/ch13-networking/src/restservice/server.py#main

运行这个脚本后，它会在 [http://localhost:5000](http://localhost:5000) 提供一个 Web 服务器，不过暂时还提供不了什么有用的内容。

现在开始给我们的小 Web 服务添加 CRUD（Create,Read,Update,Delete）端点。

## 读取请求

要从 Web 服务器读取数据，我们为所有颜色提供一个 GET 方法。

<<< @/docs/ch13-networking/src/restservice/server.py#get-colors

这会在 ‘/colors’ 端点下返回颜色。要测试它，可以用 curl 创建一个 HTTP 请求。

```sh
curl -i -GET http://localhost:5000/colors
```

它会把颜色列表以 JSON 数据的形式返回给我们。

## 读取条目

要按名称读取单个颜色，我们提供一个详情端点，位于 `/colors/<name>`。名称是端点的一个参数，用来标识某个具体颜色。

<<< @/docs/ch13-networking/src/restservice/server.py#get-color

同样可以用 curl 测试。例如获取红色条目：

```sh
curl -i -GET http://localhost:5000/colors/red
```

它会把一个颜色条目以 JSON 数据的形式返回。

## 创建条目

到目前为止我们只用过 HTTP GET 方法。要在服务器端创建一个条目，我们将使用 POST 方法，并通过 POST 数据传入新的颜色信息。端点位置与获取全部颜色的相同，不过这次期望的是 POST 请求。

<<< @/docs/ch13-networking/src/restservice/server.py#create-color

curl 足够灵活，可以让我们在 POST 请求中以 JSON 数据的形式提供新条目。

```sh
curl -i -H "Content-Type: application/json" -X POST -d '{"name":"gray1","value":"#333"}' http://localhost:5000/colors
```

## 更新条目

要更新单个条目，我们使用 PUT HTTP 方法。端点与获取单个颜色条目的相同。颜色更新成功后，我们把更新后的颜色以 JSON 数据返回。

<<< @/docs/ch13-networking/src/restservice/server.py#update-color

在 curl 请求中，只提供要更新的值（JSON 数据），再加上一个具名端点来标识要更新的颜色。

```sh
curl -i -H "Content-Type: application/json" -X PUT -d '{"value":"#666"}' http://localhost:5000/colors/red
```


## 删除条目

删除条目使用 DELETE HTTP 方法。它同样使用单个颜色的端点，只是这次用的是 DELETE 方法。

<<< @/docs/ch13-networking/src/restservice/server.py#delete-color

这个请求看上去与获取单个颜色的 GET 请求相似。

```sh
curl -i -X DELETE http://localhost:5000/colors/red
```

## HTTP 方法

现在我们可以读取所有颜色、读取特定颜色、创建新颜色、更新颜色以及删除颜色了。我们也知道了 API 的各个 HTTP 端点。

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

我们的小型 REST 服务器至此就完成了，接下来可以把注意力放在 QML 和客户端一侧。要创建一个易用的 API，需要把每个操作映射到一个单独的 HTTP 请求，并为用户提供简单的 API。

## 客户端 REST

为了演示 REST 客户端，我们编写一个颜色网格。这个颜色网格显示通过 HTTP 请求从 Web 服务获取的颜色。用户界面提供如下命令：

* 获取颜色列表
* 创建颜色
* 读取最后一个颜色
* 更新最后一个颜色
* 删除最后一个颜色

我们把 API 打包进一个名为 `colorservice.js` 的独立 JS 文件，并在界面中以 `Service` 为名导入。在服务模块（`colorservice.js`）中，创建一个辅助函数来替我们发出 HTTP 请求：

<<< @/docs/ch13-networking/src/rest/colorservice.js#request

它接受四个参数。`verb` 定义要使用的 HTTP 方法（GET、POST、PUT、DELETE）。第二个参数是要拼接到 BASE 地址之后的端点（例如 ‘[http://localhost:5000/colors](http://localhost:5000/colors)’）。第三个参数是可选的 obj，会以 JSON 数据的形式发送给服务。最后一个参数定义响应回来时要调用的回调（callback），回调接收一个包含响应数据的响应对象。在发送请求之前，我们通过修改请求头来标明发送和接收的都是 JSON 数据。

借助这个请求辅助函数，就可以实现前面定义的那些简单命令（创建、读取、更新、删除）。这些代码位于服务实现中：

<<< @/docs/ch13-networking/src/rest/colorservice.js#services

在界面中，我们用服务来实现这些命令。我们有一个 id 为 `gridModel` 的 `ListModel`，作为 `GridView` 的数据提供者。命令通过 `Button` 界面元素来触发。

导入我们的服务库非常简单：

<<< @/docs/ch13-networking/src/rest/rest.qml#import

从服务器读取颜色列表：

<<< @/docs/ch13-networking/src/rest/rest.qml#read-colors

在服务器上创建新的颜色条目：

<<< @/docs/ch13-networking/src/rest/rest.qml#create-color

按名称读取颜色：

<<< @/docs/ch13-networking/src/rest/rest.qml#read-color

根据颜色名更新服务器上的颜色条目：

<<< @/docs/ch13-networking/src/rest/rest.qml#update-color

按颜色名删除颜色：

<<< @/docs/ch13-networking/src/rest/rest.qml#delete-color

以上就是使用 REST API 的 CRUD（创建、读取、更新、删除）操作。生成 Web 服务 API 还有其他方式。可以基于模块，每个模块一个端点；API 也可以用 JSON RPC（[http://www.jsonrpc.org/](http://www.jsonrpc.org/)）定义。基于 XML 的 API 当然也可以，但 JSON 方式有很大优势，因为解析已作为 JavaScript 的一部分内建在 QML/JS 中。
