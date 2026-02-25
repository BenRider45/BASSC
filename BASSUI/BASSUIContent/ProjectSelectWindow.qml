import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

Rectangle {
    id: projectSelectScreen
    width: 993
    height: 577
    property string selectedProjectName: "";
    property string selectedProjectPath: "";
    signal confirmedProject(string projName, string projPath);

    Text {
        id: text1
        height: 49
        opacity: 0.793
        text: qsTr("BASS")
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.leftMargin: 530
        anchors.rightMargin: 530
        anchors.topMargin: 68
        font.pixelSize: 48
        horizontalAlignment: Text.AlignHCenter
        font.family: ".AppleSystemUIFont"
    }

    Column {
        id: column
        y: 171
        height: 363
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 37
        anchors.rightMargin: 38
        anchors.bottomMargin: 43
        clip: false

        Row {
            id: row
            height: 50
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 50
            anchors.rightMargin: 50
            anchors.topMargin: 60
            leftPadding: 0

            Button {
                id: findProjectButton
                text: qsTr("Find Project")
                anchors.left: parent.left
                anchors.leftMargin: 150
                highlighted: true
                onClicked: fileDialog.open()
            }

            Button {
                id: newProjectButton
                text: qsTr("Create New Project")
                anchors.right: parent.right
                anchors.rightMargin: 150
                highlighted: true
                onClicked: createProjectDialog.open()
            }
        }

        FileDialog {
            id: fileDialog
            title: "Select a Project"
            nameFilters: ["QML Projects (*.qmlproject)", "All files (*)"]

            onAccepted: {
                console.log("Project selected:", fileDialog.selectedFile)
                projectLoadConfirmationDialog.open();
            }
        }

        Rectangle {
            id: rectangle1
            height: 200
            opacity: 1
            visible: true
            color: "#91303030"
            radius: 12
            border.width: 10
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 100
            anchors.rightMargin: 100
            anchors.verticalCenterOffset: 60

            ListView {
                id: recentProjectsList
                anchors.fill: parent
                anchors.margins: 20
                layer.enabled: false
                clip: true // hides items outside the bounds
                model: recentProjectsModel

                delegate: Rectangle {
                    width: recentProjectsList.width
                    height: 60
                    color: mouseArea.containsMouse ? "#e8f0fe" : "transparent"

                    Column {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.left: parent.left
                        anchors.leftMargin: 16

                        Text {
                            text: model.name
                            font.pixelSize: 14
                            font.bold: true
                        }
                        Text {
                            text: model.path
                            font.pixelSize: 11
                            color: "#888"
                        }
                    }

                    Text {
                        text: model.lastOpened
                        anchors.right: parent.right
                        anchors.rightMargin: 16
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#aaa"
                        font.pixelSize: 11
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: () => {
                            selectedProjectName = model.name;
                            selectedProjectPath = model.path;
                            projectLoadConfirmationDialog.open();
                        }
                    }
                }

                CreateProjectDialog {
                    id: createProjectDialog
                    margins: -1
                    padding: 24
                    onProjectCreated: (path, name ) => {
                        console.log("project " + name + " created at " + "path");
                        selectedProjectName = name;
                        selectedProjectPath = path;
                        projectLoadConfirmationDialog.open();
                        }

                }
            }

            ProjectLoadConfirmationDialog {
                id: projectLoadConfirmationDialog
                onConfirmProjectLoad: () => {
                    console.log("Project Printed;")
                    confirmedProject(selectedProjectName, selectedProjectPath)
                }
            }



        }



        ListModel {
            id: recentProjectsModel

            ListElement {
                name: "My App"
                path: "/home/user/projects/myapp"
                lastOpened: "2 days ago"
            }
            ListElement {
                name: "Dashboard"
                path: "/home/user/projects/dash"
                lastOpened: "1 week ago"
            }
            ListElement {
                name: "Blah Blah Blah"
                path: "/something/something/something"
                lastOpened: "1 week ago"
            }
            ListElement {
                name: "Blah Blah Blah"
                path: "/something/something/something"
                lastOpened: "1 week ago"
            }
            ListElement {
                name: "Blah Blah Blah"
                path: "/something/something/something"
                lastOpened: "1 week ago"
            }
            ListElement {
                name: "Blah Blah Blah"
                path: "/something/something/something"
                lastOpened: "1 week ago"
            }
            ListElement {
                name: "Blah Blah Blah"
                path: "/something/something/something"
                lastOpened: "1 week ago"
            }
            ListElement {
                name: "Blah Blah Blah"
                path: "/something/something/something"
                lastOpened: "1 week ago"
            }
            ListElement {
                name: "Blah Blah Blah"
                path: "/something/something/something"
                lastOpened: "1 week ago"
            }
        }
    }
}
