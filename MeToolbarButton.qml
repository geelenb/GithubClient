import QtQuick 2.0
import Ubuntu.Components 0.1

ToolbarButton {
    action: Action {
        id: resetButton

        iconSource: Qt.resolvedUrl("icons/contact.svg")
        text: i18n.tr("Me")
        onTriggered: {
            var xhr = new XMLHttpRequest;
            var requesting = "https://api.github.com/user?access_token=" + oAuthTokenGetter.token
            console.log(requesting);
            xhr.open("GET", requesting);
            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    pageStack.push(userPage, {"userObject": JSON.parse(xhr.responseText)});
                }
            }
            xhr.send();
        }
   }
}
