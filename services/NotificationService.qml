pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications
import "../"

Singleton {
    id: root

    property alias notifications: server.trackedNotifications
    property var currentNotification: null

    NotificationServer {
        id: server
        bodySupported: true
        imageSupported: true
        bodyMarkupSupported: true
        keepOnReload: false // keep it true while testing

        onNotification: (notification) => {
            notification.tracked = true;
            root.currentNotification = notification;
            dismissTimer.restart();

            console.log("New Notification from:", notification.appName, "-", notification.summary);
        }
    }

    Timer {
        id: dismissTimer
        interval: Config.notificationNormalTimeout // + 100000
        repeat: false
        running: false
        onTriggered: {
            root.currentNotification = null;
        }
    }
}
