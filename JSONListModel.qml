/* JSONListModel - a QML ListModel with JSON and JSONPath support
 *
 * Copyright (c) 2012 Romain Pokrzywka (KDAB) (romain@kdab.com)
 * Licensed under the MIT licence (http://opensource.org/licenses/mit-license.php)
 */

import QtQuick 2.0
import "jsonpath.js" as JSONPath

Item {
    property string source: ""
    property string json: ""
    property string query: ""
    property var objectArray: []

    property ListModel model : ListModel { id: jsonModel }
    property alias count: jsonModel.count

    onSourceChanged: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", source);
        console.log(source);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE)
                json = xhr.responseText;
        }
        xhr.send();
    }

    function addElementsFromLink(link) {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", link);
        console.log(link);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE){
                var newArray = parseJSONString(xhr.responseText, query);
                for (var key in newArray) {
                    jsonModel.append(newArray[key]);
                }
            }
        }
        xhr.send();
    }

    onJsonChanged: updateJSONModel()
    onQueryChanged: updateJSONModel()

    function updateJSONModel() {
        jsonModel.clear();

        if ( json === "" )
            return;

        objectArray = parseJSONString(json, query);
        for ( var key in objectArray ) {
            jsonModel.append(objectArray[key]);
        }
    }

    function parseJSONString(jsonString, jsonPathQuery) {
        var result = JSON.parse(jsonString);
        if ( jsonPathQuery !== "" )
            result = JSONPath.jsonPath(result, jsonPathQuery);

        return result;
    }
}
