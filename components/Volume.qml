import QtQuick
import Quickshell
import Quickshell.Io
import "../services/Colors"

PanelWindow {
    id: volumeBar
    anchors.right: true
    exclusiveZone: 0
    implicitWidth: 40
    implicitHeight: root.height + 40
    color: "transparent"

    property int xProp: 30

    mask: Region {
        x: volumeBar.xProp
        y: 0
        width: 40
        height: root.height + 40
    }

    Item {
        id: root
        width: 20
        height: 120
        x: 10 + volumeBar.xProp
        y: 20
        property real value: undefined
        property int handleSize: 20
        property int trackWidth: 6

        Rectangle {
            id: track
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.trackWidth
            height: parent.height
            radius: track.width / 2
            color: "#444"
        }

        Rectangle {
            anchors.bottom: track.bottom
            anchors.horizontalCenter: track.horizontalCenter
            width: track.width
            height: root.value * track.height
            color: Colors.accent
            radius: track.width / 2
        }

        Rectangle {
            id: handle
            width: root.handleSize
            height: root.handleSize
            radius: root.handleSize / 2
            color: "white"
            anchors.horizontalCenter: track.horizontalCenter

            y: track.y + (1 - root.value) * track.height - handle.height / 2
        }

        MouseArea {
            anchors.fill: parent
            onPressed: updateVol(mouseY)
            onPositionChanged: if (pressed) updateVol(mouseY)

            function updateVol(yPos) {
                let v = 1 - ((yPos - track.y) / track.height)
                root.value = Math.max(0, Math.min(1, v))
            }
        }
        onValueChanged: {
            if(root.value){
                setVolume.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", `${Math.round(root.value * 100)}%`]
                setVolume.running = true
            }

        }

        Process{
            id: setVolume
        }
        Process{
            id: getVolume
            command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
            running: true
            stdout: StdioCollector {
                onStreamFinished: {
                    root.value = parseFloat(this.text.split(" ")[1])
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
        onEntered: {
            volumeBar.xProp = 0
        }
        onExited: {
            volumeBar.xProp = 30
        }
    }

}