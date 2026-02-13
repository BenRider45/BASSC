import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    width: panelOpen ? 300 : 30

    property bool panelOpen: false

    signal fileSelected(string fileName)

    Behavior on width {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    // Tab (always visible)
    Rectangle {
        id: tab
        width: 30
        height: 100
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        color: "#2c3e50"
        radius: 5

        Text {
            text: panelOpen ? "▶" : "◀"
            anchors.centerIn: parent
            color: "#fff"
            font.pixelSize: 16
        }

        MouseArea {
            anchors.fill: parent
            onClicked: root.panelOpen = !root.panelOpen
        }
    }

    // Panel content
    Rectangle {
        id: panel
        anchors.left: tab.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 270
        color: "#34495e"
        visible: root.panelOpen
        opacity: root.panelOpen ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation {
                duration: 200
            }
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 10

            Text {
                text: "Audio Files"
                font.pixelSize: 16
                font.bold: true
                color: "#fff"
                Layout.fillWidth: true
            }

            TextField {
                id: searchField
                Layout.fillWidth: true
                placeholderText: "Search files..."

                onTextChanged: {
                    // TODO: Filter file list
                    console.log("Search:", text)
                }
            }

            ScrollView {
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true

                ListView {
                    id: fileListView
                    anchors.fill: parent
                    model: audioFilesModel
                    spacing: 5

                    delegate: ItemDelegate {
                        width: ListView.view.width
                        highlighted: ListView.isCurrentItem

                        contentItem: Column {
                            Text {
                                text: model.name
                                font.pixelSize: 12
                                color: "#fff"
                            }
                            Text {
                                text: model.duration + " | " + model.annotations + " annotations"
                                font.pixelSize: 10
                                color: "#bdc3c7"
                            }
                        }

                        background: Rectangle {
                            color: highlighted ? "#3498db" : (parent.hovered ? "#4a5f7f" : "transparent")
                            radius: 3
                        }

                        onClicked: {
                            fileListView.currentIndex = index
                            root.fileSelected(model.name)
                        }
                    }
                }
            }

            Text {
                text: audioFilesModel.count + " files total"
                font.pixelSize: 11
                color: "#95a5a6"
                Layout.alignment: Qt.AlignHCenter
            }
        }
    }

    // Mock audio files data
    ListModel {
        id: audioFilesModel

        ListElement {
            name: "sparrow_morning_001.wav"
            duration: "12.3s"
            annotations: 8
        }

        ListElement {
            name: "sparrow_morning_002.wav"
            duration: "15.7s"
            annotations: 12
        }

        ListElement {
            name: "sparrow_morning_003.wav"
            duration: "9.2s"
            annotations: 5
        }

        ListElement {
            name: "sparrow_evening_001.wav"
            duration: "18.4s"
            annotations: 15
        }

        ListElement {
            name: "sparrow_evening_002.wav"
            duration: "11.1s"
            annotations: 7
        }

        ListElement {
            name: "sparrow_call_001.wav"
            duration: "3.8s"
            annotations: 2
        }

        ListElement {
            name: "sparrow_call_002.wav"
            duration: "4.2s"
            annotations: 3
        }
    }
}
