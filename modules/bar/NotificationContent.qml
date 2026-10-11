import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "../../services"
import "../../"

ScrollView {
    id: scrollView
    anchors.fill: parent
    anchors.margins: Config.space200
    clip: true

    Column {
        width: scrollView.availableWidth
        spacing: Config.space150

        Repeater {
            model: NotificationService.notifications

            Rectangle {
                id: notificationCard
                width: parent.width
                height: notificationCardColumn.implicitHeight + (Config.space150 * 2)
                radius: Config.radiusLg
                border { width: 1; color: ThemeService.mdSubtleOutlineVariant }
                color: ThemeService.mdSurfaceContainerLow

                // thing
                // Rectangle {
                //     id: notificationThing
                //     width: 5
                //     height: parent.height
                //     color: ThemeService.mdPrimary
                //     topLeftRadius: Config.radiusLg
                //     bottomLeftRadius: Config.radiusLg
                // }

                Column {
                    id: notificationCardColumn
                    anchors {
                        fill: parent
                        margins: Config.space150
                        // leftMargin: Config.space150
                        // rightMargin: Config.space150
                    }
                    spacing: Config.space100

                    Text {
                        id: notiSummary
                        width: parent.width
                        text: modelData ? modelData.summary : "No Title"
                        font { pixelSize: Config.typeLg; family: Config.fontFamily2 }
                        color: ThemeService.mdOnSurface
                        elide: Text.ElideRight
                    }

                    Text {
                        id: notiBody
                        width: parent.width // this is the max width it can be
                        text: modelData ? modelData.body : ""
                        font { pixelSize: Config.typeMd; family: Config.fontFamily2 }
                        color: ThemeService.mdOnSurfaceVariant
                        wrapMode: Text.WordWrap
                        // textFormat: Text.RichText
                    }
                }
            }
        }
    }
}
