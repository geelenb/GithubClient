import QtQuick 2.0
import Ubuntu.Components 0.1
import "JS.js" as JS

Flickable {
    anchors.fill: parent
    contentWidth: width
    contentHeight: column.childrenRect.height
    interactive: contentHeight > height

    Column {
        id: column
        anchors.fill: parent

        UserThumb {
            id: userThumb
            width: parent.width
//            height: units.gu(16)
            showing: true
            progression: true

            Component.onCompleted: {
                var xhr = new XMLHttpRequest;
                oAuthTokenGetter.onTokenChanged.connect(function () {
                    xhr.open("GET", "https://api.github.com/user" + oAuthTokenGetter.firstGet);
                    xhr.onreadystatechange = function() {
                        if (xhr.readyState === XMLHttpRequest.DONE) {
                            var userObject = JSON.parse(xhr.responseText)
//                            console.log("dohier")
                            login = userObject.login
                            name = userObject.name
                            avatar_url = userObject.avatar_url
                        }
                    }
                    xhr.send();
                })
            }
        }
    }
}
