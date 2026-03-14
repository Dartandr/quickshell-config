import Quickshell
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick
import "../services/Colors"
import "../services/DateService"

PanelWindow {
    id: wallpaper
    property var thisScreen
    screen: thisScreen
    WlrLayershell.layer: WlrLayer.Bottom
    anchors.top: true
    anchors.right: true
    anchors.left: true
    anchors.bottom: true
    color: "transparent"
    implicitHeight: thisScreen.height - 40
    implicitWidth: thisScreen.width
    ClippingWrapperRectangle{
        radius: 20
        height: wallpaper.implicitHeight
        width: wallpaper.implicitWidth
        Image{
            height: wallpaper.implicitHeight
            width: wallpaper.implicitWidth
            source: wallpaper.thisScreen.name.includes("DP") ? "/home/dartandr/Pictures/8.jpg": "/home/dartandr/Pictures/7.jpg"
            fillMode: Image.PreserveAspectCrop
            cache: false
        }
    }
    Column{
        id: wallpaperTime
        property var curentTime: DateService.dateWallpaper.split(",")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 40
        width: 500
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text:wallpaperTime.curentTime[0]
            font.pixelSize: 80
            font.weight: 500
            color: Colors.foreground
        }
        Text{
            anchors.horizontalCenter: parent.horizontalCenter
            text:wallpaperTime.curentTime[1]
            font.pixelSize: 30
            font.weight: 500
            color: Colors.foreground
        }



    }

}