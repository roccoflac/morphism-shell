import QtQuick
import QtQuick.Controls
import Quickshell
import "../../services"
import "../../"

Rectangle {
    id: root

    implicitWidth: {
        if (islandExpanded) return 500
        if (activeNotification && notiExpanded) return notiExpandColumn.implicitWidth + 40
        if (activeNotification) return notiRow.implicitWidth + 40
        return idleRow.implicitWidth + 40
    }

    implicitHeight: {
        if (islandExpanded) return 300
        if (activeNotification && notiExpanded) return notiExpandColumn.implicitHeight + 40
        return Config.barHeight
    }

    radius: Config.barHeight / 2
    color: (clockHover.hovered || notiHover.hovered)
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdOnSurface, 0.08))
           : ThemeService.mdSurface
    clip: true

    property bool activeNotification: NotificationService.currentNotification !== null
    property bool islandExpanded: false
    property bool notiExpanded: false
    // required property var notificationData
    // readonly property int expandedHeight: 500 // do this some other time

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

    Item {
        id: idleItem
        anchors.fill: parent

        opacity: (!root.activeNotification && !root.islandExpanded) ? 1 : 0
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

        opacity: (root.activeNotification && !root.islandExpanded && !root.notiExpanded) ? 1 : 0
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

        HoverHandler { id: notiHover }
        TapHandler {
            id: notiTap;
            onTapped: root.notiExpanded = !root.notiExpanded
        }

        TapHandler {
            acceptedButtons: Qt.RightButton
            onTapped: NotificationService.currentNotification = null
        }

        Row {
            id: notiRow
            anchors {
                centerIn: parent
            }
            spacing: 10

            Text {
                anchors { verticalCenter: parent.verticalCenter }
                text: NotificationService.currentNotification ? NotificationService.currentNotification.summary : ""
                font { pixelSize: Config.typeXl; family: Config.fontFamily2 }
                color: ThemeService.mdOnSurface
            }
        }
    }

    Item {
        id: notiExpandedItem
        anchors.fill: parent

        opacity: (root.activeNotification && !root.islandExpanded && root.notiExpanded) ? 1 : 0
        scale: opacity
        visible: opacity > 0

        Behavior on scale {
            NumberAnimation {
                duration: Config.animNormal
                easing.type: Easing.OutBack
                easing.overshoot: 1
            }
        }

        Behavior on opacity {
            NumberAnimation { duration: Config.animVeryFast; easing.type: Config.easeEnter }
        }

        HoverHandler { id: notiExpandedHover }
        TapHandler {
            id: notiExpandedTap;
            onTapped: root.notiExpanded = !root.notiExpanded
        }

        TapHandler {
            acceptedButtons: Qt.RightButton
            onTapped: NotificationService.currentNotification = null //
        }

        Column {
            id: notiExpandColumn
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
                topMargin: 16
            }
            spacing: 10

            Text { //
                id: dummyText
                text: "1\n2"
                font { pixelSize: Config.typeXl; family: Config.fontFamily2 }
                visible: false
            }

            Row {
                id: notiExpandRow
                spacing: 10

                Image {
                    id: notiExpandImage
                    anchors.verticalCenter: parent.verticalCenter

                    source: NotificationService.currentNotification ? NotificationService.currentNotification.image : ""
                    height: dummyText.implicitHeight
                    width: height
                    fillMode: Image.PreserveAspectFit
                    opacity: source.toString() !== ""
                    visible: opacity > 0
                }

                Text {
                    width: 500
                    text: NotificationService.currentNotification ? NotificationService.currentNotification.summary : ""
                    font { pixelSize: Config.typeXl; family: Config.fontFamily2 }
                    color: ThemeService.mdOnSurface
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                    elide: Text.ElideRight
                    // textFormat: Text.MarkdownText
                }
            }

            Text {
                width: 500 // this is the max width it can be
                text: NotificationService.currentNotification ? NotificationService.currentNotification.body : ""
                font { pixelSize: Config.typeXl; family: Config.fontFamily2 }
                color: ThemeService.mdOnSurface
                wrapMode: Text.WordWrap
                // textFormat: Text.MarkdownText
            }
        }
    }
}
