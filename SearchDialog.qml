import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Popups 0.1
import "JS.js" as JS

Component {
    id: searchDialog

    Dialog {
        id: dialog
        title: i18n.tr("Search")

        TextField {
            id: textField
            text: JS.lastSearch
            hasClearButton: true
            highlighted: true
        }

        Button {
            text: i18n.tr("Search")
            onClicked: {
                if (textField.text.length !== 0) {
                    JS.lastSearch = textField.text
                    pageStack.push(searchResultPage, {"search": textField.text})
                    PopupUtils.close(dialog);
                }
            }
        }
    }
}
