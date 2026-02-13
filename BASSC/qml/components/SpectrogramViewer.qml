import QtQuick
import QtQuick.Controls

Item {
    id: root

    property string currentFile: "mock_audio.wav"

    onCurrentFileChanged: {
        if (mockSpectrogram) {
            mockSpectrogram.requestPaint()
        }
    }

    ScrollView {
        anchors.fill: parent
        clip: true

        contentWidth: spectrogramImage.width
        contentHeight: spectrogramImage.height

        Rectangle {
            id: spectrogramImage
            width: Math.max(root.width, 1200)
            height: Math.max(root.height, 400)
            color: "#1a1a2e"

            // Mock spectrogram visualization
            Canvas {
                id: mockSpectrogram
                anchors.fill: parent

                Component.onCompleted: {
                    requestPaint()
                }

                onPaint: {
                    var ctx = getContext("2d")
                    ctx.fillStyle = "#0f3460"
                    ctx.fillRect(0, 0, width, height)

                    // Draw mock frequency bands
                    ctx.strokeStyle = "#16213e"
                    ctx.lineWidth = 1

                    for (var i = 0; i < 20; i++) {
                        var y = (height / 20) * i
                        ctx.beginPath()
                        ctx.moveTo(0, y)
                        ctx.lineTo(width, y)
                        ctx.stroke()
                    }

                    // Draw mock time divisions
                    for (var j = 0; j < 40; j++) {
                        var x = (width / 40) * j
                        ctx.beginPath()
                        ctx.moveTo(x, 0)
                        ctx.lineTo(x, height)
                        ctx.stroke()
                    }

                    // Draw mock spectrogram patterns
                    ctx.fillStyle = "#e94560"
                    for (var k = 0; k < 15; k++) {
                        var rx = Math.random() * (width - 100)
                        var ry = Math.random() * (height - 50)
                        var rw = 50 + Math.random() * 50
                        var rh = 30 + Math.random() * 40
                        ctx.globalAlpha = 0.3 + Math.random() * 0.4
                        ctx.fillRect(rx, ry, rw, rh)
                    }
                }
            }

            Text {
                text: "Spectrogram: " + root.currentFile + "\n(Mock visualization - TODO: Connect to audio processing backend)"
                anchors.centerIn: parent
                color: "#fff"
                font.pixelSize: 16
                horizontalAlignment: Text.AlignHCenter
            }

            // Selection region (for annotation)
            Rectangle {
                id: selectionRect
                color: "transparent"
                border.color: "#00ff00"
                border.width: 2
                visible: false

                property point startPos
            }

            MouseArea {
                anchors.fill: parent
                onPressed: {
                    selectionRect.startPos = Qt.point(mouseX, mouseY)
                    selectionRect.x = mouseX
                    selectionRect.y = mouseY
                    selectionRect.width = 0
                    selectionRect.height = 0
                    selectionRect.visible = true
                }

                onPositionChanged: {
                    if (pressed) {
                        var newWidth = mouseX - selectionRect.startPos.x
                        var newHeight = mouseY - selectionRect.startPos.y

                        selectionRect.x = newWidth < 0 ? mouseX : selectionRect.startPos.x
                        selectionRect.y = newHeight < 0 ? mouseY : selectionRect.startPos.y
                        selectionRect.width = Math.abs(newWidth)
                        selectionRect.height = Math.abs(newHeight)
                    }
                }

                onReleased: {
                    if (selectionRect.width > 10 && selectionRect.height > 10) {
                        // TODO: Create annotation from selection
                        console.log("Annotation created at:", selectionRect.x, selectionRect.y,
                                    "size:", selectionRect.width, selectionRect.height)
                    }
                    selectionRect.visible = false
                }
            }
        }
    }
}
