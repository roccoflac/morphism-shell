import QtQuick
import Quickshell
import "../../services"
import "../../"

Rectangle {
    implicitWidth: {
        if (audioExpanded) return 500
        if (networkExpanded) return 500
        return iconRow.implicitWidth + 40
    }

    implicitHeight: {
        if (audioExpanded) return 300
        if (networkExpanded) return 300
        return Config.barHeight
    }

    radius: Config.barHeight / 2
    color: ThemeService.mdSurface
    clip: true

    Behavior on width {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on height {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on radius {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on color {
        ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
    }

    property bool audioExpanded: false
    property bool networkExpanded: false

    Item {
        id: idleState
        anchors.fill: parent
        // opacity: notiExpanded ? 0 : 1
        scale: opacity
        visible: opacity > 0

        Behavior on scale {
            NumberAnimation {
                duration: Config.animSlow
                easing.type: Easing.OutBack
                easing.overshoot: 1
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: Config.animVeryFast; easing.type: Config.easeEnter }
        }

        Row {
            id: iconRow
            anchors.centerIn: parent
            spacing: Config.space200

            Text {
                id: networkIcon
                text: "\uf1eb" // fa-wifi
                font { pixelSize: Config.type2xl }
                color: ThemeService.mdSecondary
            }

            Text {
                id: audioIcon
                text: "\uefcf" // fa-bell
                font { pixelSize: Config.type2xl }
                color: ThemeService.mdSecondary
            }

        }
    }
}
