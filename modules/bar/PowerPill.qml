import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "../../services"
import "../../"

Rectangle {
    id: root

    property bool batteryExpanded: false

    readonly property var battery: UPower.displayDevice
    readonly property bool batteryReady: battery.ready
    readonly property real batteryPercentage: batteryReady ? battery.percentage : 0

    readonly property int expandedWidth: 300
    readonly property int collapsedWidth: batteryText.implicitWidth + Config.pillPadding
    readonly property int expandedHeight: 400
    readonly property int collapsedHeight: Config.barHeight

    width: batteryExpanded ? expandedWidth : collapsedWidth
    height: batteryExpanded ? expandedHeight : collapsedHeight
    radius: batteryExpanded ? Config.radiusLg : Config.barHeight / 2
    color: batteryHover.hovered
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdOnSurface, 0.08))
           : ThemeService.mdSurface
    clip: true

    Behavior on width {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on height {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on radius {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on color {
        ColorAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }

    function batteryTextValue() {
        if (!Config.showPercentage)
            return "\uf011";

        if (!batteryReady)
            return "--";

        return `${Math.round(batteryPercentage * 100)}%`;
    }

    function batteryTextColor() {
        if (!batteryReady)
            return ThemeService.mdOnSurface;

        if (battery.state === 1 || battery.state === 4)
            return ThemeService.mdCharging;

        if (batteryPercentage <= 0.20)
            return ThemeService.mdError;

        if (batteryPercentage <= 0.30)
            return ThemeService.mdWarning;

        return ThemeService.mdOnSurface;
    }

    Item {
        anchors.fill: parent
        opacity: batteryExpanded ? 0 : 1
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: Config.animVeryFast; easing.type: Config.easeEnter }
        }

        HoverHandler {
            id: batteryHover
            cursorShape: Qt.PointingHandCursor
        }
        TapHandler {
            onTapped: batteryExpanded = !batteryExpanded
        }

        Text {
            id: batteryText
            anchors.centerIn: parent

            text: root.batteryTextValue()
            color: root.batteryTextColor()
            font { pixelSize: Config.typeXl; family: Config.fontFamily2 }

            Behavior on color {
                ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
            }
        }
    }
}
