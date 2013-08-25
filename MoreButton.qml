import QtQuick 2.0
import Ubuntu.Components 0.1

Button {
    text: i18n.tr("More...")
    gradient: Gradient {
        GradientStop { position: 0.0; color: mainView.backgroundColor }
        GradientStop { position: 1.0; color: mainView.footerColor }
    }
}
