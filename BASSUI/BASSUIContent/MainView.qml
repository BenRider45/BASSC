import QtQuick
import QtQuick.Controls

Flow {
    id: mainView
    width: 1820
    height: 980
    property string viewMode: "Annotation";

    Column {
        id: column
        anchors.fill: parent
        z: 99

        Rectangle {
            id: soundView
            width: 200
            color: "#ffffff"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 100
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
                contentWidth: parent.width
                padding: 0

                TabButton {
                    id: tabButton
                    x: 890
                    text: qsTr("Spectrogram")
                }

                TabButton {
                    id: tabButton1
                    text: qsTr("Classification Model")
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
                leftPadding: 40
                padding: 0

                TabButton {
                    id: syllableListTab
                    x: 0
                    text: qsTr("Syllables")
                }

                TabButton {
                    id: utilTab
                    x: 434
                    text: qsTr("Utilities")
                }

                TabButton {
                    id: notesTab
                    x: 868
                    text: qsTr("Notes")
                }

                TabButton {
                    id: tabButton2
                    text: qsTr("Signal Info")
                }
            }
        }
    }

}
