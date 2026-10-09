import QtQuick
import Quickshell
import Quickshell.Hyprland
import "../../services"
import "../../"

Rectangle {
    width: workspaceRow.implicitWidth + Config.pillPadding
    height: Config.barHeight
    radius: Math.min(width, height) / 2
    color: ThemeService.mdSurface

    Row {
        id: workspaceRow
        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: Config.workspaceAmount

            Rectangle {
                required property int index
                readonly property int wsId: index + 1
                readonly property bool isActive: Hyprland.focusedWorkspace?.id === wsId
                readonly property bool hasWindows: Hyprland.workspaces.values.some(ws => ws.id === wsId)

                width: 15
                height: width
                radius: Math.min(width, height) / 2
                color: isActive
                        ? ThemeService.mdPrimary
                        : hasWindows
                            ? workspaceHover.hovered ? ThemeService.mdSecondary: (Qt.alpha(ThemeService.mdSecondary, 0.85))
                            : workspaceHover.hovered ? Qt.alpha(ThemeService.mdSecondary, 0.7) : (Qt.alpha(ThemeService.mdSecondary, 0.45)) // i need to clean up this readability later
                scale: workspacePress.pressed ? 1 : (workspaceHover.hovered ? 1.06 : 1.0)

                Behavior on scale {
                    NumberAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
                }
                Behavior on color {
                    ColorAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
                }

                HoverHandler { id: workspaceHover }
                TapHandler { id: workspacePress; onTapped: Hyprland.dispatch('hl.dsp.focus({ workspace = "' + wsId + '" })') }
            }
        }
    }
}
