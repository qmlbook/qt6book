# Multimedia

The multimedia elements in the Qt Multimedia makes it possible to playback and record media such as sound, video or pictures. Decoding and encoding are handled through platform-specific backends. For instance, the popular GStreamer framework is used on Linux, WMF is used on Windows, AVFramework on OS X and iOS and the Android multimedia APIs are used on Android.

The multimedia elements are not a part of the Qt Quick core API. Instead, they are provided through a separate API made available by importing Qt Multimedia as shown below:

```qml
import QtMultimedia
```

