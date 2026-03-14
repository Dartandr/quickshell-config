pragma Singleton

import QtQuick
import Quickshell.Io

Item {
    id: dateService

    property string dateBar: ""
    property string dateWallpaper: ""

    Process {
        id:dateFunc
        command: ["date", "+%H:%M · %A · %d %b|%H:%M,%d %b %Y"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                var dateSplit = this.text.split("|")
                dateService.dateBar = dateSplit[0]
                dateService.dateWallpaper = dateSplit[1]
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: dateFunc.running = true
    }
}