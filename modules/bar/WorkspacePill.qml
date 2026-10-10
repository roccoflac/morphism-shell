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
                id: workspaceButton

                required property int index
                readonly property int wsId: index + 1
                readonly property bool isActive: Hyprland.focusedWorkspace?.id === wsId
                readonly property bool hasWindows: Hyprland.workspaces.values.some(ws => ws.id === wsId)
                readonly property real emptyWorkspaceAlpha: workspaceHover.hovered ? 0.7  : 0.45
                readonly property real hasWindowsAlpha: workspaceHover.hovered ? 1.0  : 0.85

                width: 15
                height: width
                radius: Math.min(width, height) / 2
                color:
                    isActive ? ThemeService.mdPrimary :
                    hasWindows ? Qt.alpha(ThemeService.mdSecondary, hasWindowsAlpha) :
                    Qt.alpha(ThemeService.mdSecondary, emptyWorkspaceAlpha)
                scale: workspacePress.pressed ? 1 : (workspaceHover.hovered ? 1.06 : 1.0)

                Behavior on scale {
                    NumberAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
                }
                Behavior on color {
                    ColorAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
                }

                HoverHandler { id: workspaceHover }
                TapHandler {
                    id: workspacePress
                    onTapped: Hyprland.dispatch('hl.dsp.focus({ workspace = "' + wsId + '" })')
                }
            }
        }
    }
}
