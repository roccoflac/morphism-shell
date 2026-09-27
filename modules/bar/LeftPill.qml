import QtQuick
import Quickshell
import "../../services"
import "../../"

Rectangle {
    width: 40
    height: width
    radius: width
    color: ThemeService.mdSurface

    HoverHandler {
        id: notiHover
        enabled: !expanded
        cursorShape: Qt.PointingHandCursor
        onHoveredChanged: if (hovered) notiAnimation.start() // maybe make this happen on notification received instead of hover?
    }

    Text {
        id: notiIcon
        anchors.centerIn: parent
        text: "\uf0f3"
        color: ThemeService.mdPrimary
        transformOrigin: Item.Top
        font {
            family: "Symbols Nerd Font"
            pixelSize: Config.type2xl
        }

        SequentialAnimation {
            id: notiAnimation

            NumberAnimation { target: notiIcon; property: "rotation"; from: 0; to: 15; duration: 100; easing.type: Easing.OutQuad }
            NumberAnimation { target: notiIcon; property: "rotation"; from: 15; to: -12; duration: 150; easing.type: Easing.InOutSine }
            NumberAnimation { target: notiIcon; property: "rotation"; from: -12; to: 6; duration: 130; easing.type: Easing.InOutSine }
            NumberAnimation { target: notiIcon; property: "rotation"; from: 6; to: -3; duration: 110; easing.type: Easing.InOutSine }
            NumberAnimation { target: notiIcon; property: "rotation"; from: -3; to: 0; duration: 80; easing.type: Easing.InQuad }
        }
    }
}
