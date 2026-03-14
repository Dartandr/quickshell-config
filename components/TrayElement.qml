
import QtQuick

Rectangle {

    property var trayElement
    property var parentPanel
    id: trayItem
    width: 25
    height: 30
    color: "transparent"
    Image{
        anchors.centerIn: parent
        source: trayItem.trayElement.icon
        height: 20
        width: 20
        sourceSize.height: 40
        sourceSize.width: 40
    }
    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.AllButtons
        onClicked: (mouse) => {
                       if (mouse.button === Qt.RightButton) {
                           //TODO change default dbusMenu to custom
                           trayItem.trayElement.display(trayItem.parentPanel, trayItem.parent.x + trayItem.x + mouse.x, mouse.y + 5)
                       }
                       if(mouse.button === Qt.LeftButton){
                           trayItem.trayElement.activate()
                       }

                   }

    }
}