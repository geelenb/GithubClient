import QtQuick 2.0
import Ubuntu.Components 0.1

Rectangle {
    id: rect
    property var object
    property string searchType
    onSearchTypeChanged: console.log(searchType)
    color: "transparent"

    width: parent.width
    height: units.gu(16)
    RepoThumb {
        id: repoThumb
        repoObject: visible ? object : undefined
        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"
        width: visible ? object : 0
        height: visible ? object : 0
        visible: searchType === "code"
    }

    ContentThumb {
        id: contentThumb
        contentObject: visible ? object : undefined
        anchors.left: parent.left
        anchors.top: parent.top
        color: "transparent"
        width: visible ? object : 0
        height: visible ? object : 0
        visible: searchType === "code"
    }

//    IssueThumb {
//        id: contentThumb
//        contentObject: searchType === "code" ? object : undefined
//        anchors.left: parent.left
//        anchors.top: parent.top
//        width: searchType === "code" ? object : 0
//        height: searchType === "code" ? object : 0
//        visible: searchType === "code"
//    }

    UserThumb {
        id: userThumb
        color: "transparent"
        name: null
        login: object.login
        avatar_url: object.avatar_url
        showing: true
    }
}
