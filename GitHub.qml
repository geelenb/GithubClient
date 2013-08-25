import QtQuick 2.0
import Ubuntu.Components 0.1

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"
    id: mainView
    
    // Note! applicationName needs to match the .desktop filename
    applicationName: "GitHub"
    automaticOrientation: true
    
//    width: 480
//    height: 800
    width: units.gu(48)
    height: units.gu(80)

//    headerColor: "#343C60"//"#343C60"
    backgroundColor: "#343C60"//"#6A69A2"
    footerColor: backgroundColor.darker(1.1)

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

        Component.onCompleted: {
            pageStack.push(oAuthTokenGetter)
        }
    }
}
