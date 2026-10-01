import QtQuick
import QtQuick.Controls
import Quickshell
import "../../services"
import "../../"

Rectangle {
    implicitWidth: islandExpanded ? 500 : clockText.implicitWidth + 40
    height: islandExpanded ? 300 : Config.barHeight
    radius: Config.barHeight / 2
    color: clockHover.hovered
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdOnSurface, 0.08))
           : ThemeService.mdSurface
    clip: true

    Behavior on implicitWidth {
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

    property bool islandExpanded: false

    // non expanded state
    Item {
        anchors.fill: parent

        opacity: islandExpanded ? 0 : 1
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: Config.animVeryFast; easing.type: Config.easeEnter }
        }

        HoverHandler { id: clockHover }
        TapHandler { id: clockTap; onTapped: islandExpanded = !islandExpanded}

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
