import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../../services"
import "../../"

Rectangle {
    id: root

    property bool isOpen: false

    width: 400
    height: launcherColumn.implicitHeight + 40
    color: ThemeService.mdSurface
    radius: Config.radiusLg
    opacity: isOpen ? 1.0 : 0.0
    visible: opacity > 0
    scale: opacity

    Behavior on opacity {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }

    ColumnLayout {
        id: launcherColumn
        anchors.fill: parent
        anchors.margins: Config.space200

        Item { Layout.fillHeight: true }
    }
}
