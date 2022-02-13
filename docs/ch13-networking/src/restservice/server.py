#!/usr/bin/env python

# Copyright (c) 2012-2021, Juergen Bocklage Ryannel and Johan Thelin
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without 
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice, this
#    list of conditions and the following disclaimer.
#
# 2. Redistributions in binary form must reproduce the above copyright notice, 
#    this list of conditions and the following disclaimer in the documentation 
#    and/or other materials provided with the distribution.
#
# 3. Neither the name of the copyright holder nor the names of its contributors
#    may be used to endorse or promote products derived from this software 
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#region global
#region setup
from flask import Flask, jsonify, request
import json

with open('colors.json', 'r') as file:
    colors = json.load(file)

app = Flask(__name__)
#endregion setup

#region get-colors
@app.route('/colors', methods = ['GET'])
def get_colors():
    return jsonify({ "data" : colors })
#endregion get-colors

#region get-color
@app.route('/colors/<name>', methods = ['GET'])
def get_color(name):
    for color in colors:
        if color["name"] == name:
            return jsonify(color)
    return jsonify({ 'error' : True })
#endregion get-color

#region create-color
@app.route('/colors', methods= ['POST'])
def create_color():
    print('create color')
    color = {
        'name': request.json['name'],
        'value': request.json['value']
    }
    colors.append(color)
    return jsonify(color), 201
#endregion create-color

#region update-color
@app.route('/colors/<name>', methods= ['PUT'])
def update_color(name):
    for color in colors:
        if color["name"] == name:
            color['value'] = request.json.get('value', color['value'])
            return jsonify(color)
    return jsonify({ 'error' : True })
#endregion update-color

#region delete-color
@app.route('/colors/<name>', methods=['DELETE'])
def delete_color(name):
    for color in colors:
        if color["name"] == name:
            colors.remove(color)
            return jsonify(color)
    return jsonify({ 'error' : True })
#endregion delete-color

# region main
if __name__ == '__main__':
    app.run(debug = True)
# endregion main

#endregion global
