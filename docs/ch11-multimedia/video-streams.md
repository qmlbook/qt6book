# Video Streams

The `VideoOutput` element is not limited to be used in combination with a `MediaPlayer` element. It can also be used with various video sources to display video streams. 

For instance, we can use the `VideoOutput` to display the live video stream of the user's `Camera`. To do so, we will combine it with two components: `Camera` and `CaptureSession`.

<<< @/docs/ch11-multimedia/src/camera-capture/basic.qml#global

The `CaptureSession` component provides a simple way to read a camera stream, capture still images or record videos.

As the `MediaPlayer` component, the `CaptureSession` element provides a `videoOuput` attribute. We can thus use this attribute to configure our own visual component.

Finally, when the application is loaded, we can start the camera recording:

```qml
Component.onCompleted: captureSession.camera.start()
```

::: tip
Depending on your operating system, this application may require sensitive access permission(s). If you run this sample application using the `qml` binary, those permissions will be requested automatically.

However, if you run it as an independant program you may need to request those permissions first (e.g.: under MacOS, you would need a dedicated .plist file bundled with your application).
:::
