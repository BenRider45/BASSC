import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"

Item {
    id: root

    signal navigateToModel()
    signal navigateBack()

    Column {
        anchors.fill: parent
        spacing: 0

        TopMenuBar {
            id: menuBar
            width: parent.width

            onNewProjectClicked: {
                // TODO: Connect to backend
                console.log("New project from annotation page")
            }
            onOpenProjectClicked: {
                console.log("Open project from annotation page")
            }
            onSaveProjectClicked: {
                console.log("Save project")
            }
            onSettingsClicked: {
                console.log("Settings")
            }
        }

        Item {
            width: parent.width
            height: parent.height - menuBar.height

            // Main content with file panel overlay
            Item {
                id: mainContent
                anchors.fill: parent

                // Spectrogram Section (Top Half)
                Item {
                    id: spectrogramSection
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: parent.height * 0.5

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        // Audio Controls
                        RowLayout {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 10

                            Button {
                                text: "Play"
                                onClicked: {
                                    // TODO: Connect to AudioManager
                                    console.log("Play audio")
                                }
                            }

                            Button {
                                text: "Pause"
                                onClicked: {
                                    console.log("Pause audio")
                                }
                            }

                            Button {
                                text: "Stop"
                                onClicked: {
                                    console.log("Stop audio")
                                }
                            }
                        }

                        // Spectrogram Display
                        SpectrogramViewer {
                            id: spectrogramViewer
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                    }
                }

                // Symbol Grid Section (Bottom Half)
                Item {
                    id: symbolSection
                    anchors.top: spectrogramSection.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 10

                        Text {
                            text: "Defined Symbols"
                            font.pixelSize: 18
                            font.bold: true
                        }

                        SymbolGrid {
                            id: symbolGrid
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                        }
                    }
                }

                // Navigate to Model button
                Button {
                    text: "Go to Model"
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 20
                    onClicked: root.navigateToModel()
                }
            }

            // File Selection Panel (Slide-out from right)
            FileSelectionPanel {
                id: filePanel
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom

                onFileSelected: function(fileName) {
                    // TODO: Load file via backend
                    console.log("Loading file:", fileName)
                    spectrogramViewer.currentFile = fileName
                }
            }
        }
    }
}
