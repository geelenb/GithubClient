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

    PageStack {
        id: pageStack

        UserPage {
            id: userPage
    //        login: "torvalds"
            login: "apburton84" // has perfectly filled in profile
        }

        WebPage {
            id: webPage
            visible: false
        }

        Component.onCompleted: pageStack.push(userPage)
    }
}
