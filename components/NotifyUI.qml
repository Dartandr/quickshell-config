import QtQuick
import Quickshell.Widgets
import "../services/Colors"

Rectangle {

    property var notification

    id: root
    width: 350
    height: Math.min(contentRow.implicitHeight + 24, 100)
    color: Colors.main
    radius: 10
    function capitalize(str) {
        return str.length > 0 ? str[0].toUpperCase() + str.slice(1) : "";
    }

    transform: Translate {
        id: slide
        x: root.width
        Behavior on x {
            NumberAnimation {
                duration: 300
                easing.type: Easing.OutCubic
            }
        }
    }

    opacity: 0

    Behavior on opacity {
        NumberAnimation {
            duration: 300 // 0.3 секунды
            easing.type: Easing.InOutQuad
        }
    }

    Timer {
        interval: 20000
        running: true
        repeat: false
        onTriggered: {
            root.opacity = 0
            slide.x = root.width
        }
    }
    Timer{
        interval: 20300
        running: true
        repeat: false
        onTriggered: {
            root.destroy()
        }
    }

    Component.onCompleted: {
        slide.x = 35
        opacity = 1
    }

    Text{
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        font.capitalization: Font.MixedCase
        text: root.capitalize(root.notification.appName)
        color: Colors.foreground
        font.pixelSize: 12
    }

    Row {
        id: contentRow
        anchors.fill: parent
        anchors.margins: 12
        spacing: 10

        ClippingWrapperRectangle{
            visible: root.notification.image.length > 0
            width: 50
            height: 50
            radius: 100
            Image {
                id: icon
                source: root.notification.image
                sourceSize.width: 64
                sourceSize.height: 64
                width: 50
                height: 50
                fillMode: Image.PreserveAspectFit
                asynchronous: true
                cache: false
            }
        }

        Column{
            width: root.width - (icon.visible ? icon.width + contentRow.spacing : 0) - contentRow.anchors.margins * 2

            Text{
                id: title
                text: root.notification.summary
                color: Colors.foreground

                maximumLineCount: 1
                elide: Text.ElideRight
                font.pixelSize: 16
            }

            Text {
                id: text
                text: root.notification.body
                color: Colors.foreground

                wrapMode: Text.Wrap
                elide: Text.ElideRight
                maximumLineCount: 3
                font.pixelSize: 12
                width: parent.width
            }
        }
    }

    // Actions Maybe later

    // Row {
    // id: actionsRow
    // spacing: 8
    // anchors.horizontalCenter: parent.horizontalCenter

    // // Создаём кнопку для каждой action
    // Repeater {
    // model: root.notification.actions
    // delegate: Rectangle {
    // radius: 4
    // color: "#555555"
    // width: 150
    // height: 30

    // Text {
    // id: actionText
    // anchors.centerIn: parent
    // text: model.text
    // color: "white"
    // font.pixelSize: 12
    // }

    // MouseArea {
    // anchors.fill: parent
    // onClicked: model.invoke()
    // }
    // }
    // }
    // }
    Timer {
        id: destroyTimer
        interval: 300
        running: false
        onTriggered: root.destroy()
    }
    MouseArea {
        anchors.fill: parent
        onClicked: () => {
                       root.opacity = 0
                       slide.x = root.width
                       destroyTimer.start()
                   }
    }
}