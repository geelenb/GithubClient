import QtQuick 2.0
import Ubuntu.Components 0.1

// TODO almost all of this.
Rectangle {
    id: thumbRect
    // is always defined
    property var contentObject


    UserThumb {
        login: contentObject.actor.login
        avatar_url: contentObject.actor.avatar_url
        progression: true
        showing: false

        anchors.left: parent.left
        anchors.top: parent.top
        height: parent.height
        width: height
    }
}
