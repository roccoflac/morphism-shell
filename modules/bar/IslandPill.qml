import QtQuick
import QtQuick.Controls
import Quickshell
import "../../services"
import "../../"

Rectangle {
    implicitWidth: clockText.implicitWidth + 40
    height: Config.barHeight
    radius: Config.barHeight / 2
    color: clockHover.hovered
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdOnSurface, 0.08))
           : ThemeService.mdSurface
    clip: true

    Behavior on color {
        ColorAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on implicitWidth {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }

    Item {
        anchors.fill: parent

        HoverHandler { id: clockHover }
        TapHandler { id: clockTap }

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        Text {
            id: clockText
            anchors { centerIn: parent }
            text: clockHover.hovered ? Qt.formatDateTime(clock.date, "ddd, MMM d") : Qt.formatDateTime(clock.date, "hh:mm ap") // idk if i want to do "ap" or "AP"
            color: ThemeService.mdOnSurface
            font { pixelSize: Config.typeXl; family: Config.fontFamily2 }

            Behavior on color {
                ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
            }
        }
    }
}
