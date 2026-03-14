import Quickshell
import Quickshell.Wayland
import QtQuick
import Quickshell.Services.Notifications
import Quickshell.Io
import "../config/config.js" as Config


ShellRoot{
    id: root
    property var notifScreen: null

    Component.onCompleted: {
        for (let screen of Quickshell.screens) {
            if (screen.name.includes(Config.config.notification.monitor)) {
                notifScreen = screen
                break
            }
        }
    }

    PanelWindow {
        screen: root.notifScreen
        WlrLayershell.layer: WlrLayer.Overlay
        id: notifElements
        anchors.top: true
        anchors.right: true
        color: "transparent"
        implicitWidth: 400
        implicitHeight: root.notifScreen.height - 50
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
        command: ["pw-play", Config.config.notification.sound]
    }

    NotificationServer {

        id: notifyServer
        actionsSupported: true
        onNotification: notif => {
                            notificationComponent.createObject( container, { notification: notif } );
                            if(Config.config.notification.disableSoundFor.indexOf(notif.appName) < 0) {
                                notifSound.running = true
                            }
                        }
    }
}