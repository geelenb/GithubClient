import QtQuick 2.0
import Ubuntu.Components 0.1

Rectangle {
    id: thumbRect
    property string login
    property string avatar_url
    property string name
    property bool progression: true
    property bool showing

    onAvatar_urlChanged: image.source = avatar_url + "?s=" + Math.round(height)
    onNameChanged: loginLabel.text = (showing) ? login : ""
    onLoginChanged: loginLabel.text = (showing) ? login : ""
    color: "transparent"
    height: Math.max(ubuntuShape.height, rightRectangle.height)
    width: height

    UbuntuShape {
        id: ubuntuShape
        anchors.left: parent.left
        anchors.top: parent.top
        height: units.gu(16)
        width: height

        radius: "medium"
        image: Image {
            id: image
            source: ""
        }

        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom

            font.bold: true
            font.pixelSize: parent.height / 7
            style: Text.Outline
            color: "white"
            styleColor: "black"

            text: showing ? "" : login
        }
    }

    Rectangle {
        id: rightRectangle
        anchors.top: parent.top
        anchors.right: showing ? parent.right : ubuntuShape.right
        anchors.left: ubuntuShape.right

        height: nameLabel.height + loginLabel.height

        color: "transparent"

        Label {
            id: nameLabel
            anchors.top: parent.top
            anchors.left: parent.left

            width: parent.width
            wrapMode: Text.Wrap

            font.bold: true
            font.pixelSize: units.gu(4)
            text: showing ? ((name === null) ? login : name) : ""
        }

        Label {
            id: loginLabel
            anchors.top: nameLabel.bottom
            anchors.left: parent.left

            width: parent.width

            wrapMode: Text.Wrap

            font.bold: false
            font.pixelSize: units.gu(3)
            text: (!showing || thumbRect.name === null) ? "" : login
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (progression)
                pageStack.push(userPage, {"login": thumbRect.login})
        }
    }
}
