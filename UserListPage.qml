import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    property string url: ""
    property int numUsers: Number.MAX_VALUE

    JSONListModel {
        id: listModel
        source: page.url + ((oAuthTokenGetter === null || oAuthTokenGetter.token === "") ? "" : oAuthTokenGetter.firstGet)
        query: "$[*]"
    }

    Flickable {
        id: flickable
        width: parent.width
        height: parent.height
        contentWidth: width
        contentHeight: grid.height
        flickableDirection: Flickable.VerticalFlick

        onAtYEndChanged: if (atYEnd) loadNextPage();

        function loadNextPage() {
            if (listModel.count < numUsers)
                listModel.addElementsFromLink(listModel.source + "&page=" + Math.floor((listModel.count / 30) + 1));
        }

        Grid {
            id: grid
            columns: Math.floor(mainView.width / units.gu(16))
            rowSpacing: units.gu(2)
            columnSpacing: units.gu(2)

            Repeater {
                id: repeater
                model: listModel.model

                delegate: UserThumb {
                    width: moreButton.width
                    height: width
                    login: (page.url === "") ? "" : model.login
                    avatar_url: (page.url === "") ? "" : model.avatar_url
                    name: (page.url === "" || model.name === undefined) ? "" : model.name
                }
            }

            MoreButton {
                id: moreButton
                onClicked: flickable.loadNextPage()
                width: (page.width - ((grid.columns - 1) * grid.columnSpacing)) / grid.columns
                height: width
                visible: repeater.count !== numUsers
            }
        }
    }
}
