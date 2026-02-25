


/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs

import BASSUI

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: "#2f2f2f"
    z: 98
    property bool isLoading: false
    property string projectName: ""
    property bool isProjectLoaded: false
    state: "ProjectSelection"

    ToolBar {
        id: toolBar
        width: 830
        height: 81
        opacity: 0.334
        z: 98
        position: ToolBar.Footer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 73
        layer.enabled: false
        antialiasing: true
        bottomInset: 25
        bottomPadding: 50
        topPadding: 0
    }

    ProjectSelectWindow {
        id: projectSelectScreen
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: 1
        anchors.verticalCenterOffset: 1
        color: "#dcdcdc"
        opacity: 1
        radius: 75
        onConfirmedProject: (projName, projPath) => {
                                isLoading = true
                            }
    }

    LoadingSplashScreen {
        id: loadingSplashScreen
        onProjectLoaded: () =>{
                             isProjectLoaded = true;
                             isLoading = false;
                         }
    }

    MainView {
        id: mainView
        anchors.fill: parent
        visible: false
    }

    states: [
        State {
            name: "ProjectSelection"

            PropertyChanges {
                target: loadingSplashScreen
                x: 0
                y: 0
                visible: false
            }

            PropertyChanges {
                target: mainView
                x: -8
                y: 0
                visible: false
            }

            PropertyChanges {
                target: projectSelectScreen
                anchors.verticalCenterOffset: 1
                anchors.horizontalCenterOffset: 1
            }
        },
        State {
            name: "LoadingState"
            when: isLoading

            PropertyChanges {
                target: projectSelectScreen
                visible: false
            }

            PropertyChanges {
                target: loadingSplashScreen
                x: 760
                y: 390
            }

            PropertyChanges {
                target: mainView
                visible: false
            }
        },
        State {
            name: "MainAppView"
            when: isProjectLoaded

            PropertyChanges {
                target: projectSelectScreen
                visible: false
                anchors.verticalCenterOffset: -147
                anchors.horizontalCenterOffset: -603
            }

            PropertyChanges {
                target: loadingSplashScreen
                x: -604
                y: -148
                visible: false
            }

            PropertyChanges {
                target: mainView
                x: 0
                y: 0
                width: 1920
                height: 1080
                visible: true
            }
        }
    ]
}
