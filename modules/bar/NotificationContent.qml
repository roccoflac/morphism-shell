import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "../../services"
import "../../"

ScrollView {
    anchors.fill: parent
    clip: true
    anchors.margins: Config.space200
    ScrollBar.vertical.policy: ScrollBar.AlwaysOff

    ColumnLayout {
        anchors.fill: parent
        spacing: Config.space150

        Repeater {
            model: 6

            Rectangle {
                id: notificationCard
                Layout.fillWidth: true
                height: 100
                radius: Config.radiusLg
                border { width: 1; color: ThemeService.mdSubtleOutlineVariant }
                color: ThemeService.mdSurfaceContainerLow
                // bottomRightRadius: Config.radiusLg
                // topRightRadius: Config.radiusLg

                // Rectangle {
                //     id: notificationThing
                //     width: 5
                //     height: notificationCard.height
                //     color: ThemeService.mdPrimary
                //     bottomLeftRadius: Config.radiusLg
                //     topLeftRadius: Config.radiusLg
                // }
            }
        }
    }
}
