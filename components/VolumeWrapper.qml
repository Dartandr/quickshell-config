import Quickshell
import QtQuick
import "../config/config.js" as Config

ShellRoot{
    id: root
    property var selectedScreen: null

    Component.onCompleted: {
        if(!Config.config.volumeScreen){
            selectedScreen = Quickshell.screens[0]
        }else{
            for (let screen of Quickshell.screens) {
                if (screen.name.includes(Config.config.volumeScreen)) {
                    selectedScreen = screen
                    break
                }
            }
        }
    }

    Loader{
        active: root.selectedScreen
        sourceComponent: Volume { thisScreen: root.selectedScreen }
    }
}