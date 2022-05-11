# Web Sockets

The WebSockets module provides an implementation of the WebSockets protocol for WebSockets clients and servers. It mirrors the Qt CPP module. It allows sending a string and binary messages using a full duplex communication channel. A WebSocket is normally established by making an HTTP connection to the server and the server then “upgrades” the connection to a WebSocket connection.

In Qt/QML you can also simply use the WebSocket and WebSocketServer objects to creates direct WebSocket connection. The WebSocket protocol uses the “ws” URL schema or “wss” for a secure connection.

You can use the web socket qml module by importing it first.

```qml
import QtWebSockets

WebSocket {
    id: socket
}
```

## WS Server

You can easily create your own WS server using the C++ part of the Qt WebSocket or use a different WS implementation, which I find very interesting. It is interesting because it allows connecting the amazing rendering quality of QML with the great expanding web application servers. In this example, we will use a Node JS based web socket server using the [ws](https://npmjs.org/package/ws) module. For this, you first need to install [node js](http://nodejs.org/). Then, create a `ws_server` folder and install the ws package using the node package manager (npm).

The code shall create a simple echo server in NodeJS to echo our messages back to our QML client.

![image](./images/ws_client.png)

```sh
cd ws_server
npm install ws
```

The npm tool downloads and installs the ws package and dependencies into your local folder.

A `server.js` file will be our server implementation. The server code will create a web socket server on port 3000 and listens to an incoming connection. On an incoming connection, it will send out a greeting and waits for client messages. Each message a client sends on a socket will be sent back to the client.

<<< @/docs/ch13-networking/src/ws/ws_server/server.js#global

You need to get used to the notation of JavaScript and the function callbacks.

## WS Client

On the client side, we need a list view to display the messages and a TextInput for the user to enter a new chat message.

We will use a label with white color in the example.

<<< @/docs/ch13-networking/src/ws/ws_client/Label.qml#global

Our chat view is a list view, where the text is appended to a list model. Each entry is displayed using a row of prefix and message label. We use a cell width `cw` factor to split the with into 24 columns.

<<< @/docs/ch13-networking/src/ws/ws_client/ChatView.qml#global

The chat input is just a simple text input wrapped with a colored border.

<<< @/docs/ch13-networking/src/ws/ws_client/ChatInput.qml#global

When the web socket receives a message it appends the message to the chat view. Same applies for a status change. Also when the user enters a chat message a copy is appended to the chat view on the client side and the message is sent to the server.

<<< @/docs/ch13-networking/src/ws/ws_client/ws_client.qml#global

You need first run the server and then the client. There is no retry connection mechanism in our simple client.


Running the server

```sh
cd ws_server
node server.js
```

Running the client

```sh
cd ws_client
qml ws_client.qml
```

When entering text and pressing enter you should see something like this.



![image](./images/ws_client.png)

