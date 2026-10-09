import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "../../services"
import "../../"

Rectangle {
    width: batteryExpanded ? 300 : batteryText.implicitWidth + Config.pillPadding
    height: batteryExpanded ? 400 : Config.barHeight
    radius: batteryExpanded ? Config.radiusLg : Config.barHeight / 2
    color: batteryHover.hovered
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdOnSurface, 0.08))
           : ThemeService.mdSurface
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
        ColorAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }

    property bool batteryExpanded: false

    Item {
        anchors.fill: parent
        opacity: batteryExpanded ? 0 : 1
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: Config.animVeryFast; easing.type: Config.easeEnter }
        }

        HoverHandler {
            id: batteryHover
            cursorShape: Qt.PointingHandCursor
        }
        TapHandler {
            onTapped: batteryExpanded = !batteryExpanded
        }

        Text {
            id: batteryText
            anchors.centerIn: parent
            text: Config.showPercentage ? UPower.displayDevice.ready ? `${Math.round(UPower.displayDevice.percentage * 100)}%` : "0%" : "\uf011"
            font { pixelSize: Config.typeXl; family: Config.fontFamily2 }

            color: {
                if (!UPower.displayDevice.ready) return ThemeService.mdOnSurface;

                let state = UPower.displayDevice.state;
                if (state === 1 || state === 4) {
                    return ThemeService.mdCharging;
                }

                let pct = UPower.displayDevice.percentage;
                if (pct <= 0.20) return ThemeService.mdError;
                if (pct <= 0.30) return ThemeService.mdWarning;

                return ThemeService.mdOnSurface;
            }

            Behavior on color {
                ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
            }
        }
    }
}
