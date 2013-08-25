import QtQuick 2.0
import Ubuntu.Components 0.1

Rectangle {
    id: thumbRect
    // is always defined
    property var contentObject
    property bool progression: true
    property bool inColumn: true

    color: "transparent"

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
            // TODO add more file types
            source: Qt.resolvedUrl((contentObject.type === "dir") ? "icons/folder.svg" : "icons/file.svg")
        }

        Label {
            anchors.centerIn: parent

            font.bold: true
            font.pixelSize: parent.height / 5

            text: (contentObject.type === "dir"
                   || contentObject.name.lastIndexOf(".") === -1
                   || contentObject.name.lastIndexOf(".") < contentObject.name.length - 5) ?
                      "" :
                      contentObject.name.substring(contentObject.name.lastIndexOf(".") + 1)
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom

            font.bold: true
            font.pixelSize: parent.height / 7

            text: (inColumn) ? "" : contentObject.name
        }
    }

    Rectangle {
        id: rightRectangle
        anchors.top: parent.top
        anchors.right: inColumn ? parent.right : ubuntuShape.right
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
            text: inColumn ? ((name === null) ? login : name) : ""
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (contentObject.type === "file") {
                if (progression)
                    pageStack.push(contentPage, {"contentObject": contentObject})
            } else {
                pageStack.push(contentListPage, {"url": contentObject.url})
            }
        }
    }
}
