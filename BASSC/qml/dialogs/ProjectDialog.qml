import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

Dialog {
    id: root

    property string dialogTitle: "Project"
    property bool isOpenMode: false
    property string projectName: ""
    property string projectPath: ""

    title: dialogTitle
    modal: true
    anchors.centerIn: parent
    width: 500
    height: isOpenMode ? 200 : 300

    standardButtons: Dialog.Ok | Dialog.Cancel

    onAccepted: {
        if (!isOpenMode) {
            projectName = nameField.text
        }
        projectPath = pathField.text
    }

    contentItem: ColumnLayout {
        spacing: 15

        // Project Name (only for New Project)
        ColumnLayout {
            visible: !root.isOpenMode
            spacing: 5

            Label {
                text: "Project Name:"
                font.bold: true
            }

            TextField {
                id: nameField
                Layout.fillWidth: true
                placeholderText: "Enter project name"
            }
        }

        // Project Directory
        ColumnLayout {
            spacing: 5

            Label {
                text: root.isOpenMode ? "Project Directory:" : "Project Location:"
                font.bold: true
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                TextField {
                    id: pathField
                    Layout.fillWidth: true
                    placeholderText: "Select directory"
                    readOnly: true
                }

                Button {
                    text: "Browse..."
                    onClicked: folderDialog.open()
                }
            }
        }

        Item { Layout.fillHeight: true }
    }

    FolderDialog {
        id: folderDialog
        currentFolder: "file:///Users"
        onAccepted: {
            pathField.text = selectedFolder.toString().replace("file://", "")
        }
    }
}
