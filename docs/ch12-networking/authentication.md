# Authentication using OAuth

OAuth is an open protocol to allow secure authorization in a simple and standard method from web, mobile, and desktop applications. OAuth is used to authenticate a client against common web-services such as Google, Facebook, and Twitter.

::: tip
For a custom web-service you could also use the standard HTTP authentication for example by using the `XMLHttpRequest` username and password in the get method (e.g. `xhr.open(verb, url, true, username, password)`)
:::

OAuth is currently not part of a QML/JS API. So you would need to write some C++ code and export the authentication to QML/JS. Another issue would be the secure storage of the access token.

Here are some links which we find useful:


* [http://oauth.net/](http://oauth.net/)


* [http://hueniverse.com/oauth/](http://hueniverse.com/oauth/)


* [https://github.com/pipacs/o2](https://github.com/pipacs/o2)


* [http://www.johanpaul.com/blog/2011/05/oauth2-explained-with-qt-quick/](http://www.johanpaul.com/blog/2011/05/oauth2-explained-with-qt-quick/)

