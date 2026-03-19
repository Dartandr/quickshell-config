import Quickshell
import QtQuick
import Quickshell.Services.UPower
import "../services/Colors"

Item{
    id: battery
    property int percent: UPower.displayDevice.percentage * 100

    anchors.verticalCenter: parent.verticalCenter
    width: UPower.onBattery ? 58 : 43
    Rectangle{
        width: 40
        radius: 5
        height: 20
        border.width: 2
        border.color: Colors.foreground
        color: Colors.main
        anchors.left: parent.left
        anchors.top: parent.top
        Rectangle{
            anchors.left: parent.left
            anchors.top: parent.top
            width: 32 * battery.percent / 100
            height: 12
            anchors.leftMargin: 4
            anchors.topMargin: 4
            radius: 2
            color: battery.percent < 21 ? "red" : battery.percent < 41 ? "orange" : "#19530A"
        }
        Text{
            text: battery.percent
            color: Colors.foreground
            anchors.centerIn: parent
            font.pixelSize: 12
            font.weight: 700
        }
    }
    Rectangle{
        anchors.left: parent.left
        anchors.top: parent.top
        color: Colors.foreground
        width:3
        height:8
        anchors.leftMargin: 40
        anchors.topMargin: 6
        topRightRadius:2
        bottomRightRadius:2
    }
    Loader{
        active: UPower.onBattery
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        sourceComponent: Image {
            height: 12
            width: 12
            source: "../assets/icons/thunder.svg"
        }

    }
    height:20
    visible:true
}