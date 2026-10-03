pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property alias notifications: server.trackedNotifications
    property var currentNotification: null

    NotificationServer {
        id: server
        bodySupported: true

        onNotification: (notification) => {
            notification.tracked = true;
            root.currentNotification = notification;
            dismissTimer.restart();

            console.log("New Notification from:", notification.appName, "-", notification.summary);
        }
    }

    Timer {
        id: dismissTimer
        interval: 3000
        repeat: false
        running: false
        onTriggered: {
            root.currentNotification = null;
        }
    }
}
