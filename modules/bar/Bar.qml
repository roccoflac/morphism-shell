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

    NotiPill {
        id: notiPill
        anchors {
            left: parent.left
            leftMargin: Config.barSideMargin
        }
    }

    IslandPill {
        id: islandPill
        anchors { horizontalCenter: parent.horizontalCenter }
    }

    PowerPill {
        id: powerPill
        anchors {
            right: parent.right
            rightMargin: Config.barSideMargin
        }
    }
    mask: Region {
        Region { item: notiPill }
        Region { item: islandPill }
        Region { item: powerPill }
    }

    HyprlandFocusGrab {
        id: grab
        windows: [root]
        active: notiPill.notiExpanded || islandPill.islandExpanded || powerPill.batteryExpanded
        onCleared: {
            notiPill.notiExpanded = false
            islandPill.islandExpanded = false
            powerPill.batteryExpanded = false
        }
    }
}
