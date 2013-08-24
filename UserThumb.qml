import QtQuick 2.0
import Ubuntu.Components 0.1

Rectangle {
    id: thumbRect
    property string login
    property string avatar_url
    property string name
    property bool progression: true

    onAvatar_urlChanged: image.source = avatar_url + "?s=" + Math.round(height)
//    onAvatar_urlChanged: image.source = avatar_url + "&s=" + Math.round(height)
    onNameChanged: loginLabel.text = (rightRectangle.showing) ? login : ""
    onLoginChanged: loginLabel.text = (rightRectangle.showing) ? login : ""
    color: "transparent"
    height: units.gu(16)
    width: height

    UbuntuShape {
        id: ubuntuShape
        anchors.left: parent.left
        anchors.top: parent.top
        height: parent.height
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

            text: (rightRectangle.showing) ? "" : login
        }
    }

    Rectangle {
        id: rightRectangle
        anchors.top: parent.top
        anchors.right: showing ? parent.right : ubuntuShape.right
        anchors.bottom: parent.bottom
        anchors.left: ubuntuShape.right

        color: "transparent"

        property bool showing: parent.width >= 2.5 * parent.height

        Label {
            id: nameLabel
            anchors.top: parent.top
            anchors.left: parent.left

            width: parent.width
            wrapMode: Text.Wrap

            font.bold: true
            font.pixelSize: parent.height / 4
            text: rightRectangle.showing ? ((name === null) ? login : name) : ""
        }

        Label {
            id: loginLabel
            anchors.top: nameLabel.bottom
            anchors.left: parent.left

            width: parent.width

            wrapMode: Text.Wrap

            font.bold: false
            font.pixelSize: parent.height / 6
            text: (!rightRectangle.showing || thumbRect.name === null) ? "" : login
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
