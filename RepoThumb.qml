import QtQuick 2.0
import Ubuntu.Components 0.1

Rectangle {
    id: thumbRect
    property var repoObject
    property bool progression: true

    onRepoObjectChanged: {
        if (repoObject !== undefined) {
            nameLabel.text = repoObject.name
            descriptionLabel.text = repoObject.description
            userThumb.login = repoObject.owner.login
            userThumb.avatar_url = repoObject.owner.avatar_url
        }
    }

    color: "transparent"

    width: parent.width
    height: userThumb.height

    Rectangle {
        id: repoRectangle
        anchors.top: parent.top
        anchors.right: userThumb.left
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        color: "transparent"

        Label {
            id: nameLabel
            anchors.top: parent.top
            anchors.left: parent.left

            width: parent.width
            wrapMode: Text.Wrap

            font.bold: true
            font.pixelSize: units.gu(3) // parent.height / 6
            text: (repoObject === undefined) ? "" : repoObject.name
        }

        Label {
            id: descriptionLabel
            anchors.top: nameLabel.bottom
            anchors.left: parent.left

            width: parent.width
            wrapMode: Text.WordWrap

            font.pixelSize: units.gu(2) //parent.height / 8
            text: (repoObject === undefined) ? "" : repoObject.description
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if (thumbRect.progression)
                    pageStack.push(repoPage, {"repoObject": thumbRect.repoObject})
            }
        }
    }

    UserThumb {
        id: userThumb
        login: (repoObject === undefined) ? "" : repoObject.owner.login
        avatar_url: (repoObject === undefined) ? "" : repoObject.owner.avatar_url

        anchors.top: parent.top
        anchors.right: parent.right
    }
}
