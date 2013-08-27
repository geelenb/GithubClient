import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    property string url: ""
    property int numUsers: 2000000000 // number.max value is bugged

    JSONListModel {
        id: listModel
        source: url + ((oAuthTokenGetter === null || oAuthTokenGetter.token === "") ? "" : oAuthTokenGetter.firstGet)
        query: "$[*]"
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
                    showing: false
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

    tools: ToolbarItems {
        MeToolbarButton {}
        DebugActionToolbarButton {}
        SideBarButton{visible: !sideBar.expanded}
    }
}
