import QtQuick
import Quickshell
import Quickshell.Io
import "../services/Colors"

PanelWindow {
    id: volumeBar
    anchors.right: true
    exclusiveZone: 0
    implicitWidth: 70
    implicitHeight: 330
    color: "transparent"

    property int xProp: 60

    mask: Region {
        x: volumeBar.xProp
        y: 0
        width: 70
        height: root.height
    }

    Item {
        id: root
        width: 40
        height: 330
        x: 10 + volumeBar.xProp
        y: 0
        property real value: 1.0
        clip: true

        Rectangle {
            id: track
            anchors.horizontalCenter: parent.horizontalCenter
            width: 40
            height: parent.height
            radius: track.width / 2
            color: Colors.background
        }

        Rectangle {
            anchors.bottom: track.bottom
            anchors.horizontalCenter: track.horizontalCenter
            width: track.width
            anchors.top: handle.top
            color: Colors.accent
            radius: 20
        }

        Rectangle {
            id: handle
            width: 40
            height: 40
            radius: 20
            color: Colors.foreground
            anchors.horizontalCenter: track.horizontalCenter
            y: (1 - root.value) * (track.height - height)

            Text{
                text: Math.round(root.value * 100)
                color: Colors.background
                anchors.centerIn: parent
                font.weight: 700
                font.pixelSize: 18
                id: volumeText
            }

        }

        MouseArea {
            anchors.fill: parent
            onPressed: updateVol(mouseY)
            onPositionChanged: if (pressed) updateVol(mouseY)
            function updateVol(yPos) {
                let pos = yPos - handle.height / 2
                pos = Math.max(0, Math.min(track.height - handle.height, pos))
                let v = 1 - (pos / (track.height - handle.height))
                setVolume.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", `${Math.round(v * 100)}%`]
                setVolume.running = true
            }
        }

        Process{
            id: setVolume
        }

        Process {
            id: volumeEvents
            command: ["pactl", "subscribe"]
            running: true
            stdout: SplitParser {
                onRead: data => {
                            if (data.includes("sink")) {
                                getVolume.running = true
                            }
                        }
            }
        }

        Process{
            id: getVolume
            command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
            running: true
            stdout: StdioCollector {
                onStreamFinished: {
                    var newValue = parseFloat(this.text.split(" ")[1])
                    if(newValue){
                        root.value = newValue
                    }
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
            volumeBar.xProp = 60
        }
    }

}