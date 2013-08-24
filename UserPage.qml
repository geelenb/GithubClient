import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    property string login
    property var userObject

    onLoginChanged: {
        var xhr = new XMLHttpRequest;
        var requesting = "https://api.github.com/users/" + login + (oAuthTokenGetter === null || oAuthTokenGetter.token === "" ? "" : oAuthTokenGetter.firstGet)
        console.log(requesting)
        xhr.open("GET", requesting);
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
        userThumb.login = userObject.login
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

            ListItem.Standard {
                id: userThumbListItem
                height: Math.min(page.height, page.width) / 3
                UserThumb {
                    id: userThumb
                    login: page.login
                    progression: false
                    anchors.fill: parent
                }
            }


            ListItem.Standard {
                id: bio
                text: visible ? userObject.bio : ""
                visible: userObject !== undefined && userObject.bio !== undefined && userObject.bio !== null
            }

            ListItem.Standard {
                id: email
                text: visible ? (userObject.email + (userObject.hireable ? " (hireable)" : "")) : ""
                visible: userObject !== undefined && userObject.email !== null

                // TODO add onClicked here, to send a mail (friends api?)
                progression: true
            }

            ListItem.Standard {
                id: blog
                text: visible ? userObject.blog : ""
                visible: userObject !== undefined && userObject.blog !== null

                progression: true
                onClicked: pageStack.push(webPage, {"url": userObject.blog})
            }

            ListItem.Standard {
                id: location
                text: visible ? userObject.location : ""
                visible: userObject !== undefined && userObject.location !== null

                // add openstreetmap - geonames.org ?
            }

            ListItem.Standard {
                id: company
                text: visible ? userObject.company : ""
                visible: userObject !== undefined && userObject.company !== null

                // TODO add onClicked here, to view organizations
                progression: true
                // dont forget title
            }

            ListItem.Standard {
                id: repos
                text: visible ? (userObject.public_repos + (userObject.total_private_repos === undefined ? 0 : userObject.total_private_repos)) + i18n.tr(" repos") : ""
                visible: userObject !== undefined && userObject.public_repos !== null

                progression: true
                onClicked: pageStack.push(repoListPage, {"url": userObject.repos_url,
                                                         "numRepos": (userObject.public_repos + userObject.total_private_repos),
                                                         "title": i18n.tr("Repos")})
            }

            ListItem.Standard {
                id: following
                text: userObject !== undefined ? i18n.tr("following ") + userObject.following + i18n.tr(" users") : ""
                visible: userObject !== undefined && userObject.following !== 0

                progression: true
                onClicked: pageStack.push(userListPage, {"url": userObject.following_url.substring(0, userObject.following_url.length - 13),
                                                         "title": i18n.tr("Following")})
            }

            ListItem.Standard {
                id: followers
                text: visible ? userObject.followers + i18n.tr(" followers") : ""
                visible: userObject !== undefined && userObject.followers !== 0

                progression: true
                onClicked: pageStack.push(userListPage, {"url": userObject.followers_url,
                                                         "title": i18n.tr("Followers")})
            }

            ListItem.Standard {
                id: gists
                text: visible ? userObject.public_gists + i18n.tr(" public gists") : ""
                visible: userObject !== undefined && userObject.public_gists !== 0

                // TODO add onClicked here, to view gists
                progression: userObject !== undefined && userObject.public_gists !== 0
                // dont forget title
            }

            ListItem.Standard {
                id: updated
                text: visible ? i18n.tr("Last updated: ") + new Date(userObject.updated_at).toLocaleDateString(Qt.locale()) : ""
                visible: userObject !== undefined
            }

            ListItem.Standard {
                id: created
                text: visible ? i18n.tr("Created on: ") + new Date(userObject.created_at).toLocaleDateString(Qt.locale()) : ""
                visible: userObject !== undefined
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
