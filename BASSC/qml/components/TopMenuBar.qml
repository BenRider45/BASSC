import QtQuick
import QtQuick.Controls

MenuBar {
    id: topMenuBar

    signal newProjectClicked()
    signal openProjectClicked()
    signal saveProjectClicked()
    signal settingsClicked()

    Menu {
        title: qsTr("&File")

        MenuItem {
            text: qsTr("&New Project")
            onTriggered: topMenuBar.newProjectClicked()
        }

        MenuItem {
            text: qsTr("&Open Project")
            onTriggered: topMenuBar.openProjectClicked()
        }

        MenuItem {
            text: qsTr("&Save Project")
            onTriggered: topMenuBar.saveProjectClicked()
        }

        MenuSeparator {}

        MenuItem {
            text: qsTr("E&xit")
            onTriggered: Qt.quit()
        }
    }

    Menu {
        title: qsTr("&Settings")

        MenuItem {
            text: qsTr("&Preferences")
            onTriggered: topMenuBar.settingsClicked()
        }
    }
}
