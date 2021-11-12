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
    height: 200

// #region oddeven
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            fillColor: "orange"
            
            fillRule: ShapePath.OddEvenFill
            
            PathPolyline {
                path: [
                    Qt.point(100,  20),
                    Qt.point(150, 180),
                    Qt.point( 20,  75),
                    Qt.point(180,  75),
                    Qt.point( 50, 180),
                    Qt.point(100,  20),
                ]
            }
        }
    }
// #endregion oddeven

// #region winding
    Shape {
        ShapePath {
            strokeWidth: 3
            strokeColor: "darkgray"
            fillColor: "orange"
            
            fillRule: ShapePath.WindingFill
            
            PathPolyline {
                path: [
                    Qt.point(300,  20),
                    Qt.point(350, 180),
                    Qt.point(220,  75),
                    Qt.point(380,  75),
                    Qt.point(250, 180),
                    Qt.point(300,  20),
                ]
            }
        }
    }
// #endregion winding

    Text {
        x: 0
        y: 180
        width: 200
        
        text: "OddEvenFill"
        horizontalAlignment: Text.AlignHCenter
    }
    Text {
        x: 200
        y: 180
        width: 200
        
        text: "WindingFill"
        horizontalAlignment: Text.AlignHCenter
    }

    
}
// #endregion global
