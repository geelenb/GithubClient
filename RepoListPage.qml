import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    // title initialization permitted from caller
    property string url
    property int numRepos: Number.MAX_VALUE

    JSONListModel {
        id: listModel
        source: url + ((oAuthTokenGetter === null || oAuthTokenGetter.token === "") ? "" : oAuthTokenGetter.firstGet)
        query: "$[*]"
    }

    Flickable {
        id: flickable
        width: parent.width
        height: parent.height
        contentWidth: width
        contentHeight: column.childrenRect.height
        flickableDirection: Flickable.VerticalFlick

        onAtYEndChanged: {
            if (atYEnd)
                loadNextPage();
        }

        function loadNextPage() {
            if (listModel.count < numRepos)
                listModel.addElementsFromLink(listModel.source + "&page=" + Math.floor((listModel.count / 30) + 1));
        }

        Column {
            id: column
            anchors.fill: parent

            Repeater {
                id: repeater
                model: listModel.model

                delegate: RepoThumb {
                    repoObject: model
                }
            }

            MoreButton {
                id: moreButton
                onClicked: flickable.loadNextPage()
                width: parent.width
                height: units.gu(16)
                visible: listModel.count < numRepos
            }
        }
    }

    tools: ToolbarItems {
        LoginToolbarButton {
            visible: oAuthTokenGetter.token === ""
        }
        MeToolbarButton {
            visible: oAuthTokenGetter.token !== ""
        }
        DebugActionToolbarButton {}
    }
}
