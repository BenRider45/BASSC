import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../components"
import "../dialogs"

Item {
    id: root

    signal navigateToAnnotation()

    Column {
        anchors.fill: parent
        spacing: 0

        TopMenuBar {
            id: menuBar
            width: parent.width

            onNewProjectClicked: newProjectDialog.open()
            onOpenProjectClicked: openProjectDialog.open()
            onSaveProjectClicked: {
                // TODO: Connect to backend ProjectManager
                console.log("Save project clicked")
            }
            onSettingsClicked: settingsDialog.open()
        }

        Item {
            width: parent.width
            height: parent.height - menuBar.height

            // Title
            Text {
                id: titleText
                text: "BASSC"
                font.pixelSize: 48
                font.bold: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 60
            }

            // Main content area
            RowLayout {
                anchors.centerIn: parent
                width: parent.width * 0.7
                height: parent.height * 0.5
                spacing: 40

                // Recent Projects List (Left)
                Item {
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Column {
                        anchors.fill: parent
                        spacing: 10

                        Text {
                            text: "Recent Projects"
                            font.pixelSize: 18
                            font.bold: true
                        }

                        ScrollView {
                            width: parent.width
                            height: parent.height - 30
                            clip: true

                            ListView {
                                id: recentProjectsList
                                width: parent.width
                                model: recentProjectsModel
                                spacing: 5

                                delegate: ItemDelegate {
                                    width: ListView.view.width
                                    text: model.name

                                    contentItem: Column {
                                        Text {
                                            text: model.name
                                            font.pixelSize: 14
                                            font.bold: true
                                        }
                                        Text {
                                            text: model.path
                                            font.pixelSize: 11
                                            color: "#666"
                                        }
                                    }

                                    onClicked: {
                                        // TODO: Load project via backend
                                        console.log("Loading project:", model.name)
                                        root.navigateToAnnotation()
                                    }
                                }
                            }
                        }
                    }
                }

                // Action Buttons (Right)
                ColumnLayout {
                    Layout.fillHeight: true
                    Layout.preferredWidth: 200
                    spacing: 20

                    Button {
                        text: "New Project"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        onClicked: newProjectDialog.open()
                    }

                    Button {
                        text: "Open Project"
                        Layout.fillWidth: true
                        Layout.preferredHeight: 50
                        onClicked: openProjectDialog.open()
                    }

                    Item { Layout.fillHeight: true }
                }
            }
        }
    }

    // Mock recent projects data
    ListModel {
        id: recentProjectsModel
        ListElement { name: "Sparrow Study 2024"; path: "/path/to/sparrow_2024" }
        ListElement { name: "Finch Analysis"; path: "/path/to/finch_analysis" }
        ListElement { name: "Canary Songs"; path: "/path/to/canary_songs" }
    }

    // Dialogs
    ProjectDialog {
        id: newProjectDialog
        dialogTitle: "New Project"
        onAccepted: {
            // TODO: Create project via backend
            console.log("New project:", projectName, "at", projectPath)
            root.navigateToAnnotation()
        }
    }

    ProjectDialog {
        id: openProjectDialog
        dialogTitle: "Open Project"
        isOpenMode: true
        onAccepted: {
            // TODO: Open project via backend
            console.log("Open project at:", projectPath)
            root.navigateToAnnotation()
        }
    }

    Dialog {
        id: settingsDialog
        title: "Settings"
        anchors.centerIn: parent
        width: 400
        height: 300

        contentItem: Text {
            text: "Settings dialog\n\nTODO: Implement settings UI"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        standardButtons: Dialog.Ok
    }
}
