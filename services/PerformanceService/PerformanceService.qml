pragma Singleton

import QtQuick
import Quickshell.Io

Item {
    id: performanceService

    property int cpuLoad: 0
    property int avgSize: 5
    property var lastValues: []
    property int ramLoad: 0

    Process {
        id: ramProcess
        command: ["bash", "-c",
            "total=$(grep MemTotal /proc/meminfo | awk '{print $2}'); " +
            "available=$(grep MemAvailable /proc/meminfo | awk '{print $2}'); " +
            "used=$((total - available)); " +
            "echo $((used*100/total))"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let value = parseInt(this.text.trim())
                if (!isNaN(value))
                performanceService.ramLoad = value
            }
        }
    }

    Process {
        id: cpuProcess
        command: ["bash", "-c",
            `
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat;
total1=$((user+nice+system+idle+iowait+irq+softirq+steal));
idle1=$((idle+iowait));
sleep 1;
read cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat;
total2=$((user+nice+system+idle+iowait+irq+softirq+steal));
idle2=$((idle+iowait));
echo $((100*((total2-total1)-(idle2-idle1))/(total2-total1)));
`
        ]
        stdout: StdioCollector {
            onStreamFinished: {
                let v = parseInt(this.text.trim())
                if (!isNaN(v)) {
                    performanceService.lastValues.push(v)
                    if (performanceService.lastValues.length > performanceService.avgSize)
                    performanceService.lastValues.shift()

                    let sum = 0
                    for (let i=0; i<performanceService.lastValues.length; i++)
                    sum += performanceService.lastValues[i]
                    performanceService.cpuLoad = Math.round(sum / performanceService.lastValues.length)
                }
            }
        }
    }
    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            ramProcess.running = true
            cpuProcess.running = true
        }
    }
}