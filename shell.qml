import Quickshell
import QtQuick
import Quickshell.Hyprland

ShellRoot {
    id: shell

    DesktopCanvas {
        id: mainCanvas
    }

    GlobalShortcut {
        name: "launcherToggle"
        description: "Toggles launcher"
        onPressed: mainCanvas.appLauncher.isOpen = !mainCanvas.appLauncher.isOpen
    }
}
