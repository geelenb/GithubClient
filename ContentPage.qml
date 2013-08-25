import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1 as ListItem

Page {
    id: page
    property string url

    onUrlChanged: {
        var xhr = new XMLHttpRequest;
        var rawurl = url.replace("https://github.com/", "https://raw.github.com/").replace("/blob/", "/")
        xhr.open("GET", rawurl);
        xhr.onreadystatechange = function() {
            if (xhr.readyState == XMLHttpRequest.DONE) {
                label.text = xhr.responseText
            }
        }
        xhr.send();
    }

    Flickable {
        id: flickable
        width: parent.width
        height: parent.height
        contentWidth: label.contentWidth
        contentHeight: label.contentHeight
        flickableDirection: Flickable.VerticalFlick

        Label {
            id: label
            property int fontSize: 5
            font.family: "Ubuntu mono"

            text: "Content is loading..."
            font.pixelSize: units.gu(fontSize)
        }
    }

    tools: ToolbarItems {
        ToolbarButton {
            action: Action {
                id: zoomOutButton
                iconSource: Qt.resolvedUrl("icons/zoomout.svg")
                text: i18n.tr("Zoom out")
                onTriggered: label.fontSize--
                visible: label.fontSize >= 2
           }
        }
        ToolbarButton {
            action: Action {
                id: zoomInButton

                iconSource: Qt.resolvedUrl("icons/zoomin.svg")
                text: i18n.tr("Zoom in")
                onTriggered: label.fontSize++
           }
        }
    }
}
