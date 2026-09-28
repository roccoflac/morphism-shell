import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../services"

PanelWindow {
    anchors { top: true; left: true; right: true }
    margins { top: 10 }
    implicitHeight: 400
    exclusiveZone: 40
    color: "transparent"

    LeftPill {
        id: leftPill
        anchors {
            left: parent.left
            leftMargin: 10
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
            rightMargin: 10
        }
    }
    mask: Region {
        Region { item: leftPill }
        Region { item: islandPill }
        Region { item: rightPill }
    }
}
