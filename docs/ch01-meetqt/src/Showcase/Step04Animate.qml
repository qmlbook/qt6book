/*
 * Copyright (c) 2013, Juergen Bocklage-Ryannel, Johan Thelin
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of the editors nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

// animate.qml

import QtQuick

Item {
    id: root
    width: background.width
    height: background.height

    property int rotationStep: 45

    Image {
        id: background
        source: "images/background.png"
    }

    Image {
        id: pole
        x: (root.width - width)/2+2
        y: root.height - height
        source: "images/pole.png"
    }

    Image {
        id: pinwheel
        anchors.centerIn: parent
        source: "images/pinwheel.png"
        // visible: false
        Behavior on rotation {
            NumberAnimation { duration: 125 }
        }
    }

    Image {
        id: blur
        opacity: 0
        anchors.centerIn: parent
        source: "images/blur.png"
        // visible: false
        Behavior on rotation {
            NumberAnimation { duration: 125 }
        }
        Behavior on opacity {
            NumberAnimation { duration: 125 }
        }

    }

    // M1>>
    focus: true
    Keys.onLeftPressed: {
        blur.opacity = 1
        pinwheel.rotation -= root.rotationStep
        blur.rotation -= root.rotationStep
    }
    Keys.onRightPressed: {
        blur.opacity = 0.5
        pinwheel.rotation += root.rotationStep
        blur.rotation += root.rotationStep
    }
    Keys.onReleased: {
        blur.opacity = 0
    }
    // <<M1
}
