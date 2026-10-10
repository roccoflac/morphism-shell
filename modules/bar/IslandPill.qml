import QtQuick
import QtQuick.Controls
import Quickshell
import "../../services"
import "../../"

Rectangle {
    id: root

    readonly property bool isIslandOpen: islandExpanded
    readonly property bool isNotificationExpanded: activeNotification && notiExpanded
    readonly property bool isNotificationActive: activeNotification

    readonly property real islandExpandedWidth: 500
    readonly property real notiExpandedWidth: notiExpandColumn.implicitWidth + Config.pillPadding
    readonly property real notiActiveWidth: notiRow.implicitWidth + Config.pillPadding
    readonly property real idleWidth: idleRow.implicitWidth + Config.pillPadding

    readonly property real islandExpandedHeight: 300
    readonly property real notiExpandedHeight: notiExpandColumn.implicitHeight + Config.pillPadding
    // readonly property real notiActiveHeight: notiRow.implicitWidth + Config.pillPadding
    readonly property real idleHeight: Config.barHeight

    implicitWidth:
        isIslandOpen ? islandExpandedWidth :
        isNotificationExpanded  ? notiExpandedWidth :
        isNotificationActive ? notiActiveWidth :
        idleWidth

    implicitHeight:
        isIslandOpen ? islandExpandedHeight :
        isNotificationExpanded ? notiExpandedHeight :
        idleHeight

    radius: Config.barHeight / 2
    color: (clockHover.hovered || notiHover.hovered)
           ? Qt.tint(ThemeService.mdSurface, Qt.alpha(ThemeService.mdOnSurface, 0.08))
           : ThemeService.mdSurface
    clip: true

    property bool activeNotification: NotificationService.currentNotification !== null
    property bool islandExpanded: false
    property bool notiExpanded: false

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
                easing.overshoot: 0.5
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
            onTapped: NotificationService.currentNotification = null
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

                    source: NotificationService.currentNotification ? NotificationService.currentNotification.image : ""
                    height: dummyText.implicitHeight
                    width: height
                    fillMode: Image.PreserveAspectFit
                    opacity: source.toString() !== ""
                    visible: opacity > 0
                }

                // Image {
                //     id: notiExpandIcon
                //     anchors.verticalCenter: parent.verticalCenter

                //     source: NotificationService.currentNotification.appIcon
                //     height: dummyText.implicitHeight
                //     width: height
                //     fillMode: Image.PreserveAspectFit
                //     opacity: source.toString() !== ""
                //     visible: opacity > 0
                // }

                Text {
                    id: summaryText
                    width: 500
                    text: NotificationService.currentNotification ? NotificationService.currentNotification.summary : ""
                    font { pixelSize: Config.typeXl; family: Config.fontFamily2; weight: 500 }
                    color: ThemeService.mdOnSurface
                    wrapMode: Text.WordWrap
                    maximumLineCount: 2
                    elide: Text.ElideRight
                    // textFormat: Text.PlainText
                }
            }

            // need to fix fucked up monospace font
            Text {
                id: bodyText
                width: 500 // this is the max width it can be
                text: NotificationService.currentNotification ? NotificationService.currentNotification.body : ""
                font { pixelSize: Config.typeXl; family: Config.fontFamily2 }
                color: ThemeService.mdOnSurfaceVariant
                wrapMode: Text.WordWrap
                // textFormat: Text.RichText
            }
        }
    }
}
