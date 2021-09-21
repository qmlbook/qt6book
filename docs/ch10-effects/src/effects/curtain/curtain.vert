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

// #region M1
#version 440

layout(location=0) in vec4 qt_Vertex;
layout(location=1) in vec2 qt_MultiTexCoord0;

layout(location=0) out vec2 qt_TexCoord0;
layout(location=1) out float shade;

layout(std140, binding=0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    
    float topWidth;
    float bottomWidth;
    float width;
    float height;
    float amplitude;
} ubuf;

out gl_PerVertex { 
    vec4 gl_Position;
};
 
void main() {
    qt_TexCoord0 = qt_MultiTexCoord0;

    vec4 shift = vec4(0.0, 0.0, 0.0, 0.0);
    float swing = (ubuf.topWidth - ubuf.bottomWidth) * (qt_Vertex.y / ubuf.height);
    shift.x = qt_Vertex.x * (ubuf.width - ubuf.topWidth + swing) / ubuf.width;

    shade = sin(21.9911486 * qt_Vertex.x / ubuf.width);
    shift.y = ubuf.amplitude * (ubuf.width - ubuf.topWidth + swing) * shade;

    gl_Position = ubuf.qt_Matrix * (qt_Vertex - shift);

    shade = 0.2 * (2.0 - shade) * ((ubuf.width - ubuf.topWidth + swing) / ubuf.width);
}
// #endregion M1
