import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    // title initialization permitted from caller
    property string url

    JSONListModel {
        id: listModel
        source: page.url
        query: "$[*]"
    }

    Flickable {
        width: parent.width
        height: parent.height
        contentWidth: width
        contentHeight: column.childrenRect.height
        flickableDirection: Flickable.VerticalFlick

        Column {
            id: column
            anchors.fill: parent

            Repeater {
                id: repeater
                model: listModel.objectArray

                delegate: RepoThumb {
                    repoObject: modelData
                }
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
