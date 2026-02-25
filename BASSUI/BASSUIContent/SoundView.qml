import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: soundView
    color: "#ffffff"
    TabBar {
        id: tabBar1
        y: 0
        height: 48
        contentWidth: parent.width
        padding: 0
        
        TabButton {
            id: tabButton
            x: 0
            text: qsTr("Spectrogram")
        }
        
        TabButton {
            id: tabButton1
            x: 320
            text: qsTr("Classification Model")
        }
    }

    StackLayout {
        id: stackLayout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: tabBar1.bottom
        anchors.bottom: parent.bottom
        anchors.leftMargin: 100
        anchors.rightMargin: 100
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        currentIndex: tabBar1.currentIndex

        SpectrogramViewSlop {
            id: spectrogramView
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.margins: 100
        }

        ClassificationModelView {
            id: classificationModelView
        }


    }


}
