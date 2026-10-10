import QtQuick
import Quickshell
import "../../services"
import "../../"

Rectangle {
    id: root

    readonly property int expandedWidth: 320
    readonly property int collapsedWidth: Config.barHeight
    readonly property int expandedHeight: 400
    readonly property int collapsedHeight: Config.barHeight

    width: notiExpanded ? expandedWidth : collapsedWidth
    height: notiExpanded ? expandedHeight : collapsedHeight
    radius: notiExpanded ? Config.radiusLg : 20 // considered Math.min(width, height) / 2 so its guarenteed to be max radius but its a messy animation
    color: notiHover.hovered
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
        ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
    }

    property bool notiExpanded: false

    Item {
        anchors.fill: parent
        opacity: notiExpanded ? 0 : 1
        scale: opacity
        visible: opacity > 0

        Behavior on scale {
            NumberAnimation {
                duration: Config.animSlow
                easing.type: Easing.OutBack
                easing.overshoot: 1
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: Config.animVeryFast; easing.type: Config.easeEnter }
        }

        HoverHandler {
            id: notiHover
            cursorShape: Qt.PointingHandCursor
            onHoveredChanged: if (hovered) notiAnimation.start() // maybe make this happen on notification received instead of hover?
        }

        TapHandler {
            onTapped: notiExpanded = !notiExpanded
        }

        Text {
            id: notiIcon
            anchors.centerIn: parent
            text: "\uf0f3" // fa-bell
            font { pixelSize: Config.type2xl }
            color: ThemeService.mdPrimary
            transformOrigin: Item.Top

            SequentialAnimation {
                id: notiAnimation

                NumberAnimation { target: notiIcon; property: "rotation"; from: 0; to: 14; duration: 100; easing.type: Easing.OutQuad }
                NumberAnimation { target: notiIcon; property: "rotation"; from: 14; to: -10; duration: 150; easing.type: Easing.InOutSine }
                NumberAnimation { target: notiIcon; property: "rotation"; from: -10; to: 5; duration: 130; easing.type: Easing.InOutSine }
                NumberAnimation { target: notiIcon; property: "rotation"; from: 5; to: -3; duration: 110; easing.type: Easing.InOutSine }
                NumberAnimation { target: notiIcon; property: "rotation"; from: -3; to: 0; duration: 80; easing.type: Easing.InQuad }
            }
        }
    }

    Loader {
        id: contentLoader
        anchors.fill: parent

        active: notiExpanded

        opacity: notiExpanded ? 1 : 0
        visible: opacity > 0
        // scale: opacity
        source: "NotificationContent.qml"

        Behavior on opacity {
            NumberAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
        }
    }
}
