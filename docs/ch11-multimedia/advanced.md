# Advanced Techniques

## Using a Playlist

To play media items from a playlist instead of individual items, assign a `Playlist` instance to the `playlist` property of your `MediaPlayer`. The `Playlist` element will then take care of setting the `source` of the `MediaPlayer`, while the play state is controlled via the player.

```qml
MediaPlayer {
    id: player
    playlist: Playlist {
        PlaylistItem { source: "trailer_400p.ogg" }
        PlaylistItem { source: "trailer_400p.ogg" }
        PlaylistItem { source: "trailer_400p.ogg" }
    }
}
```

To make the player start playing, simply set the playlist `currentIndex` and tell the `MediaPlayer` to start playing.

```qml
Component.onCompleted: {
    player.playlist.currentIndex = 0;
    player.play();
}
```
