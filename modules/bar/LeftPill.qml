import QtQuick
import Quickshell
import "../../services"
import "../../"

Rectangle {
    width: 40
    height: width
    radius: width
    color: notiHover.hovered
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdOnSurface, 0.08))
           : ThemeService.mdSurface
    clip: true

    Behavior on color {
        ColorAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }

    Item {
        anchors.fill: parent

        HoverHandler {
            id: notiHover
            enabled: !expanded
            cursorShape: Qt.PointingHandCursor
            onHoveredChanged: if (hovered) notiAnimation.start() // maybe make this happen on notification received instead of hover?
        }

        TapHandler {
            onTapped: notiExpanded = !noitExpanded
        }

        Text {
            id: notiIcon
            anchors.centerIn: parent
            text: "\uf0f3" // fa-bell
            color: ThemeService.mdPrimary
            font { family: Config.fontIcons; pixelSize: Config.type2xl }
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
}
