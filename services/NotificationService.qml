pragma Singleton
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
            root.currentNotification = notification; // Update the reference directly
            console.log("New Notification from:", notification.appName, "-", notification.summary);
        }
    }
}
