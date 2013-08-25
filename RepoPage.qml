import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    property string full_name
    property var repoObject
//    style: Theme.createStyleComponent("MyPalletteValues.qml", page)

    onFull_nameChanged: {
        var xhr = new XMLHttpRequest;
        var requesting = "https://api.github.com/repos/" + full_name + (oAuthTokenGetter === null || oAuthTokenGetter.token === "" ? "" : oAuthTokenGetter.firstGet)
        console.log(requesting)
        xhr.open("GET", requesting);
        xhr.onreadystatechange = function() {
            if (xhr.readyState === XMLHttpRequest.DONE) {
                repoObject = JSON.parse(xhr.responseText)
            }
        }
        xhr.send();
    }

    onRepoObjectChanged: {
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
                id: repoThumbListItem
                height: Math.min(page.height, page.width) / 3
                RepoThumb {
                    id: repoThumb
                    repoObject: page.repoObject
                    progression: false
                    anchors.fill: parent
                }
            }

            ListItem.Standard {
                id: web
                text: visible ? repoObject.homePage : ""
                visible: repoObject !== undefined && repoObject.homePage !== undefined && repoObject.homePage !== null
                progression: true
                onClicked: pageStack.push(webPage, {"url": repoObject.homePage})
            }

            ListItem.Standard {
                id: language
                text: visible ? i18n.tr("language: ") + repoObject.language : ""
                visible: repoObject !== undefined && repoObject.language !== undefined && repoObject.language !== null
                progression: true
                // TODO: make languageListPage
//                onClicked: pageStack.push(webPage, {"url": repoObject.homePage})
            }

            ListItem.Standard {
                id: contents
                text: i18n.tr("Browse contents")
                visible: repoObject !== undefined
                progression: true
                onClicked: pageStack.push(contentListPage, {"url": repoObject.contents_url.substring(0, repoObject.contents_url.length - 7)})
            }

            ListItem.Standard {
                id: commits
                text: i18n.tr("Latest commits")
                visible: repoObject !== undefined
                progression: true
                // TODO: make commitListPage
//                onClicked: pageStack.push(webPage, {"url": repoObject. SUBSTRING})
            }

            ListItem.Standard {
                id: collaborators
                text: i18n.tr("Collaborators")
                visible: repoObject !== undefined
                progression: true
                onClicked: pageStack.push(userListPage, {"url": repoObject.collaborators_url.substring(0, repoObject.collaborators_url.length - 15)})
            }

            ListItem.Standard {
                id: contributors
                text: i18n.tr("Contributors")
                visible: repoObject !== undefined
                progression: true
                onClicked: pageStack.push(userListPage, {"url": repoObject.contributors_url})
            }

            ListItem.Standard {
                id: stargazers
                text: visible ? (i18n.tr("Stargazers: ") + repoObject.watchers) : ""
                visible: repoObject !== undefined && repoObject.watchers !== undefined
                progression: true
                onClicked: pageStack.push(userListPage, {"url": repoObject.stargazers_url})
            }

            ListItem.Standard {
                id: subscribers
                text: i18n.tr("Subscribers")
                visible: repoObject !== undefined && repoObject.subscribers_url !== undefined
                progression: true
                onClicked: pageStack.push(userListPage, {
                                              "url": repoObject.subscribers_url/*,
                                              "numUsers": Number.MAX_VALUE*/})
            }

            ListItem.Standard {
                id: issues
                text: visible ? i18n.tr("Issues: ") + repoObject.open_issues : ""
                visible: repoObject !== undefined && repoObject.open_issues !== undefined
                progression: true
                // TODO make issueListPage
//                onClicked: pageStack.push(issueListPage, {"url": repoObject.issues_url.SUBSTRING})
                // dont forget issues as title
            }

            ListItem.Standard {
                id: forks
                text: visible ? i18n.tr("Forks: ") + repoObject.forks : ""
                visible: repoObject !== undefined && repoObject.forks !== undefined
                progression: true
                onClicked: pageStack.push(repoListPage, {"url": repoObject.forks_url,
                                                         "numRepos": repoObject.forks})
            }

            ListItem.Standard {
                id: updated
                text: visible ? i18n.tr("Last updated: ") + new Date(repoObject.updated_at).toLocaleDateString(Qt.locale()) : ""
                visible: repoObject !== undefined
            }

            ListItem.Standard {
                id: created
                text: visible ? i18n.tr("Created on: ") + new Date(repoObject.created_at).toLocaleDateString(Qt.locale()) : ""
                visible: repoObject !== undefined
            }

            ListItem.Standard {
                id: pushed
                text: visible ? i18n.tr("Last pushed on: ") + new Date(repoObject.pushed_at).toLocaleDateString(Qt.locale()) : ""
                visible: repoObject !== undefined
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
