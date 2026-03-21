import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import "../services/Colors"
import "../services/HyprlandService"
import "../config/config.js" as Config

PanelWindow {
    id: barPanel
    property var thisScreen
    screen: thisScreen
    WlrLayershell.layer: WlrLayer.Top
    anchors.top: true
    anchors.right: true
    anchors.left: true
    implicitHeight: 40
    color: "transparent"
    Rectangle{
        anchors.fill: parent
        color: Colors.main
        topLeftRadius: 20
        topRightRadius: 20
        height: parent.implicitHeight

        //leftElements
        Column{
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: 30
            Text{
                text: HyprlandService.currentApp ? HyprlandService.currentApp : "Desktop"
                font.pixelSize: 14
                color: Colors.foregroundDark
            }
            Text{
                text: HyprlandService.currentWindowName ? HyprlandService.currentWindowName : `Workspace ${Hyprland.focusedWorkspace.name}`
                font.pixelSize: 14
                color: Colors.foreground
                font.weight: 500
            }
        }

        // center Elements
        Row{
            anchors.centerIn: parent
            spacing: 25

            BarPerformance {}

            Row {
                spacing: 5
                // Workspaces initialization
                Repeater {
                    model: Hyprland.workspaces

                    Rectangle {
                        id: workspace
                        width: 30
                        height: 30
                        color: modelData.urgent ? Colors.warning : modelData.focused ? Colors.accent : Colors.background
                        visible: modelData.monitor.name === barPanel.screen.name && !modelData.name.includes("special") 
                        radius: 15
                        Text{
                            anchors.centerIn: parent
                            text: modelData.name
                            color: Colors.foreground
                            font.weight: 700
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: () => {
                                           Hyprland.dispatch(`workspace ${modelData.name}`)
                                       }
                        }
                    }
                }

            }
            BarDate{}
        }

        // right elements
        Row{
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.verticalCenter: parent.verticalCenter
            spacing: 5

            Lang{}

            Loader {
                anchors.verticalCenter: parent.verticalCenter
                active: Config.config.battery
                sourceComponent: Battery{}
            }
            
            // Tray Initialization

            Repeater {
                model: SystemTray.items
                TrayElement{
                    parentPanel: barPanel
                    trayElement: modelData
                }
            }
        }

    }

}