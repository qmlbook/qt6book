/*
Copyright (c) 2012-2021, Juergen Bocklage Ryannel and Johan Thelin
All rights reserved.

Redistribution and use in source and binary forms, with or without 
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, 
   this list of conditions and the following disclaimer in the documentation 
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its contributors
   may be used to endorse or promote products derived from this software 
   without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

// #region global
// #region imports
import QtQuick
import QtQuick.Window
import QtQuick.Controls

import Spotify
// #endregion imports

// #region setup
ApplicationWindow {
    width: 320
    height: 568
    visible: true
    title: qsTr("Spotify OAuth2")

    BusyIndicator {
        visible: !spotifyApi.isAuthenticated
        anchors.centerIn: parent
    }

    SpotifyAPI {
        id: spotifyApi
        onIsAuthenticatedChanged: if(isAuthenticated) spotifyModel.update()
    }
// #endregion setup

    // #region model-view
    SpotifyModel {
        id: spotifyModel
        spotifyApi: spotifyApi
    }

    ListView {
        visible: spotifyApi.isAuthenticated
        width: parent.width
        height: parent.height
        model: spotifyModel
        delegate: Pane {
            id: delegate
            required property var model
            topPadding: 0
            Column {
                width: 300
                spacing: 10

                Rectangle {
                    height: 1
                    width: parent.width
                    color: delegate.model.index > 0 ? "#3d3d3d" : "transparent"
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
                                text: delegate.model.index + 1
                                color: "white"
                            }
                        }
                    }

                    Image {
                        width: 80
                        height: width
                        source: delegate.model.imageURL
                        fillMode: Image.PreserveAspectFit
                    }

                    Column {
                        Label { 
                            text: delegate.model.name
                            font.pointSize: 16
                            font.bold: true 
                        }
                        Label { text: "Followers: " + delegate.model.followersCount }
                    }
                }
            }
        }
    }
    // #endregion model-view

    // #region on-completed
    Component.onCompleted: {
        spotifyApi.setCredentials("CLIENT_ID", "CLIENT_SECRET")
        spotifyApi.authorize()
    }
    // #endregion on-completed
}
// #endregion global
