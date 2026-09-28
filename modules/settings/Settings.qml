// very wip

import QtQuick
import QtQuick.Controls
import Quickshell
import "../../services"
import "../../"

FloatingWindow {
    id: root
    title: "qs-settings"
    implicitWidth: 700
    implicitHeight: 450

    Rectangle {
        anchors { fill: parent }
        color: ThemeService.mdSurface

        Rectangle {
            id: settingsBar
            anchors {
                top: parent.top; bottom: parent.bottom; left: parent.left
                leftMargin: 10; topMargin: 10; bottomMargin: 10
            }
            width: 140
            color: ThemeService.mdSurfaceContainerLow
            radius: Config.radiusXl

            Column {
                id: settingsTabsColumn
                anchors { fill: parent; margins: 10 }
                spacing: 10

                Text {
                    text: "\uf313"
                    color: ThemeService.mdPrimary
                    font { pixelSize: Config.type3xl}
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                SettingsTabButton {
                    title: "General"
                }
                SettingsTabButton {
                    title: "Theme"
                }
                SettingsTabButton {}
            }
        }
        Rectangle {
            id: settingsContent
            anchors {
                top: parent.top; bottom: parent.bottom; left: settingsBar.right; right: parent.right
                margins: 10
            }
            color: ThemeService.mdSurfaceContainerLow
            radius: Config.radiusLg

        }
    }

    component SettingsTabButton: Rectangle {
        id: settingsTabButton

        property string title: ""

        width: settingsTabsColumn.width
        height: 50
        radius: Config.radiusLg
        color: tabButtonHover.hovered
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdSecondary, 0.08))
           : ThemeService.mdSurfaceContainer

        HoverHandler {
            id: tabButtonHover
            cursorShape: Qt.PointingHandCursor
        }

        Behavior on color {
            ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
        }
        Text {
            anchors.centerIn: parent
            text: settingsTabButton.title
            color: ThemeService.mdOnSurface
            font { pixelSize: Config.typeXl; family: Config.fontFamily2; weight: 500}

            // Behavior on color {
            //     ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
            // }
        }
    }
}
