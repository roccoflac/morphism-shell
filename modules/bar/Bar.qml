import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../../services"
import "../../"

Item {
    id: barRoot
    height: Config.barHeight

    property alias notiPill: notiPill
    property alias workspacePill: workspacePill
    property alias islandPill: islandPill
    property alias popupPill: popupPill
    property alias powerPill: powerPill

    Row {
        anchors {
            left: parent.left
            leftMargin: Config.barSideMargin
        }
        spacing: 10

        NotiPill {
            id: notiPill
        }

        WorkspacePill {
            id: workspacePill
        }
    }

    IslandPill {
        id: islandPill
        anchors { horizontalCenter: parent.horizontalCenter }
    }

    Row {
        anchors {
            right: parent.right
            rightMargin: Config.barSideMargin
        }
        spacing: 10

        PopupPill {
            id: popupPill
        }

        PowerPill {
            id: powerPill
        }
    }
}
