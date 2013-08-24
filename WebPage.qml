import QtQuick 2.0
import Ubuntu.Components 0.1
import QtWebKit 3.0
//import Ubuntu.Components.Extras.Browser 0.1

Page {
    id: webPage
    property string url

    WebView {
        anchors.fill: parent
        url: (webPage.url.substring(0, 4) === "http" ? "" : "http://") + webPage.url
    }
}
