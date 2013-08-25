import QtQuick 2.0
import Ubuntu.Components 0.1
import "JS.js" as JS

ToolbarButton {
    action: Action {
        id: resetButton

        iconSource: Qt.resolvedUrl("icons/star.svg")
        text: i18n.tr("Debug action!")
        onTriggered: {
            var url = "https://api.github.com/notifications?access_token=" + oAuthTokenGetter.token
            JS.printPage(url)
        }
   }
}
