import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

SideBar {
    id: sideBar
    default property alias contents: column.data

    contents: Flickable {
        anchors.fill: parent
        contentWidth: width
        contentHeight: column.childrenRect.height
        interactive: contentHeight > height

        Column {
            id: column
            anchors.fill: parent


        }
    }
}
