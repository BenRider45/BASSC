import QtQuick
import QtQuick.Controls


Window {
    id: mainWindow
    width: 640
    height: 480
    visible: true
    title: qsTr("BASSC")
    Column{
        anchors.horizontalCenter: parent.horizontalCenter

        Text {
            id: titleText
            text: "BASSC"
            y: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 24; font.bold: true
        }


        Button{
            id: button1
            y: parent.verticalCenter
            text: "Button1"
            onClicked: {
                console.log("Button Printed");
                titleText.parent.y += 100;
            }

        }

    }
}
