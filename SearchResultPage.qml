import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    title: "Search results for \"" + search + "\""
    property string search: ""
    property string searchType: "users"
    property var advancedParams

    onSearchChanged: updateSearch()
    onSearchTypeChanged: {
        for (var i = 0; i < listModel.count; i++)
            repeater.itemAt(i).searchType = searchType
        updateSearch()
    }

    function updateSearch () {
        if (search === "") return

        var xhr = new XMLHttpRequest;
        var url = "https://api.github.com/search/" + searchType + "?q=" + encodeURI(search) + oAuthTokenGetter.otherGet
        for (var key in advancedParams)
            url = url.concat("&" + key + "=" + encodeURI(advancedParams[key]))

        console.log(url)
        xhr.open("GET", url);
        xhr.setRequestHeader("Accept", "application/vnd.github.preview")
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                console.log(xhr.responseText)
                listModel.json = xhr.responseText;
            }
        }
        xhr.send();
    }

    JSONListModel {
        id: listModel
        query: "$.items[*]"
    }

    SideBar {
        id: sideBar
        expanded: page.width > units.gu(80)
    }

    Flickable {
        anchors.right: parent.right
        anchors.left: sideBar.right
        anchors.bottom: parent.bottom
        height: parent.height
        contentWidth: width
        contentHeight: column.childrenRect.height
        flickableDirection: Flickable.VerticalFlick

        Column {
            id: column
            anchors.fill: parent

            Repeater {
                id: repeater
                model: listModel.model

                delegate: SearchResult {
                    object: model
                }
            }
        }
    }

    tools: ToolbarItems {
        opened: true
        ToolbarButton {
            action: Action {
                text: i18n.tr("Repos")
                onTriggered: searchType = "repositories"
           }
        }
        ToolbarButton {
            action: Action {
                text: i18n.tr("Code")
                onTriggered: searchType = "code"
           }
        }
        ToolbarButton {
            action: Action {
                text: i18n.tr("Issues")
                onTriggered: searchType = "issues"
           }
        }
        ToolbarButton {
            action: Action {
                text: i18n.tr("Users")
                onTriggered: searchType = "users"
           }
        }
    }
}
