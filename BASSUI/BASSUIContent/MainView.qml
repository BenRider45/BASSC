import QtQuick
import QtQuick.Controls

Flow {
    id: mainView
    width: 1920
    height: 1080
    property string viewMode: "Annotation";

    Column {
        id: column
        anchors.fill: parent

        Rectangle {
            id: soundView
            width: 200
            color: "#ffffff"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.bottomMargin: 550
            anchors.horizontalCenter: parent.horizontalCenter

            TabBar {
                id: tabBar1
                y: 0
                height: 48
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                padding: 0
                TabButton {
                    id: annotationTab
                    text: qsTr("Tab Button")
                }

                TabButton {
                    id: modelViewTab
                    text: qsTr("Tab Button")
                }
            }
        }

        Rectangle {
            id: infoView
            color: "#053084"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: soundView.bottom
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.topMargin: 0
            anchors.bottomMargin: 0

            TabBar {
                id: tabBar
                y: 0
                height: 48
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.leftMargin: 0
                anchors.rightMargin: 0
                padding: 0

                TabButton {
                    id: syllableListTab
                    text: qsTr("Syllables")
                }

                TabButton {
                    id: utilTab
                    text: qsTr("Utilities")
                }

                TabButton {
                    id: notesTab
                    text: qsTr("Notes")
                }
            }
        }
    }

}
