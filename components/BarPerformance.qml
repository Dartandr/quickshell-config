import QtQuick
import "../services/Colors"
import "../services/PerformanceService"

Row{
    spacing: 5
    Item{
        width: childrenRect.width
        height: 30

        Row{
            spacing: 5
            Item {
                width: 30
                height: 30
                id: cpu
                property int progress: PerformanceService.cpuLoad

                Canvas {
                    id: cpuCanvas
                    anchors.fill: parent

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.reset()

                        var centerX = width / 2
                        var centerY = height / 2
                        var radius = width / 2 - 1

                        // фон
                        ctx.beginPath()
                        ctx.lineWidth = 2
                        ctx.strokeStyle = "#333"
                        ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
                        ctx.stroke()

                        // прогресс
                        ctx.beginPath()
                        ctx.lineWidth = 2
                        ctx.strokeStyle = Colors.accent

                        var start = -Math.PI / 2
                        var end = start + (cpu.progress / 100) * Math.PI * 2

                        ctx.arc(centerX, centerY, radius, start, end)
                        ctx.lineCap = "round"
                        ctx.stroke()
                    }
                }

                onProgressChanged: cpuCanvas.requestPaint()

                Image{
                    anchors.centerIn: parent
                    source: "../assets/icons/cpu.svg"
                }

            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                text: cpu.progress
                font.pixelSize: 18
                font.weight: 500
                color: Colors.foreground
            }

        }

    }


    Item{
        width: childrenRect.width
        height: 30

        Row{
            spacing: 5
            Item {
                width: 30
                height: 30
                id: ram
                property int progress: PerformanceService.ramLoad

                Canvas {
                    id: ramCanvas
                    anchors.fill: parent

                    onPaint: {
                        var ctx = getContext("2d")
                        ctx.reset()

                        var centerX = width / 2
                        var centerY = height / 2
                        var radius = width / 2 - 1

                        ctx.beginPath()
                        ctx.lineWidth = 2
                        ctx.strokeStyle = "#333"
                        ctx.arc(centerX, centerY, radius, 0, Math.PI * 2)
                        ctx.stroke()

                        ctx.beginPath()
                        ctx.lineWidth = 2
                        ctx.strokeStyle = Colors.accent

                        var start = -Math.PI / 2
                        var end = start + (ram.progress / 100) * Math.PI * 2

                        ctx.arc(centerX, centerY, radius, start, end)
                        ctx.lineCap = "round"
                        ctx.stroke()
                    }
                }

                onProgressChanged: ramCanvas.requestPaint()

                Image{
                    anchors.centerIn: parent
                    source: "../assets/icons/ram.svg"
                }

            }
            Text{
                anchors.verticalCenter: parent.verticalCenter
                text: ram.progress
                font.pixelSize: 18
                font.weight: 500
                color: Colors.foreground
            }

        }

    }

}


