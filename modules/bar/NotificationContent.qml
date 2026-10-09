import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "../../services"
import "../../"

ScrollView {
    anchors.fill: parent
    clip: true

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 16
        spacing: 12

        Repeater {
            model: 6

            Rectangle {
                Layout.fillWidth: true
                height: 80
                color: ThemeService.mdSurfaceContainerLow
                radius: Config.radiusLg
            }
        }
    }
}
