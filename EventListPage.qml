import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

// TODO almost all of this
Page {
    id: page
    // title initialization permitted from caller
    property string url: ""

    function moveUp() {
        pageStack.push(contentListPage, {
                           "url": url.substring(0, url.lastIndexOf("/")),
                           "depth": depth - 1
                       })
    }

    JSONListModel {
        id: listModel
        source: url + ((oAuthTokenGetter === null || oAuthTokenGetter.token === "") ? "" : (url.indexOf("?") === -1 ? oAuthTokenGetter.firstGet : oAuthTokenGetter.otherGet))
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
        contentHeight: grid.childrenRect.height
        flickableDirection: Flickable.VerticalFlick

    }


    tools: ToolbarItems {
        MeToolbarButton {}
        DebugActionToolbarButton {}
        SideBarButton{visible: !sideBar.expanded}
    }
}
