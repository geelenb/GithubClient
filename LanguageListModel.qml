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
    property var objectArray: []

    property ListModel model : ListModel { id: jsonModel }
    property alias count: jsonModel.count

    signal done

    onSourceChanged: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", source);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE)
                json = xhr.responseText;
        }
        xhr.send();
    }

    onJsonChanged: {
        jsonModel.clear();

        if ( json === "" )
            return;

        objectArray = JSON.parse(json);
        for ( var key in objectArray ) {
            jsonModel.append({"key": key, "value": objectArray[key]});
        }

        // sort the elements slowly
        for (var i = 0; i < count - 1; i++)
            for (var j = i + 1; j < count; j++)
                if (model.get(i).value < model.get(j).value)
                    model.move(j, i, 1);

        done();
    }
}
