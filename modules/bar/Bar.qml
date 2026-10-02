import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../services"
import "../../"

PanelWindow {
    id: root
    anchors { top: true; left: true; right: true }
    margins { top: 10 } // consider doing side margins here instead of on the pills?
    implicitHeight: 400
    exclusiveZone: Config.barHeight
    color: "transparent"

    LeftPill {
        id: leftPill
        anchors {
            left: parent.left
            leftMargin: Config.barSideMargin
        }
    }

    IslandPill {
        id: islandPill
        anchors { horizontalCenter: parent.horizontalCenter }
    }

    RightPill {
        id: rightPill
        anchors {
            right: parent.right
            rightMargin: Config.barSideMargin
        }
    }
    mask: Region {
        Region { item: leftPill }
        Region { item: islandPill }
        Region { item: rightPill }
    }

    HyprlandFocusGrab {
        id: grab
        windows: [root]
        active: leftPill.notiExpanded || islandPill.islandExpanded || rightPill.batteryExpanded
        onCleared: {
            leftPill.notiExpanded = false
            islandPill.islandExpanded = false
            rightPill.batteryExpanded = false
        }
    }
}
