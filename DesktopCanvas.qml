import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import "modules/bar"
import "modules/launcher"
import "modules/settings"

PanelWindow {
    id: root
    anchors { top: true; left: true; right: true }
    implicitHeight: screen ? screen.height : 1080
    exclusiveZone: Config.barHeight + Config.barMargin
    color: "transparent"

    Bar {
        id: desktopBar
    }

    mask: Region {
        Region { item: desktopBar.notiPill }
        Region { item: desktopBar.workspacePill }
        Region { item: desktopBar.islandPill }
        Region { item: desktopBar.popupPill }
        Region { item: desktopBar.powerPill }
    }

    HyprlandFocusGrab {
        id: grab
        windows: [root]
        active: {
            desktopBar.notiPill.notiExpanded ||
            desktopBar.islandPill.islandExpanded ||
            desktopBar.popupPill.networkExpanded ||
            desktopBar.popupPill.audioExpanded ||
            desktopBar.powerPill.batteryExpanded
        }
        onCleared: {
            desktopBar.notiPill.notiExpanded = false
            desktopBar.islandPill.islandExpanded = false
            desktopBar.popupPill.networkExpanded = false
            desktopBar.popupPill.audioExpanded = false
            desktopBar.powerPill.batteryExpanded = false
        }
    }
}
