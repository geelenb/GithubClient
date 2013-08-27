import QtQuick 2.0
import Ubuntu.Components 0.1

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    id: mainView
    
    // Note! applicationName needs to match the .desktop filename
    applicationName: "GitHub"
    automaticOrientation: true

//    width: units.gu(48)
    width: units.gu(120)
    height: units.gu(80)

    headerColor: Qt.darker(backgroundColor)
    backgroundColor: "#343C60"
    footerColor: Qt.darker(backgroundColor)


    PageStack {
        id: pageStack

        ContentListPage {
            id: contentListPage
            visible: false
        }

        ContentPage {
            id: contentPage
            visible: false
        }

        LanguageListPage {
            id: languageListPage
            visible: false
        }

        OAuthTokenGetter {
            id: oAuthTokenGetter
            visible: false
        }

        RepoPage {
            id: repoPage
            visible: false
        }

        RepoListPage {
            id: repoListPage
            visible: false
        }

        SearchResultPage {
            id: searchResultPage
            visible: false
        }

        SideBarPage {
            id: sidebarPage
            visible: false
        }

        UserPage {
            id: userPage
            visible: false
    //        login: "torvalds"
//            login: "apburton84" // has perfectly filled in profile
        }

        UserListPage {
            id: userListPage
            visible: false
        }

        WebPage {
            id: webPage
            visible: false
        }

        SearchDialog {
            id: searchDialog
        }

        Component.onCompleted: {
            Theme.palette.normal.backgroundText = "#FFFFFF"
            Theme.palette.normal.overlay = "#FFFFFF"

            Theme.palette.selected.backgroundText = "#FFFFFF"
            Theme.palette.selected.overlay = "#FFFFFF"

            pageStack.push(oAuthTokenGetter)
        }
    }
}
