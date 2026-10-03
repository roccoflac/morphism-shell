import QtQuick
import QtQuick.Controls
import Quickshell
import "../../services"
import "../../"

Rectangle {
    id: root
    implicitWidth: idleRow.implicitWidth + 40
    implicitHeight: Config.barHeight
    radius: Config.barHeight / 2
    color: (clockHover.hovered || notiHover.hovered)
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdOnSurface, 0.08))
           : ThemeService.mdSurface
    clip: true

    property bool notiReceived: NotificationService.currentNotification !== null
    property bool islandExpanded: false
    required property var notificationData

    Behavior on implicitWidth {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on implicitHeight {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on radius {
        NumberAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }
    Behavior on color {
        ColorAnimation { duration: Config.animSlow; easing.type: Config.easeEnter }
    }

    states: [
        State {
            name: "notiState"
            when: root.notiReceived && !root.islandExpanded

            PropertyChanges {
                target: root
                implicitWidth: notiRow.implicitWidth + 40
            }

            PropertyChanges {
                target: idleItem
                opacity: 0
            }

            PropertyChanges {
                target: notiItem
                opacity: 1
            }
        },

        State {
            name: "expandedState"
            when: root.islandExpanded

            PropertyChanges {
                target: root
                implicitWidth: 500
                implicitHeight: 300
            }
            PropertyChanges { target: idleItem; opacity: 0 }
            PropertyChanges { target: notiItem; opacity: 0 }
        }
    ]

    Item {
        id: idleItem
        anchors.fill: parent

        opacity: 1
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: Config.animVeryFast; easing.type: Config.easeEnter }
        }

        HoverHandler { id: clockHover }
        TapHandler { id: clockTap; onTapped: islandExpanded = !islandExpanded}

        SystemClock {
            id: clock
            precision: SystemClock.Minutes
        }

        Row {
            id: idleRow
            anchors { centerIn: parent }

            Text {
                anchors { verticalCenter: parent.verticalCenter }
                text: clockHover.hovered ? Qt.formatDateTime(clock.date, "ddd, MMM d") : Qt.formatDateTime(clock.date, "hh:mm ap")
                color: ThemeService.mdOnSurface
                font { pixelSize: Config.typeXl; family: Config.fontFamily2 }
            }
        }
    }

    Item {
        id: notiItem
        anchors.fill: parent

        opacity: 0
        visible: opacity > 0

        Behavior on opacity {
            NumberAnimation { duration: Config.animVeryFast; easing.type: Config.easeEnter }
        }

        HoverHandler { id: notiHover }
        TapHandler { id: notiTap; onTapped: islandExpanded = !islandExpanded}

        Row {
            id: notiRow
            anchors { centerIn: parent }

            Text {
                anchors { verticalCenter: parent.verticalCenter }
                text: NotificationService.currentNotification ? NotificationService.currentNotification.summary : ""
                font { pixelSize: Config.typeXl; family: Config.fontFamily2 }
                color: ThemeService.mdOnSurface
            }
        }
    }
}
