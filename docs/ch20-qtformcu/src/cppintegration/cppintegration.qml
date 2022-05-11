/*
Copyright (c) 2021, Johan Thelin
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

import QtQuick

Rectangle {
    width: 480
    height: 272

// #region left
    Column {
        x: 10
        y: 10
        spacing: 5
        PlainButton {
            text: "+"
            onClicked: Counter.increase()
        }
        PlainButton {
            text: "reset"
            onClicked: Counter.reset()
        }
        PlainButton {
            text: "-"
            onClicked: Counter.decrease()
        }
    }
// #endregion left

// #region right
    Column {
        x: 350
        y: 10
        spacing: 5
        PlainButton {
            color: "orange"
            text: "++"
            onClicked: Counter.value += 5;
        }
        PlainButton {
            color: "orange"
            text: "100"
            onClicked: Counter.value = 100;
        }
        PlainButton {
            color: "orange"
            text: "--"
            onClicked: Counter.value -= 5;
        }
    }
// #endregion right

    Text {
        anchors.centerIn: parent
        text: Counter.value;
    }
}
