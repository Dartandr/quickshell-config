import QtQuick
import "../services/Colors"
import "../services/DateService"

Rectangle{
    id: date
    height: 30
    width: childrenRect.width
    color: "transparent"

    Text{
        id:dateText
        anchors.verticalCenter: parent.verticalCenter
        text: DateService.dateBar
        color: Colors.foreground
        font.pixelSize: 18
        font.weight: 500
    }
}