import QtQuick 2.0
import Ubuntu.Components 0.1

ToolbarButton {
    action: Action {
        id: resetButton

        iconSource: Qt.resolvedUrl("icons/contact.svg")
        text: i18n.tr("Log in")
        onTriggered: pageStack.push(oAuthTokenGetter)
   }
}
