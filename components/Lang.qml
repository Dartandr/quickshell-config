import QtQuick
import "../services/HyprlandService"
import "../services/Colors"

Rectangle{
    id: date
    height: 30
    width: childrenRect.width
    clip: true
    color: "transparent"
    Text{
        id:dateText
        anchors.verticalCenter: parent.verticalCenter
        text: HyprlandService.currentLayout
        color: Colors.foreground
        font.pixelSize: 18
        font.weight: 500
    }
}