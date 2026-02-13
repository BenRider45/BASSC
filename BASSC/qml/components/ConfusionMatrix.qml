import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root

    // Mock confusion matrix data (6x6 for symbols A-F)
    property var matrixData: [
        [45, 2, 1, 0, 0, 1],  // A
        [1, 38, 2, 1, 0, 0],  // B
        [0, 1, 52, 2, 1, 0],  // C
        [0, 0, 2, 28, 1, 0],  // D
        [1, 0, 1, 1, 48, 2],  // E
        [0, 1, 0, 0, 1, 32]   // F
    ]

    property var labels: ["A", "B", "C", "D", "E", "F"]

    GridLayout {
        anchors.fill: parent
        columns: labels.length + 2
        rows: labels.length + 2
        columnSpacing: 2
        rowSpacing: 2

        // Top-left corner label
        Text {
            text: "Actual \\ Pred"
            font.pixelSize: 10
            font.bold: true
            Layout.alignment: Qt.AlignCenter
        }

        // Column headers (Predicted)
        Repeater {
            model: labels.length

            Text {
                text: labels[index]
                font.pixelSize: 12
                font.bold: true
                Layout.alignment: Qt.AlignCenter
                Layout.preferredWidth: 50
            }
        }

        // Empty corner
        Item { Layout.preferredWidth: 50 }

        // Rows
        Repeater {
            model: labels.length

            Repeater {
                id: rowRepeater
                model: labels.length + 2

                Item {
                    required property int index

                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 50

                    // Row label (Actual)
                    Text {
                        visible: index === 0
                        text: labels[parent.parent.index]
                        font.pixelSize: 12
                        font.bold: true
                        anchors.centerIn: parent
                    }

                    // Matrix cell
                    Rectangle {
                        visible: index > 0 && index <= labels.length
                        anchors.fill: parent
                        anchors.margins: 1

                        property int value: index > 0 && index <= labels.length ?
                                           matrixData[parent.parent.index][index - 1] : 0
                        property int maxValue: 60
                        property bool isCorrect: (index - 1) === parent.parent.index

                        color: {
                            if (isCorrect) {
                                var intensity = value / maxValue
                                return Qt.rgba(0.18, 0.8, 0.44, 0.3 + intensity * 0.7)
                            } else if (value > 0) {
                                var errorIntensity = value / maxValue
                                return Qt.rgba(0.91, 0.3, 0.24, 0.2 + errorIntensity * 0.6)
                            } else {
                                return "#f9f9f9"
                            }
                        }

                        border.color: isCorrect ? "#27ae60" : "#ddd"
                        border.width: isCorrect ? 2 : 1

                        Text {
                            text: parent.value > 0 ? parent.value : ""
                            anchors.centerIn: parent
                            font.pixelSize: 14
                            font.bold: parent.parent.isCorrect
                            color: parent.parent.isCorrect ? "#27ae60" : "#34495e"
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true

                            onEntered: {
                                tooltip.visible = true
                            }

                            onExited: {
                                tooltip.visible = false
                            }

                            ToolTip {
                                id: tooltip
                                visible: false
                                text: "Actual: " + labels[parent.parent.parent.parent.index] +
                                      ", Predicted: " + labels[parent.parent.index - 1] +
                                      "\nCount: " + parent.parent.value
                            }
                        }
                    }

                    // Empty cell for spacing
                    Item {
                        visible: index > labels.length
                    }
                }
            }
        }
    }

    // Legend
    Row {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: 10
        spacing: 15

        Row {
            spacing: 5

            Rectangle {
                width: 20
                height: 20
                color: "#2ecc71"
                opacity: 0.7
                border.color: "#27ae60"
                border.width: 2
            }

            Text {
                text: "Correct"
                font.pixelSize: 10
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            spacing: 5

            Rectangle {
                width: 20
                height: 20
                color: "#e74c3c"
                opacity: 0.5
                border.color: "#ddd"
            }

            Text {
                text: "Misclassified"
                font.pixelSize: 10
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}
