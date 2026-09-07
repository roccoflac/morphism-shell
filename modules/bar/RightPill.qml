import QtQuick
import Quickshell
import Quickshell.Services.UPower
import "../../services"
import "../../"

Rectangle {
    width: 90
    height: 40
    radius: height
    color: ThemeService.mdSurface

     Text {
        id: clockText
        anchors { centerIn: parent }
        text: `${Math.round(UPower.displayDevice.percentage * 100)}%`
        color: ThemeService.mdOnSurface
        font { pixelSize: Config.typeXl; family: Config.fontFamily2}

        Behavior on color {
            ColorAnimation { duration: Config.animNormal; easing.type: Config.easeEnter }
        }
    }

    HoverHandler {  
        id: batteryHover 
        cursorShape: Qt.PointingHandCursor    
    }
    TapHandler { id: batteryTap }
}