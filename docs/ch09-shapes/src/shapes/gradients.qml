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
    width: 400
    height: 400

// #region solid
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            fillColor: "lightgreen"
            
            startX: 20; startY: 140

            PathLine {
                x: 180
                y: 140
            }
            PathArc {
                x: 20
                y: 140
                radiusX: 80
                radiusY: 80
                direction: PathArc.Counterclockwise
                useLargeArc: true
            }
        }
    }
// #endregion solid

// #region conical
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            fillGradient: ConicalGradient {
                centerX: 300; centerY: 100
                angle: 45
                
                GradientStop { position: 0.0; color: "lightgreen" }
                GradientStop { position: 0.7; color: "yellow" }
                GradientStop { position: 1.0; color: "darkgreen" }
            }
            
            startX: 220; startY: 140

            PathLine {
                x: 380
                y: 140
            }
            PathArc {
                x: 220
                y: 140
                radiusX: 80
                radiusY: 80
                direction: PathArc.Counterclockwise
                useLargeArc: true
            }
        }
    }
// #endregion conical

// #region linear
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            fillGradient: LinearGradient {
                x1: 50; y1: 300
                x2: 150; y2: 280
                
                GradientStop { position: 0.0; color: "lightgreen" }
                GradientStop { position: 0.7; color: "yellow" }
                GradientStop { position: 1.0; color: "darkgreen" }
            }

            startX: 20; startY: 340

            PathLine {
                x: 180
                y: 340
            }
            PathArc {
                x: 20
                y: 340
                radiusX: 80
                radiusY: 80
                direction: PathArc.Counterclockwise
                useLargeArc: true
            }
        }
    }
// #endregion linear

// #region radial
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            
            fillGradient: RadialGradient {
                centerX: 300; centerY: 250; centerRadius: 120
                focalX: 300; focalY: 220; focalRadius: 10
                
                GradientStop { position: 0.0; color: "lightgreen" }
                GradientStop { position: 0.7; color: "yellow" }
                GradientStop { position: 1.0; color: "darkgreen" }
            }

            startX: 220; startY: 340

            PathLine {
                x: 380
                y: 340
            }
            PathArc {
                x: 220
                y: 340
                radiusX: 80
                radiusY: 80
                direction: PathArc.Counterclockwise
                useLargeArc: true
            }
        }
    }
// #endregion radial

    Text {
        x: 0
        y: 150
        width: 200
        
        text: "Solid Colour"
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        x: 200
        y: 150
        width: 200
        
        text: "ConicalGradient"
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        x: 0
        y: 350
        width: 200
        
        text: "LinearGradient"
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        x: 200
        y: 350
        width: 200
        
        text: "RadialGradient"
        horizontalAlignment: Text.AlignHCenter
    }

    
}
// #endregion global
