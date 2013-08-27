import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem
import "JS.js" as JS

Page {
    id: page
    property string url: ""
    property int maxLang: 1

    onUrlChanged: listModel.source= (url === "") ? "" : url + oAuthTokenGetter.firstGet

    LanguageListModel {
        id: listModel
        source: (url === "") ? "" : url + oAuthTokenGetter.firstGet
        onDone: {
            maxLang = 1;
            for (var i = 0; i < listModel.count; i++) {
                maxLang = Math.max(maxLang, Math.sqrt(listModel.model.get(i).value))
            }
            repeater.update()
        }
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

                delegate: UbuntuShape {
                    anchors.left: parent.left
                    radius: "medium"
                    color: model.key === undefined ? "white" : JS.getLanguageColor(model.key)

                    height: units.gu(10)
                    width: page.width * Math.sqrt(model.value) / maxLang


                    Label {
                        anchors.left: contentWidth > page.width - parent.width ? parent.left : parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        text: model.key === undefined ? "" : model.key
                    }
                }
            }
        }
    }

    tools: ToolbarItems {
        MeToolbarButton {}
        DebugActionToolbarButton {}
        SideBarButton{visible: !sideBar.expanded}
    }
}
