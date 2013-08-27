import QtQuick 2.0
import Ubuntu.Components 0.1

ToolbarButton {
    action: Action {
        id: resetButton

        iconSource: Qt.resolvedUrl("icons/pages.svg")
        text: i18n.tr("Show menu")
        onTriggered: pageStack.push(sidebarPage)
   }
}
