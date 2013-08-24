import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    property string url: ""

    JSONListModel {
        id: listModel
        source: page.url + ((oAuthTokenGetter === null || oAuthTokenGetter.token === "") ? "" : oAuthTokenGetter.firstGet)
        query: "$[*]"
    }

    Flickable {
        width: parent.width
        height: parent.height
        contentWidth: width
        contentHeight: grid.height
        flickableDirection: Flickable.VerticalFlick

        Grid {
            id: grid
            columns: Math.floor(mainView.width / units.gu(16))
            rowSpacing: units.gu(2)
            columnSpacing: units.gu(2)

            Repeater {
                id: repeater
                model: listModel.objectArray

                delegate: UserThumb {
                    width: (page.width - ((grid.columns - 1) * grid.columnSpacing)) / grid.columns
                    height: width
                    login: (page.url === "") ? "" : modelData.login
                    avatar_url: (page.url === "") ? "" : modelData.avatar_url
                    name: (page.url === "" || modelData.name === undefined) ? "" : modelData.name
                }
            }
        }
    }
}
