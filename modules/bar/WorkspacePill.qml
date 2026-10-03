import QtQuick
import Quickshell
import "../../services"
import "../../"

Rectangle {
    width: workspaceRow.implicitWidth + 40
    height: Config.barHeight
    radius: Math.min(width, height) / 2
    color: ThemeService.mdSurface

    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: 5

            Rectangle {
                id: workspaceDot
                width: 15
                height: width
                radius: Math.min(width, height) / 2
                color: ThemeService.mdTertiary
                scale: workspaceHover.hovered ? 1.56 : 1.0

                HoverHandler { id: workspaceHover; cursorShape: Qt.PointingHandCursor }
            }
        }
    }
}
