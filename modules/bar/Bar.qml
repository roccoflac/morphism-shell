import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../services"

PanelWindow {
    anchors { top: true; left: true; right: true }
    margins { top: 10 }
    implicitHeight: 40
    // exclusiveZone: 40
    color: "transparent"

    LeftPill {
        anchors {
            left: parent.left
            leftMargin: 10
        }
    }
    CenterPill {
        anchors { horizontalCenter: parent.horizontalCenter }
    }

    RightPill {
        anchors {
            right: parent.right
            rightMargin: 10
        }
    }
}
