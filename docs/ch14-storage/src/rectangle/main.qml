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
import QtQuick
import QtQuick.LocalStorage 2.0

// #region M1
Item {
    width: 400
    height: 400

    Rectangle {
        id: crazy
        objectName: 'crazy'
        width: 100
        height: 100
        x: 50
        y: 50
        color: "#53d769"
        border.color: Qt.lighter(color, 1.1)
        Text {
            anchors.centerIn: parent
            text: Math.round(parent.x) + '/' + Math.round(parent.y)
        }
        MouseArea {
            anchors.fill: parent
            drag.target: parent
        }
    }
    // ...
// #endregion M1

    // reference to the database object
    property var db

// #region M2
    function initDatabase() {
        // initialize the database object
        print('initDatabase()')
        db = LocalStorage.openDatabaseSync("CrazyBox", "1.0", "A box who remembers its position", 100000)
        db.transaction( function(tx) {
            print('... create table')
            tx.executeSql('CREATE TABLE IF NOT EXISTS data(name TEXT, value TEXT)')
        })
    }
// #endregion M2

// #region M3
    function storeData() {
        // stores data to DB
        print('storeData()')
        if(!db) { return }
        db.transaction(function(tx) {
            print('... check if a crazy object exists')
            var result = tx.executeSql('SELECT * from data where name = "crazy"')
            // prepare object to be stored as JSON
            var obj = { x: crazy.x, y: crazy.y }
            if(result.rows.length === 1) { // use update
                print('... crazy exists, update it')
                result = tx.executeSql('UPDATE data set value=? where name="crazy"', [JSON.stringify(obj)])
            } else { // use insert
                print('... crazy does not exists, create it')
                result = tx.executeSql('INSERT INTO data VALUES (?,?)', ['crazy', JSON.stringify(obj)])
            }
        })
    }
// #endregion M3

// #region M4
    function readData() {
        // reads and applies data from DB
        print('readData()')
        if(!db) { return }
        db.transaction(function(tx) {
            print('... read crazy object')
            const result = tx.executeSql('select * from data where name="crazy"')
            if(result.rows.length === 1) {
                print('... update crazy geometry')
                // get the value column
                const value = result.rows[0].value
                // convert to JS object
                const obj = JSON.parse(value)
                // apply to object
                crazy.x = obj.x
                crazy.y = obj.y
            }
        })
    }
// #endregion M4

    Component.onCompleted: {
        initDatabase()
        readData()
    }

    Component.onDestruction: {
        storeData()
    }
}
