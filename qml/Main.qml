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
        anchors.verticalCenter: parent.verticalCenter
        Text {
            id: titleText
            text: "BASSCBALLS"
            y: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: 24; font.bold: true
        }


        Button{
            id: button1
            palette.buttonText: "black"
            y: parent.verticalCenter + 40
            text: "NewProject";
            onClicked: {
              console.log("Button Printed");
              projectHandler.newProject("Blah", "Blah/Blah");
            }

        }

    }
}
