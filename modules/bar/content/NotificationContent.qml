import QtQuick
import Quickshell
import "../../../"
import "../../../services"

Repeater {
    model: 4

    Rectangle {
        height: 100
        width: 100
        color: ThemeService.mdSurfaceContainer
    }

}
