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
    height: 600

    Shape {
        anchors.centerIn: parent
        
        ShapePath {
        
            strokeWidth: 3
            strokeColor: "darkGray"
            fillColor: "lightGray"

            startX: -40; startY: 200
            
            // The circle
            
            PathArc { x: 40; y: 200; radiusX: 200; radiusY: 200; useLargeArc: true }
            PathLine { x: 40; y: 120 }
            PathArc { x: -40; y: 120; radiusX: 120; radiusY: 120; useLargeArc: true; direction: PathArc.Counterclockwise }
            PathLine { x: -40; y: 200 }

            // The dots
            
            PathMove { x: -20; y: 80 }
            PathArc { x: 20; y: 80; radiusX: 20; radiusY: 20; useLargeArc: true }
            PathArc { x: -20; y: 80; radiusX: 20; radiusY: 20; useLargeArc: true }

            PathMove { x: -20; y: 130 }
            PathArc { x: 20; y: 130; radiusX: 20; radiusY: 20; useLargeArc: true }
            PathArc { x: -20; y: 130; radiusX: 20; radiusY: 20; useLargeArc: true }

            PathMove { x: -20; y: 180 }
            PathArc { x: 20; y: 180; radiusX: 20; radiusY: 20; useLargeArc: true }
            PathArc { x: -20; y: 180; radiusX: 20; radiusY: 20; useLargeArc: true }

            PathMove { x: -20; y: 230 }
            PathArc { x: 20; y: 230; radiusX: 20; radiusY: 20; useLargeArc: true }
            PathArc { x: -20; y: 230; radiusX: 20; radiusY: 20; useLargeArc: true }            
        }
    }
}
// #endregion global
