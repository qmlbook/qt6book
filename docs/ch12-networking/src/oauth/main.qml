import QtQuick
import QtQuick.Window
import QtQuick.Controls

import Spotify

ApplicationWindow {
    width: 320
    height: 568
    visible: true
    title: qsTr("Spotify OAuth2")

    SpotifyAPI {
        id: spotifyApi
        onIsAuthenticatedChanged: if(isAuthenticated) spotifyModel.update()
    }

    SpotifyModel {
        id: spotifyModel
        spotifyApi: spotifyApi
    }

    BusyIndicator {
        visible: !spotifyApi.isAuthenticated
        anchors.centerIn: parent
    }

    ListView {
        visible: spotifyApi.isAuthenticated
        width: parent.width
        height: parent.height
        model: spotifyModel
        delegate: Pane {
            topPadding: 0
            Column {
                width: 300
                spacing: 10

                Rectangle {
                    height: 1
                    width: parent.width
                    color: model.index > 0 ? "#3d3d3d" : "transparent"
                }

                Row {
                    spacing: 10

                    Item {
                        width: 20
                        height: width

                        Rectangle {
                            width: 20
                            height: 20
                            anchors.top: parent.top
                            anchors.right: parent.right
                            color: "black"

                            Label {
                                anchors.centerIn: parent
                                font.pointSize: 16
                                text: model.index + 1
                                color: "white"
                            }
                        }
                    }

                    Image {
                        width: 80
                        height: width
                        source: model.imageURL
                        fillMode: Image.PreserveAspectFit
                    }

                    Column {
                        Label { text: model.name; font.pointSize: 16; font.bold: true }
                        Label { text: "Followers: " + model.followersCount }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        spotifyApi.setCredentials("CLIENT_ID", "CLIENT_SECRET")
        spotifyApi.authorize()
    }
}
