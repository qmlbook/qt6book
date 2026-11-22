# 像素缓冲区

使用画布时，你可以从画布检索像素数据，以读取或修改画布的像素。要读取图像数据，请使用 `createImageData(sw,sh)` 或 `getImageData(sx,sy,sw,sh)`。这两个函数都返回一个 `ImageData` 对象，带有 `width`、`height` 和 `data` 变量。data 变量包含一个一维数组，是按 *RGBA* 格式检索到的像素数据，其中每个值的取值范围是 0 到 255。要在画布上设置像素，可以使用 `putImageData(imagedata, dx, dy)` 函数。

检索画布内容的另一种方式是把数据保存到图像中。这可以通过 `Canvas` 的函数 `save(path)` 或 `toDataURL(mimeType)` 实现，后者返回一个图像 URL，可供 `Image` 元素加载。

<<< @/docs/ch08-canvas/src/canvas/imagedata.qml#M1

在这个小示例中，我们每秒在左侧画布上绘制一个小圆。当用户点击鼠标区域时，画布内容被存储，并检索到一个图像 URL。随后在示例的右侧显示该图像。

