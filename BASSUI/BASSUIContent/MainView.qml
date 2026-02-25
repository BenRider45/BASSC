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

        SoundView {
            id: soundView
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 550
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 100
        }

        InfoView {
            id: infoView
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: soundView.bottom
            anchors.topMargin: 0
        }
    }

}
