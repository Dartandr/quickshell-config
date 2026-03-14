import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Services.Notifications
import Quickshell.Io

ShellRoot{
    id: root
    property var dpScreen: null

    Component.onCompleted: {
        for (let screen of Quickshell.screens) {
            if (screen.name.includes("DP")) {
                dpScreen = screen
                break
            }
        }
    }

    PanelWindow {
        screen: root.dpScreen
        WlrLayershell.layer: WlrLayer.Overlay
        id: notifElements
        anchors.top: true
        anchors.right: true
        color: "transparent"
        implicitWidth: 400
        implicitHeight: root.dpScreen.height - 50
        mask: Region {
            x: 0
            y: 0
            width: notifElements.width
            height: container.childrenRect.height
        }

        Column {
            id: container
            anchors.fill: parent
            width: parent.width
            spacing: 10
            anchors.topMargin: 15
        }

    }

    Component {
        id: notificationComponent
        NotifyUI{}
    }

    Process {
        id: notifSound
        command: ["pw-play", "/home/dartandr/.config/quickshell/assets/notification.wav"]
    }

    NotificationServer {

        id: notifyServer
        actionsSupported: true
        onNotification: notif => {
                            notificationComponent.createObject( container, { notification: notif } );
                            if(notif.appName != "vesktop" && notif.appName != "Pachca"){
                                notifSound.running = true
                            }

                        }
    }
}