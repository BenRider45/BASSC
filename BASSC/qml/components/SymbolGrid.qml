import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ScrollView {
    id: root

    clip: true

    GridView {
        id: symbolGridView
        anchors.fill: parent
        cellWidth: 200
        cellHeight: 150
        model: symbolsModel

        delegate: Rectangle {
            width: symbolGridView.cellWidth - 10
            height: symbolGridView.cellHeight - 10
            color: "#f5f5f5"
            border.color: "#ccc"
            border.width: 1
            radius: 5

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 5

                // Spectrogram snippet
                Rectangle {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    color: "#1a1a2e"
                    border.color: "#666"

                    Canvas {
                        anchors.fill: parent
                        onPaint: {
                            var ctx = getContext("2d")
                            ctx.fillStyle = "#0f3460"
                            ctx.fillRect(0, 0, width, height)

                            // Mock pattern based on symbol
                            ctx.fillStyle = model.color
                            ctx.globalAlpha = 0.6
                            var patternWidth = 40
                            var patternHeight = 30
                            var x = (width - patternWidth) / 2
                            var y = (height - patternHeight) / 2
                            ctx.fillRect(x, y, patternWidth, patternHeight)
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: model.label
                        color: "#fff"
                        font.pixelSize: 12
                        font.bold: true
                    }
                }

                // Label
                Text {
                    text: model.label + " (" + model.count + " instances)"
                    font.pixelSize: 12
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: parent.border.color = "#333"
                onExited: parent.border.color = "#ccc"
                onClicked: {
                    // TODO: Select this symbol for annotation
                    console.log("Symbol selected:", model.label)
                }
            }
        }
    }

    // Mock symbols data
    ListModel {
        id: symbolsModel

        ListElement {
            label: "A"
            count: 24
            color: "#e94560"
        }

        ListElement {
            label: "B"
            count: 18
            color: "#3498db"
        }

        ListElement {
            label: "C"
            count: 31
            color: "#2ecc71"
        }

        ListElement {
            label: "D"
            count: 12
            color: "#f39c12"
        }

        ListElement {
            label: "E"
            count: 27
            color: "#9b59b6"
        }

        ListElement {
            label: "F"
            count: 15
            color: "#1abc9c"
        }
    }
}
