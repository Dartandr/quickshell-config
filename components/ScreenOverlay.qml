import Quickshell
import Quickshell.Wayland
import QtQuick
import "../services/Colors"

Instantiator {
    id: initRoot
    model: Quickshell.screens
    ShellRoot{
        id: root
        property var curentScreen: modelData

        PanelWindow {
            id: backgroundFill
            screen: root.curentScreen
            WlrLayershell.layer: WlrLayer.Background
            anchors.top: true
            anchors.right: true
            anchors.left: true
            anchors.bottom: true
            color: "black"
            Rectangle{
                anchors.fill: parent
                color: Colors.main
                bottomLeftRadius: 20
                bottomRightRadius: 20
            }
        }

        Wallpaper{
            thisScreen: root.curentScreen
        }

        Bar{
            thisScreen: root.curentScreen
        }
    }
}