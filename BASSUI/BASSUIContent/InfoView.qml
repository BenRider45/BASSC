import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: infoView
    color: "#053084"
    TabBar {
        id: tabBar
        y: 0
        width: 641
        height: 48
        anchors.horizontalCenter: parent.horizontalCenter
        leftPadding: 0
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

    StackLayout {
        id: stackLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tabBar1.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        currentIndex: tabBar.currentIndex

        SyllableView {
            id: syllablesView
            color: "#fff52f"
        }

        UtilitiesView {
            id: utilitiesView
        }

        NotesView {
            id: notesView
        }

        SignalInfoView {
            id: signalInfoView
        }

        SyllableView {
            id: rectangle
        }




    }
}
