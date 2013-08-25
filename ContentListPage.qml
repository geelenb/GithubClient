import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    // title initialization permitted from caller
    property string url: ""

    property bool columnView: true

    onColumnViewChanged: {
        grid.columns = columnView ? 1 : Math.floor(page.width / units.gu(12))

        for (var i = 0; i < repeater.count; i++) {
            repeater.itemAt(i).inColumn = columnView

        }
    }

    function moveUp() {
        pageStack.push(contentListPage, {
                           "url": url.substring(0, url.lastIndexOf("/"))
                       })
    }

    JSONListModel {
        id: listModel
        source: url + ((oAuthTokenGetter === null || oAuthTokenGetter.token === "") ? "" : (url.indexOf("?") === -1 ? oAuthTokenGetter.firstGet : oAuthTokenGetter.otherGet))
        query: "$[*]"
    }

    Flickable {
        id: flickable
        width: parent.width
        height: parent.height
        contentWidth: width
        contentHeight: grid.childrenRect.height
        flickableDirection: Flickable.VerticalFlick

        Grid {
            id: grid
            anchors.fill: parent

            Rectangle {
                id: upRect
                color: "transparent"
                visible: page.url.charAt(page.url.length - 1) === '/' // it's the root folder

                height: units.gu(12)
                width: parent.width

                UbuntuShape {
                    id: ubuntuShape
                    anchors.left: parent.left
                    anchors.top: parent.top
                    height: parent.height
                    width: height

                    radius: "medium"
                    Image {
                        id: image
                        width: ubuntuShape.width / 2
                        height: ubuntuShape.height / 2
                        anchors.centerIn: ubuntuShape
                        source: Qt.resolvedUrl("icons/up.svg")
                    }
                }

                Rectangle {
                    id: rightRectangle
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.left: ubuntuShape.right

                    color: "transparent"

                    Label {
                        id: nameLabel
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left

                        width: parent.width
                        wrapMode: Text.Wrap

                        font.bold: true
                        font.pixelSize: parent.height / 4
                        text: "Move up one level"
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: page.moveUp();
                }
            }

            Repeater {
                id: repeater
                model: listModel.model

                delegate: ContentThumb {
                    contentObject: model
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
        ToolbarButton {
            action: Action {
                id: switchGridButton

                iconSource: Qt.resolvedUrl("icons/keypad.svg")
                text: i18n.tr("Switch view")
                onTriggered: columnView = !columnView
           }
        }
        ToolbarButton {
            action: Action {
                id: moveUpButton
                iconSource: Qt.resolvedUrl("icons/up.svg")
                text: i18n.tr("Move folder up")
                onTriggered: page.moveUp()
                visible: page.url.charAt(page.url.length - 1) === '/' // it's the root folder
           }
        }
    }
}
