pragma Singleton
import QtQuick // Required for Timer
import Quickshell
import Quickshell.Services.Notifications

Singleton {
    id: root

    property alias notifications: server.trackedNotifications
    property var currentNotification: null
    property bool hasActiveNotification: false

    NotificationServer {
        id: server
        bodySupported: true

        onNotification: (notification) => {
            notification.tracked = true;
            root.currentNotification = notification;
            root.hasActiveNotification = true;
            dismissTimer.restart();

            console.log("New Notification from:", notification.appName, "-", notification.summary);
        }
    }

    Timer {
        id: dismissTimer
        interval: 3000
        repeat: false
        onTriggered: {
            root.hasActiveNotification = false;
        }
    }
}
