pragma Singleton
import Quickshell
import QtQuick

Singleton {
    id: root

    // -- Fonts -- \\
    property string fontFamily: "Lexend"
    property string fontFamily2: "Figtree"

    // -- Type Ramp -- //
    readonly property int typeXs: 8
    readonly property int typeSm: 10
    readonly property int typeMd: 12
    readonly property int typeLg: 15
    readonly property int typeXl: 19
    readonly property int type2xl: 24
    readonly property int type3xl: 30
    readonly property int type4xl: 50

    // -- Radius -- \\
    readonly property int radiusXs: 6
    readonly property int radiusSm: 10
    readonly property int radiusMd: 12
    readonly property int radiusLg: 16
    readonly property int radiusXl: 20
    readonly property int radius2xl: 24
    readonly property int radiusInf: 999

    // -- Animation Durations -- //
    readonly property var durations: QtObject {
        readonly property int short1: 50
        readonly property int short2: 100
        readonly property int short3: 150
        readonly property int short4: 200

        readonly property int medium1: 250
        readonly property int medium2: 300
        readonly property int medium3: 350
        readonly property int medium4: 400

        readonly property int long1: 450
        readonly property int long2: 500
        readonly property int long3: 550
        readonly property int long4: 600
    }

    // -- Animation Curves \\
    readonly property var emphasized: Easing.bezierCurve([0.2, 0.0, 0, 1.0])
    readonly property var emphasizedDecelerate: Easing.bezierCurve([0.05, 0.7, 0.1, 1.0])
    readonly property var emphasizedAccelerate: Easing.bezierCurve([0.3, 0.0, 0.8, 0.15])

    readonly property var standard: Easing.bezierCurve([0.2, 0.0, 0, 1.0])
    readonly property var standardDecelerate: Easing.bezierCurve([0, 0, 0, 1])
    readonly property var standardAccelerate: Easing.bezierCurve([0.3, 0, 1, 1])

    // -- Spring Animations -- //
    readonly property var fastSpatial: QtObject {
        readonly property real spring: 3.84
        readonly property real damping: 0.4
        readonly property real mass: 0.3
        readonly property real epsilon: 0.1
    }

    readonly property var defaultSpatial: QtObject {
        readonly property real spring: 4.86
        readonly property real damping: 0.4
        readonly property real mass: 0.8
        readonly property real epsilon: 0.1
    }

    readonly property var slowSpatial: QtObject {
        readonly property real spring: 3.2
        readonly property real damping: 0.36
        readonly property real mass: 1.0
        readonly property real epsilon: 0.1
    }

    readonly property var fastEffects: QtObject {
        readonly property real spring: 3.04
        readonly property real damping: 0.1
        readonly property real mass: 0.05
        readonly property real epsilon: 0.005
    }

    readonly property var defaultEffects: QtObject {
        readonly property real spring: 2.56
        readonly property real damping: 0.13
        readonly property real mass: 0.1
        readonly property real epsilon: 0.005
    }

    readonly property var slowEffects: QtObject {
        readonly property real spring: 3.84
        readonly property real damping: 0.27
        readonly property real mass: 0.3
        readonly property real epsilon: 0.005
    }

    // -- Legacy Animations -- //
    readonly property int animVeryFast: 75
    readonly property int animFast: 120
    readonly property int animNormal: 180
    readonly property int animSlow: 265
    readonly property int animVerySlow: 400

    readonly property int easeEnter: Easing.OutCubic
    readonly property int easeExit: Easing.InCubic

    // -- Bar Config -- \\
    readonly property int barSideMargin: 10
    readonly property int barHeight: 40
    readonly property int workspaceAmount: 5

    // -- Screenshot Directory -- //
    readonly property var screenshots: ({
        saveDirectory: "$HOME/Pictures/Screenshots"
    })
    // -- Battery -- \\
    readonly property bool showPercentage: true

    // -- Notifications -- //
    readonly property int notificationLowTimeout: 2000
    readonly property int notificationNormalTimeout: 3000
    readonly property int notificationCriticalTimeout: 5000

    // -- qBittorrent WebUI -- \\
    readonly property var qbt: ({
        host: "http://localhost:8080",
        user: "admin",
        password: "W2ut$rlq3txKkM" // pass is stored in plain text idrc
    })

    // -- VPN -- //
    readonly property var vpn: ({ country: "CH" })
}
