import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "../../services"
import "../../"

Rectangle {
    width: batteryText.implicitWidth + 40
    height: 40
    radius: height
    color: ThemeService.mdSurface

    Item {
        anchors.fill: parent

        Text {
            id: batteryText
            anchors.centerIn: parent
            text: UPower.displayDevice.ready ? `${Math.round(UPower.displayDevice.percentage * 100)}%` : "0%"

            color: ThemeService.mdOnSurface
            font { pixelSize: Config.typeXl; family: Config.fontFamily2 }

            Behavior on color {
                ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
            }
        }

        HoverHandler {
            id: batteryHover
            cursorShape: Qt.PointingHandCursor
        }
        TapHandler { id: batteryTap }
    }
}
