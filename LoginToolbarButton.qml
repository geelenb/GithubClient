import QtQuick 2.0
import Ubuntu.Components 0.1

ToolbarButton {
    action: Action {
        id: resetButton

        iconSource: "/usr/share/icons/ubuntu-mobile/actions/scalable/contact.svg"
        text: i18n.tr("Log in")
        onTriggered: pageStack.push(oAuthTokenGetter)
   }
}
