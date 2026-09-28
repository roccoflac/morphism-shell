import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "../../services"
import "../../"

Rectangle {
    width: batteryText.implicitWidth + 40
    height: 40
    radius: height
    color: batteryHover.hovered
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdOnSurface, 0.08))
           : ThemeService.mdSurface

    Behavior on color {
        ColorAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }

    Item {
        anchors.fill: parent

        HoverHandler {
            id: batteryHover
            cursorShape: Qt.PointingHandCursor
        }
        TapHandler { id: batteryTap }

        Text {
            id: batteryText
            anchors.centerIn: parent
            text: UPower.displayDevice.ready ? `${Math.round(UPower.displayDevice.percentage * 100)}%` : "0%"
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
