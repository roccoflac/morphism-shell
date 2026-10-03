import QtQuick
import Quickshell
import "../../services"
import "../../"

Rectangle {
    width: 100
    height: Config.barHeight
    radius: Math.min(width, height) / 2
    color: ThemeService.mdSurface
    clip: true

    Row {
        anchors.centerIn: parent
        spacing: 4

        Repeater {
            model: 5

            Rectangle {
                width: 10
                height: width
                radius: Math.min(width, height) / 2
                color: ThemeService.mdTertiary
            }
        }
    }
}
