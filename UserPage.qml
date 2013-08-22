import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    property string login
    property var userObject


    Component.onCompleted: {
        var xhr = new XMLHttpRequest;
        xhr.open("GET", "https://api.github.com/users/" + login);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                userObject = JSON.parse(xhr.responseText)
            }
        }
        xhr.send();
    }

    onUserObjectChanged: {
        userThumb.avatar_url = userObject.avatar_url
        userThumb.name = userObject.name
    }

    Column {
        id: column
        width: parent.width
//        height: parent.height

        ListItem.Standard {
            height: Math.min(page.height, page.width) / 3
            UserThumb {
                id: userThumb
                login: page.login
                progression: false

        //        color: white

                //anchors.top: parent.top
                anchors.fill: parent
//                anchors.left: parent.left
//                height: Math.min(mainView.height, mainView.width) / 3
//                width: column.width
            }
        }


        ListItem.Standard {
            id: bio
            //anchors.top: userThumb.bottom
            text: visible ? userObject.bio : ""
            visible: userObject !== undefined && userObject.bio !== null
        }

        ListItem.Standard {
            id: email
            //anchors.top: bio.bottom
            text: visible ? (userObject.email + (userObject.hireable ? " (hireable)" : "")) : ""
            visible: userObject !== undefined && userObject.email !== null

            // TODO add onClicked here, to send a mail
            progression: true
        }

        ListItem.Standard {
            id: blog
            //anchors.top: email.bottom
            text: visible ? userObject.blog : ""
            visible: userObject !== undefined && userObject.blog !== null

            // TODO add onClicked here, to view webpage (make a page element WebPage)
            progression: true
            onClicked: pageStack.push(webPage, {"url": userObject.blog})
        }

        ListItem.Standard {
            id: location
            //anchors.top: blog.bottom
            text: visible ? userObject.location : ""
            visible: userObject !== undefined && userObject.location !== null
        }

        ListItem.Standard {
            id: company
            //anchors.top: location.bottom
            text: visible ? userObject.company : ""
            visible: userObject !== undefined && userObject.company !== null

            // TODO add onClicked here, to view organizations
            progression: true
        }

        ListItem.Standard {
            id: repos
            //anchors.top: company.bottom
            text: visible ? userObject.public_repos + i18n.tr(" public repos") : ""
            visible: userObject !== undefined && userObject.public_repos !== null

            // TODO add onClicked here, to view public repos
            progression: true
        }

        ListItem.Standard {
            id: following
            //anchors.top: repos.bottom
            text: userObject !== undefined ? i18n.tr("following ") + userObject.following + i18n.tr(" users") : ""
            visible: userObject !== undefined && userObject.following !== 0

            // TODO add onClicked here, to view following
            progression: true
        }

        ListItem.Standard {
            id: followers
            //anchors.top: following.bottom
            text: visible ? userObject.followers + i18n.tr(" followers") : ""
            visible: userObject !== undefined && userObject.followers !== 0

//             TODO add onClicked here, to view following
            progression: true
        }

        ListItem.Standard {
            id: gists
            //anchors.top: followers.bottom
            text: visible ? userObject.public_gists + i18n.tr(" public gists") : ""
            visible: userObject !== undefined && userObject.public_gists !== 0

            // TODO add onClicked here, to view following
            progression: userObject !== undefined && userObject.public_gists !== 0
        }

        ListItem.Standard {
            id: updated
            //anchors.top: gists.bottom
            text: visible ? i18n.tr("Last updated: ") + new Date(userObject.updated_at).toLocaleDateString(Qt.locale()) : ""
            visible: userObject !== undefined
        }

        ListItem.Standard {
            id: created
            //anchors.top: updated.bottom
            text: visible ? i18n.tr("Created on: ") + new Date(userObject.created_at).toLocaleDateString(Qt.locale()) : ""
            visible: userObject !== undefined
        }
    }
}
