pragma Singleton

import QtQuick
import Quickshell.Hyprland

QtObject {
    id: hyprlandService

    property string currentLayout: "en" 
    property string currentApp: ""
    property string currentWindowName: ""

    function parseLayout(fullLayoutName) {
        if (!fullLayoutName) return;

        const shortName = fullLayoutName.substring(0, 2).toLowerCase();

        if (currentLayout !== shortName) {
            currentLayout = shortName;
        }
    }

    function handleRawEvent(event) {
        if (event.name === "activelayout") {
            const dataString = event.data;
            const layoutInfo = dataString.split(",");
            const fullLayoutName = layoutInfo[layoutInfo.length - 1];

            parseLayout(fullLayoutName);
        }

        if(event.name === "activewindow"){
            const dataString = event.data;
            const dataArray = dataString.split(",");
            currentApp = dataArray[0]
            currentWindowName = dataArray[1]
        }
    }

    Component.onCompleted: {
        Hyprland.rawEvent.connect(handleRawEvent);
    }
}