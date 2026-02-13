import QtQuick
import QtQuick.Controls
import "pages"

Window {
    id: mainWindow
    width: 1280
    height: 800
    visible: true
    title: qsTr("BASSC")

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: projectSelectionPage

        Component {
            id: projectSelectionPage
            ProjectSelectionPage {
                onNavigateToAnnotation: {
                    stackView.push(fileAnnotationPage)
                }
            }
        }

        Component {
            id: fileAnnotationPage
            FileAnnotationPage {
                onNavigateToModel: {
                    stackView.push(classificationModelPage)
                }
                onNavigateBack: {
                    stackView.pop()
                }
            }
        }

        Component {
            id: classificationModelPage
            ClassificationModelPage {
                onNavigateBack: {
                    stackView.pop()
                }
            }
        }
    }
}
