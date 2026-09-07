pragma Singleton
import QtQuick
import Quickshell

Singleton {
    // readonly property bool isDark: true

    readonly property color mdBackground: "#0d1418"
    readonly property color mdOnBackground: "#dce3e9"
    
    readonly property color mdPrimary: "#dec663"
    readonly property color mdOnPrimary: "#3a3000"
    readonly property color mdPrimaryContainer: "#544600"
    readonly property color mdOnPrimaryContainer: "#fbe27c"

    readonly property color mdSecondary: "#d3bfe6"
    readonly property color mdOnSecondary: "#382a49"
    readonly property color mdSecondaryContainer: "#4f4061"
    readonly property color mdOnSecondaryContainer: "#eedbff"

    readonly property color mdTertiary: "#97ceec"
    readonly property color mdOnTertiary: "#003548"
    readonly property color mdTertiaryContainer: "#064c66"
    readonly property color mdOnTertiaryContainer: "#c2e8ff"

    readonly property color mdError: "#ffb4ab"
    readonly property color mdOnError: "#690005"
    readonly property color mdErrorContainer: "#93000a"
    readonly property color mdOnErrorContainer: "#ffdad6"

    readonly property color mdSurface: "#0d1418"
    readonly property color mdOnSurface: "#dce3e9"
    readonly property color mdSurfaceVariant: "#3c4950"
    readonly property color mdOnSurfaceVariant: "#bbc8d2"

    readonly property color mdSurfaceDim: "#0d1418"
    readonly property color mdSurfaceBright: "#333a3f"

    readonly property color mdSurfaceContainerLowest: "#080f13"
    readonly property color mdSurfaceContainerLow: "#151d21"
    readonly property color mdSurfaceContainer: "#192125"
    readonly property color mdSurfaceContainerHigh: "#242b2f"
    readonly property color mdSurfaceContainerHighest: "#2f363a"

    readonly property color mdOutline: "#85939b"
    readonly property color mdOutlineVariant: "#3c4950"

    readonly property color mdShadow: "#000000"
    readonly property color mdScrim: "#000000"
    readonly property color mdInverseSurface: "#dce3e9"
    readonly property color mdInverseOnSurface: "#2a3136"
    readonly property color mdInversePrimary: "#6f5d00"
}
