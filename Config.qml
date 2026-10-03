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

    // -- Animations -- //
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

    // -- Screenshot Directory -- //
    readonly property var screenshots: ({
        saveDirectory: "$HOME/Pictures/Screenshots"
    })
    // -- Battery -- \\
    readonly property var battery: ({
        showPercentage: true
    })

    // -- Notifications -- //

    // -- qBittorrent WebUI -- \\
    readonly property var qbt: ({
        host: "http://localhost:8080",
        user: "admin",
        password: "W2ut$rlq3txKkM" // pass is stored in plain text idrc
    })

    // -- VPN -- //
    readonly property var vpn: ({ country: "CH" })
}
