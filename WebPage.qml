import QtQuick 2.0
import Ubuntu.Components 0.1
import QtWebKit 3.0
//import Ubuntu.Components.Extras.Browser 0.1

Page {
    id: page
    title: "Log in on GitHub.com"
    property string url

    SideBar {
        id: sideBar
        expanded: page.width > units.gu(80)
    }

    WebView {
        anchors.fill: parent
        url: (page.url.substring(0, 4) === "http" ? "" : "http://") + page.url
    }

    tools: ToolbarItems {
        MeToolbarButton {}
        DebugActionToolbarButton {}
        SideBarButton{visible: !sideBar.expanded}
    }
}
