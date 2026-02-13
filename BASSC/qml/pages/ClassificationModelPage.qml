import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Item {
    id: root

    signal navigateBack()

    Column {
        anchors.fill: parent
        spacing: 0

        TopMenuBar {
            id: menuBar
            width: parent.width

            onNewProjectClicked: {
                console.log("New project from model page")
            }
            onOpenProjectClicked: {
                console.log("Open project from model page")
            }
            onSaveProjectClicked: {
                console.log("Save project")
            }
            onSettingsClicked: {
                console.log("Settings")
            }
        }

        ScrollView {
            width: parent.width
            height: parent.height - menuBar.height
            clip: true

            ColumnLayout {
                width: parent.parent.width
                spacing: 20
                //padding: 20

                // Page Title
                Text {
                    text: "Classification Model"
                    font.pixelSize: 28
                    font.bold: true
                    Layout.alignment: Qt.AlignHCenter
                }

                // Training Status Section
                GroupBox {
                    title: "Training Status"
                    Layout.fillWidth: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 10

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10

                            Text {
                                text: "Status:"
                                font.bold: true
                            }

                            Rectangle {
                                width: 12
                                height: 12
                                radius: 6
                                color: "#2ecc71"
                            }

                            Text {
                                text: "Ready"
                                color: "#2ecc71"
                            }
                        }

                        RowLayout {
                            Layout.fillWidth: true

                            Text {
                                text: "Epoch:"
                                font.bold: true
                            }

                            Text {
                                text: "47 / 100"
                            }

                            Item { Layout.fillWidth: true }

                            Text {
                                text: "Accuracy:"
                                font.bold: true
                            }

                            Text {
                                text: "92.3%"
                                color: "#2ecc71"
                                font.bold: true
                            }
                        }

                        ProgressBar {
                            Layout.fillWidth: true
                            value: 0.47
                        }

                        RowLayout {
                            Layout.fillWidth: true
                            spacing: 10

                            Button {
                                text: "Start Training"
                                onClicked: {
                                    // TODO: Connect to ModelManager
                                    console.log("Start training")
                                }
                            }

                            Button {
                                text: "Stop Training"
                                onClicked: {
                                    console.log("Stop training")
                                }
                            }

                            Button {
                                text: "Export Model"
                                onClicked: {
                                    console.log("Export model")
                                }
                            }
                        }
                    }
                }

                // Performance Metrics Section
                GroupBox {
                    title: "Performance Metrics"
                    Layout.fillWidth: true

                    GridLayout {
                        anchors.fill: parent
                        columns: 4
                        rowSpacing: 15
                        columnSpacing: 20

                        // Metric cards
                        Repeater {
                            model: metricsModel

                            Rectangle {
                                Layout.preferredWidth: 150
                                Layout.preferredHeight: 100
                                color: "#ecf0f1"
                                border.color: "#bdc3c7"
                                radius: 5

                                ColumnLayout {
                                    anchors.centerIn: parent
                                    spacing: 5

                                    Text {
                                        text: model.name
                                        font.pixelSize: 12
                                        color: "#7f8c8d"
                                        Layout.alignment: Qt.AlignHCenter
                                    }

                                    Text {
                                        text: model.value
                                        font.pixelSize: 24
                                        font.bold: true
                                        color: model.color
                                        Layout.alignment: Qt.AlignHCenter
                                    }
                                }
                            }
                        }
                    }
                }

                // Confusion Matrix Section
                GroupBox {
                    title: "Confusion Matrix"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 400

                    ConfusionMatrix {
                        anchors.fill: parent
                        anchors.margins: 10
                    }
                }

                // Training History Section
                GroupBox {
                    title: "Training History"
                    Layout.fillWidth: true
                    Layout.preferredHeight: 250

                    Rectangle {
                        anchors.fill: parent
                        color: "#fff"

                        Canvas {
                            id: trainingChart
                            anchors.fill: parent
                            anchors.margins: 20

                            onPaint: {
                                var ctx = getContext("2d")
                                ctx.clearRect(0, 0, width, height)

                                // Draw axes
                                ctx.strokeStyle = "#34495e"
                                ctx.lineWidth = 2
                                ctx.beginPath()
                                ctx.moveTo(40, 10)
                                ctx.lineTo(40, height - 30)
                                ctx.lineTo(width - 10, height - 30)
                                ctx.stroke()

                                // Draw mock training curve
                                ctx.strokeStyle = "#3498db"
                                ctx.lineWidth = 3
                                ctx.beginPath()

                                var points = 50
                                for (var i = 0; i < points; i++) {
                                    var x = 40 + (width - 50) * (i / points)
                                    var y = (height - 30) - (Math.log(i + 1) / Math.log(points)) * (height - 40)
                                    y += Math.random() * 10 - 5

                                    if (i === 0) {
                                        ctx.moveTo(x, y)
                                    } else {
                                        ctx.lineTo(x, y)
                                    }
                                }
                                ctx.stroke()
                            }
                        }

                        Text {
                            text: "Loss"
                            anchors.left: parent.left
                            anchors.verticalCenter: parent.verticalCenter
                            rotation: -90
                            font.bold: true
                        }

                        Text {
                            text: "Epoch"
                            anchors.bottom: parent.bottom
                            anchors.horizontalCenter: parent.horizontalCenter
                            font.bold: true
                        }
                    }
                }

                Item { Layout.fillHeight: true }
            }
        }
    }

    // Mock metrics data
    ListModel {
        id: metricsModel

        ListElement {
            name: "Precision"
            value: "91.2%"
            color: "#3498db"
        }

        ListElement {
            name: "Recall"
            value: "89.7%"
            color: "#2ecc71"
        }

        ListElement {
            name: "F1 Score"
            value: "90.4%"
            color: "#9b59b6"
        }

        ListElement {
            name: "Training Loss"
            value: "0.23"
            color: "#e74c3c"
        }

        ListElement {
            name: "Validation Loss"
            value: "0.31"
            color: "#e67e22"
        }

        ListElement {
            name: "Test Accuracy"
            value: "92.3%"
            color: "#1abc9c"
        }

        ListElement {
            name: "Training Time"
            value: "2.4h"
            color: "#34495e"
        }

        ListElement {
            name: "Samples"
            value: "1,247"
            color: "#95a5a6"
        }
    }
}
