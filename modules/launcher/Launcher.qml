import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../services"
import "../../"

Rectangle {
    id: launcherRoot
    property bool isOpen: false

    width: 500
    height: 350
    color: ThemeService.mdSurface
    radius: Config.radiusLg
    opacity: isOpen ? 1.0 : 0.0
    visible: opacity > 0
    // scale: opacity

    Behavior on opacity {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: Config.space200

        Item { Layout.fillHeight: true }
    }
}
