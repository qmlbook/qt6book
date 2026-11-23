# 便捷 API

针对矩形上的操作，提供了一套便捷 API，可以直接绘制，无需再调用 stroke 或 fill。

<<< @/docs/ch08-canvas/src/canvas/convenient.qml#M1

![图像](./assets/convenient.png)

::: tip
描边区域在路径两侧各延伸半个线宽。4 px 的 lineWidth 会在路径外侧绘制 2 px，内侧绘制 2 px。
:::

