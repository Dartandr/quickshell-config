import Quickshell
import QtQuick
import "../services/StateService"



Loader {
    active: StateService.openMenu
    sourceComponent: PanelWindow{
        exclusiveZone: 0
        anchors.left: true
        anchors.top: true
        height: 100
        width: 100
        color: "white"
    }
}