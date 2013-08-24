import QtQuick 2.0
import Ubuntu.Components 0.1
import QtWebKit 3.0

Page {
    id: webPage
    property string token: ""
    property string firstGet: "?access_token=" + token

    WebView {
        anchors.fill: parent

        property string client_id: "5b8705dc0775845bd721"
        property string scope: "user,repo,notifications,gist"
        property string client_secret: "1b5826605af32b20414a1f6909090b239ac3c3fb"
        property string redirect_uri: "https://api.github.com/zen"
        property string access_token_url: "https://github.com/login/oauth/access_token" +
                                      "?client_secret=" + client_secret +
                                      "&client_id=" + client_id

        url: webPage.visible ? "https://github.com/login/oauth/authorize" +
                               "?client_id=" + client_id +
                               "&scope=" + scope +
                               "&redirect_uri=" + encodeURIComponent(redirect_uri) : ""
        onUrlChanged: {
            if (url.toString().substring(0, 32) === "https://api.github.com/zen?code=") {
                var code = url.toString().substring(32);

                var xhr = new XMLHttpRequest;
                var requesting = access_token_url + "&code=" + code;
                console.log(requesting)
                xhr.open("POST", requesting);
                xhr.onreadystatechange = function() {
                    if (xhr.readyState == XMLHttpRequest.DONE) {
                        webPage.token = xhr.responseText.substring(13, 53)
                        // move this to a database?
                        console.log("Oauth token is now : " + webPage.token)
                        pageStack.pop();
                    }
                }
                xhr.send();
            }
        }
    }
}
