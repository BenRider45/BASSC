

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
    z: 99
    property bool isLoading: false
    property string projectName: ""
    property bool isProjectLoaded: false
    state: "ProjectSelection"

    ToolBar {
        id: toolBar
        x: 545
        y: 926
        width: 830
        height: 81
        opacity: 0.222
        position: ToolBar.Footer
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 73
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

    states: [
        State {
            name: "ProjectSelection"

            PropertyChanges {
                target: loadingSplashScreen
                visible: false
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
        },
        State {
            name: "AnnotationView"
            when: isProjectLoaded

            PropertyChanges {
                target: projectSelectScreen
                visible: false
            }

            PropertyChanges {
                target: loadingSplashScreen
                visible: false
            }
        }
    ]
}
