/*
Copyright (c) 2021-2021, Juergen Bocklage Ryannel and Johan Thelin
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
import QtQuick
import QtQuick.Shapes

Rectangle {
    id: root
    width: 600
    height: 400

// #region line
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            startX: 20; startY: 70

            PathLine {
                x: 180
                y: 130
            }
        }
    }
// #endregion line

// #region polyline
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            PathPolyline {
                path: [
                    Qt.point(220, 100),
                    Qt.point(260, 20),
                    Qt.point(300, 170),
                    Qt.point(340, 60),
                    Qt.point(380, 100)
                ]
            }
        }
    }
// #endregion polyline

// #region arc
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            startX: 420; startY: 100

            PathArc {
                x: 580; y: 180
                radiusX: 120; radiusY: 120
            }
        }
    }
// #endregion arc
    
// #region quad
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            startX: 20; startY: 300

            PathQuad {
                x: 180; y: 300
                controlX: 60; controlY: 250
            }
        }
    }
// #endregion quad

// #region cubic
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            startX: 220; startY: 300

            PathCubic {
                x: 380; y: 300
                control1X: 260; control1Y: 250
                control2X: 360; control2Y: 350
            }
        }
    }
// #endregion cubic

// #region curve
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            startX: 420; startY: 300

            PathCurve { x: 460; y: 220 }
            PathCurve { x: 500; y: 370 }
            PathCurve { x: 540; y: 270 }
            PathCurve { x: 580; y: 300 }
        }
    }
// #endregion curve

    Marker { x: 20; y: 70 }
    Marker { x: 180; y: 130 }

    Marker { x: 220; y: 100 }
    Marker { x: 260; y: 20 }
    Marker { x: 300; y: 170 }
    Marker { x: 340; y: 60 }
    Marker { x: 380; y: 100 }

    Marker { x: 420; y: 100 }
    Marker { x: 580; y: 180 }

    Marker { x: 20; y: 300 }
    Marker { x: 180; y: 300 }
    Marker { x: 60; y: 250 }

    Marker { x: 220; y: 300 }
    Marker { x: 380; y: 300 }
    Marker { x: 260; y: 250 }
    Marker { x: 360; y: 350 }

    Marker { x: 420; y: 300 }
    Marker { x: 460; y: 220 }
    Marker { x: 500; y: 370 }
    Marker { x: 540; y: 270 }
    Marker { x: 560; y: 300 }

    Text {
        x: 0
        y: 180
        width: 200
        
        text: "PathLine"
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        x: 200
        y: 180
        width: 200
        
        text: "PathPolyline"
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        x: 400
        y: 180
        width: 200
        
        text: "PathArc"
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        x: 0
        y: 380
        width: 200
        
        text: "PathQuad"
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        x: 200
        y: 380
        width: 200
        
        text: "PathCubic"
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        x: 400
        y: 380
        width: 200
        
        text: "PathCurve"
        horizontalAlignment: Text.AlignHCenter
    }

    
}
// #endregion global
