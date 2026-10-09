import QtQuick
import Quickshell
import "../../../"
import "../../../services"

ScrollView {
    anchors.fill: parent
    clip: true

    Column {
        anchors.fill: parent
        spacing: 10

        Repeater {
            model: 4

            Rectangle {
                height: 100
                width: 100
                color: ThemeService.mdSurfaceContainerLow
            }
        }
    }
}
