import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1

ToolbarButton {
    action: Action {
        id: resetButton

        iconSource: Qt.resolvedUrl("icons/search.svg")
        text: i18n.tr("Search")
        onTriggered: PopupUtils.open(searchDialog)
   }
}
