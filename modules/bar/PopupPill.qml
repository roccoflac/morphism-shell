import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../services"
import "../../"

Rectangle {
    id: root

    readonly property int networkExpandedWidth: 500
    readonly property int audioExpandedWidth: 300
    readonly property int collapsedWidth: iconRow.implicitWidth + Config.pillPadding
    readonly property int networkExpandedHeight: 400
    readonly property int audioExpandedHeight: 500
    readonly property int collapsedHeight: Config.barHeight

    implicitWidth:
        networkExpanded ? networkExpandedWidth :
        audioExpanded ? audioExpandedWidth :
        collapsedWidth

    implicitHeight:
        networkExpanded ? networkExpandedHeight :
        audioExpanded ? audioExpandedHeight :
        collapsedHeight
    radius: Config.barHeight / 2
    color: ThemeService.mdSurface
    clip: true

    Behavior on implicitWidth {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on implicitHeight {
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
        opacity: audioExpanded || networkExpanded ? 0 : 1
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

        RowLayout {
            id: iconRow
            anchors.centerIn: parent
            spacing: Config.space200

            Text {
                id: networkIcon
                text: "\udb82\udd25" // fa-wifi
                font { pixelSize: Config.typeXl +2 }
                color: networkHover.hovered
                       ? Qt.tint(ThemeService.mdPrimary, Qt.alpha(ThemeService.mdOnPrimary, 0.10))
                       : ThemeService.mdPrimary
                scale: networkTap.pressed ? 1 : (networkHover.hovered ? 1.06 : 1.0)

                HoverHandler { id: networkHover; cursorShape: Qt.PointingHandCursor }
                TapHandler { id: networkTap; onTapped: networkExpanded = !networkExpanded }

                Behavior on scale {
                    NumberAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
                }
                Behavior on color {
                    ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
                }
            }

            Text {
                id: audioIcon
                text: "\udb81\udd7e" // fa-bell
                font { pixelSize: Config.typeXl +5 }
                color: audioHover.hovered
                       ? Qt.tint(ThemeService.mdPrimary, Qt.alpha(ThemeService.mdOnPrimary, 0.10))
                       : ThemeService.mdPrimary
                scale: audioTap.pressed ? 1 : (audioHover.hovered ? 1.06 : 1.0)

                HoverHandler { id: audioHover; cursorShape: Qt.PointingHandCursor }
                TapHandler { id: audioTap; onTapped: audioExpanded = !audioExpanded  }

                Behavior on scale {
                    NumberAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
                }
                Behavior on color {
                    ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
                }
            }

        }
    }
}
