import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: root
    width: 1280
    height: 800
    color: "#0d0d0f"

    // ─── Color Palette ───────────────────────────────────────────────
    QtObject {
        id: palette
        readonly property color background:     "#0d0d0f"
        readonly property color surface:        "#16171a"
        readonly property color surfaceAlt:     "#1e1f24"
        readonly property color border:         "#2a2b32"
        readonly property color playhead:       "#00e5ff"
        readonly property color accent:         "#ff5c57"
        readonly property color textPrimary:    "#e8e8ec"
        readonly property color textMuted:      "#555762"
        readonly property color waveformFill:   "#1a3a4a"
        readonly property color waveformStroke: "#2a6a8a"
    }

    // ─── Fake Playhead State (replace with real model at runtime) ────
    QtObject {
        id: transport
        property real position: 0.0        // 0.0 – 1.0 normalized
        property bool playing: false
        property real zoom: 1.0            // 1.0 = fit to view
        property string timeDisplay: "00:00.000"
        property string bpm: "128.0"
        property string sampleRate: "44100 Hz"
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        anchors.leftMargin: 100
        anchors.rightMargin: 100
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        spacing: 0

        // ─── Top Bar ─────────────────────────────────────────────────
        Rectangle {
            id: topBar
            Layout.fillWidth: true
            height: 48
            color: palette.surface
            z: 10

            Rectangle {
                anchors.bottom: parent.bottom
                width: parent.width
                height: 1
                color: palette.border
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 100
                anchors.rightMargin: 100
                spacing: 12

                // File name / track label
                ComboBox {
                    font.pixelSize: 13
                    font.family: "Courier New"
                    font.weight: Font.Medium
                    model: ListModel {
                        id: fruitModel
                        ListElement { text: "Bird01.wav" }
                        ListElement { text: "Bird02.wav" }
                    }
                }

                Rectangle { color: palette.border; width: 1; height: 24 }

                Text {
                    text: transport.sampleRate
                    color: palette.textMuted
                    font.pixelSize: 11
                    font.family: "Courier New"
                }

                Text {
                    text: "32-bit float"
                    color: palette.textMuted
                    font.pixelSize: 11
                    font.family: "Courier New"
                }

                Item { Layout.fillWidth: true }

                // Zoom controls
                Text {
                    text: "ZOOM"
                    color: palette.textMuted
                    font.pixelSize: 10
                    font.family: "Courier New"
                    font.letterSpacing: 2
                }

                Slider {
                    id: zoomSlider
                    from: 1.0
                    to: 8.0
                    value: transport.zoom
                    implicitWidth: 100
                    implicitHeight: 24

                    background: Rectangle {
                        x: zoomSlider.leftPadding
                        y: zoomSlider.topPadding + zoomSlider.availableHeight / 2 - height / 2
                        width: zoomSlider.availableWidth
                        height: 2
                        color: palette.border
                        Rectangle {
                            width: zoomSlider.visualPosition * parent.width
                            height: parent.height
                            color: palette.playhead
                            opacity: 0.6
                        }
                    }
                    handle: Rectangle {
                        x: zoomSlider.leftPadding + zoomSlider.visualPosition * zoomSlider.availableWidth - width / 2
                        y: zoomSlider.topPadding + zoomSlider.availableHeight / 2 - height / 2
                        width: 12; height: 12
                        radius: 6
                        color: palette.playhead
                    }

                    onValueChanged: transport.zoom = value
                }
            }
        }

        // ─── Main Content Area ───────────────────────────────────────
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            RowLayout {
                anchors.fill: parent
                spacing: 0

                // ── Frequency Axis ───────────────────────────────────
                Rectangle {
                    id: freqAxis
                    width: 56
                    Layout.fillHeight: true
                    color: palette.surface

                    Rectangle {
                        anchors.right: parent.right
                        width: 1
                        height: parent.height
                        color: palette.border
                    }

                    // Frequency labels — positions are approximate log-scale
                    // At runtime, calculate y from: y = (1 - log(f/minF)/log(maxF/minF)) * height
                    Repeater {
                        model: [
                            { label: "20k", pos: 0.02 },
                            { label: "10k", pos: 0.10 },
                            { label: "4k",  pos: 0.22 },
                            { label: "1k",  pos: 0.43 },
                            { label: "440", pos: 0.55 },
                            { label: "100", pos: 0.74 },
                            { label: "20",  pos: 0.97 }
                        ]

                        delegate: Item {
                            x: 0
                            y: modelData.pos * freqAxis.height - 8
                            width: freqAxis.width
                            height: 16

                            Text {
                                anchors.right: parent.right
                                anchors.rightMargin: 8
                                anchors.verticalCenter: parent.verticalCenter
                                text: modelData.label
                                color: palette.textMuted
                                font.pixelSize: 9
                                font.family: "Courier New"
                            }

                            // Tick mark
                            Rectangle {
                                anchors.right: parent.right
                                anchors.verticalCenter: parent.verticalCenter
                                width: 4
                                height: 1
                                color: palette.border
                            }
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "Hz"
                        color: palette.textMuted
                        font.pixelSize: 9
                        font.family: "Courier New"
                        font.letterSpacing: 2
                        rotation: -90
                    }
                }

                // ── Spectrogram + Waveform Overview ─────────────────
                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    ColumnLayout {
                        anchors.fill: parent
                        spacing: 0

                        // ── Spectrogram View ─────────────────────────
                        Rectangle {
                            id: spectrogramContainer
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            color: palette.background
                            clip: true

                            // The spectrogram image — swap this Image source
                            // at runtime with your rendered QImage/QPixmap

                            Image {
                                id: spectrogramImage
                                anchors.fill: parent
                                source: "images/SpectMock.png"
                                scale: zoomSlider.value
                                mirror: false
                                asynchronous: true          // set from C++: spectrogramImage.source = "image://spectrogram/render"
                                fillMode: Image.PreserveAspectCrop
                                smooth: false    // keep pixel-sharp FFT bins
                            }

                            // Placeholder shown when no file is loaded
                            Rectangle {
                                anchors.fill: parent
                                color: "transparent"
                                visible: spectrogramImage.source == ""

                                // Faint grid lines for aesthetics in empty state
                                Repeater {
                                    model: 8
                                    Rectangle {
                                        y: index * (spectrogramContainer.height / 8)
                                        width: spectrogramContainer.width
                                        height: 1
                                        color: palette.border
                                        opacity: 0.4
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: "Drop an audio file to begin"
                                    color: palette.textMuted
                                    font.pixelSize: 14
                                    font.family: "Courier New"
                                    font.letterSpacing: 3
                                }
                            }

                            // Horizontal frequency grid lines (drawn over image)
                            Repeater {
                                model: [0.02, 0.10, 0.22, 0.43, 0.55, 0.74, 0.97]
                                Rectangle {
                                    y: modelData * spectrogramContainer.height
                                    width: spectrogramContainer.width
                                    height: 1
                                    color: "#ffffff"
                                    opacity: 0.06
                                }
                            }

                            // ── Playhead ─────────────────────────────
                            Rectangle {
                                id: playhead
                                x: transport.position * spectrogramContainer.width - width / 2
                                y: 0
                                width: 2
                                height: spectrogramContainer.height
                                color: palette.playhead
                                opacity: 0.9
                                z: 20

                                // Glow effect
                                Rectangle {
                                    anchors.centerIn: parent
                                    width: 8
                                    height: parent.height
                                    color: palette.playhead
                                    opacity: 0.15
                                }

                                // Playhead top handle
                                Rectangle {
                                    anchors.horizontalCenter: parent.horizontalCenter
                                    y: 0
                                    width: 12
                                    height: 12
                                    radius: 2
                                    color: palette.playhead

                                    Rectangle {
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        anchors.top: parent.bottom
                                        width: 2
                                        height: 8
                                        color: palette.playhead
                                    }
                                }
                            }

                            // ── Mouse Area for seeking ────────────────
                            MouseArea {
                                anchors.fill: parent
                                onClicked: (mouse) => {
                                    transport.position = mouse.x / spectrogramContainer.width
                                    // At runtime: player.setPosition(transport.position * player.duration)
                                }
                                onPositionChanged: (mouse) => {
                                    if (pressed) {
                                        transport.position = Math.max(0, Math.min(1, mouse.x / spectrogramContainer.width))
                                    }
                                }
                            }
                        }

                        // ── Time Axis ────────────────────────────────
                        Rectangle {
                            id: timeAxis
                            Layout.fillWidth: true
                            height: 24
                            color: palette.surface

                            Rectangle {
                                anchors.top: parent.top
                                width: parent.width
                                height: 1
                                color: palette.border
                            }

                            // Time tick marks — populate with Repeater at runtime
                            Repeater {
                                model: 11   // 0% to 100% in 10% steps
                                Item {
                                    x: (index / 10) * timeAxis.width
                                    width: 1
                                    height: timeAxis.height

                                    Rectangle {
                                        anchors.top: parent.top
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        width: 1
                                        height: 6
                                        color: palette.border
                                    }

                                    Text {
                                        anchors.top: parent.top
                                        anchors.topMargin: 8
                                        anchors.horizontalCenter: parent.horizontalCenter
                                        text: (index * 10) + "s"    // replace with real timestamps
                                        color: palette.textMuted
                                        font.pixelSize: 9
                                        font.family: "Courier New"
                                    }
                                }
                            }
                        }

                        // ── Waveform Overview Strip ──────────────────
                        Rectangle {
                            id: waveformStrip
                            Layout.fillWidth: true
                            height: 52
                            color: palette.surfaceAlt
                            clip: true

                            Rectangle {
                                anchors.top: parent.top
                                width: parent.width
                                height: 1
                                color: palette.border
                            }

                            // Waveform image — set source from C++ at runtime
                            Image {
                                id: waveformImage
                                anchors.fill: parent
                                source: ""
                                fillMode: Image.Stretch
                                smooth: true
                            }

                            // Placeholder waveform bars (design-time only)
                            Row {
                                anchors.fill: parent
                                anchors.margins: 2
                                spacing: 1
                                visible: waveformImage.source == ""

                                Repeater {
                                    model: 120
                                    Rectangle {
                                        width: 3
                                        height: Math.random() * (waveformStrip.height - 8) + 4
                                        anchors.verticalCenter: parent ? parent.verticalCenter : undefined
                                        color: palette.waveformFill
                                        radius: 1
                                    }
                                }
                            }

                            // Viewport indicator rectangle (shows which portion is visible)
                            Rectangle {
                                id: viewportIndicator
                                x: 0
                                width: parent.width / transport.zoom
                                height: parent.height
                                color: "#ffffff"
                                opacity: 0.07
                                border.color: "#ffffff"
                                border.width: 1

                                MouseArea {
                                    anchors.fill: parent
                                    drag.target: viewportIndicator
                                    drag.axis: Drag.XAxis
                                    drag.minimumX: 0
                                    drag.maximumX: waveformStrip.width - viewportIndicator.width
                                }
                            }

                            // Playhead position on waveform strip
                            Rectangle {
                                x: transport.position * waveformStrip.width
                                width: 1
                                height: parent.height
                                color: palette.playhead
                                opacity: 0.8
                            }
                        }

                        // ScrollView {
                        //     id: scrollView
                        //     width: 200
                        //     height: 200
                        // }
                    }
                }
            }
        }

        // ─── Transport Controls ───────────────────────────────────────
        Rectangle {
            id: transportBar
            Layout.fillWidth: true
            height: 72
            color: palette.surface

            Rectangle {
                anchors.top: parent.top
                width: parent.width
                height: 1
                color: palette.border
            }

            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 16

                // ── Playback Buttons ─────────────────────────────────
                RowLayout {
                    spacing: 8

                    // Skip to start
                    RoundButton {
                        id: skipStartBtn
                        width: 36; height: 36
                        radius: 4
                        flat: true
                        background: Rectangle {
                            color: skipStartBtn.hovered ? palette.surfaceAlt : "transparent"
                            radius: 4
                        }
                        contentItem: Text {
                            text: "⏮"
                            color: palette.textPrimary
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: transport.position = 0.0
                    }

                    // Play / Pause
                    RoundButton {
                        id: playPauseBtn
                        width: 44; height: 44
                        radius: 22
                        background: Rectangle {
                            radius: 22
                            color: transport.playing ? palette.accent : palette.playhead
                        }
                        contentItem: Text {
                            text: transport.playing ? "⏸" : "▶"
                            color: "#000000"
                            font.pixelSize: 16
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: transport.playing = !transport.playing
                    }

                    // Skip to end
                    RoundButton {
                        id: skipEndBtn
                        width: 36; height: 36
                        radius: 4
                        flat: true
                        background: Rectangle {
                            color: skipEndBtn.hovered ? palette.surfaceAlt : "transparent"
                            radius: 4
                        }
                        contentItem: Text {
                            text: "⏭"
                            color: palette.textPrimary
                            font.pixelSize: 14
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: transport.position = 1.0
                    }
                }

                Rectangle { color: palette.border; width: 1; height: 40 }

                // ── Time Display ─────────────────────────────────────
                Rectangle {
                    width: 120; height: 40
                    color: palette.background
                    radius: 4
                    border.color: palette.border
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: transport.timeDisplay
                        color: palette.playhead
                        font.pixelSize: 18
                        font.family: "Courier New"
                        font.weight: Font.Bold
                    }
                }

                // ── Seek Slider ──────────────────────────────────────
                Slider {
                    id: seekSlider
                    Layout.fillWidth: true
                    from: 0.0
                    to: 1.0
                    value: transport.position
                    implicitHeight: 32

                    background: Item {
                        x: seekSlider.leftPadding
                        y: seekSlider.topPadding + seekSlider.availableHeight / 2 - height / 2
                        width: seekSlider.availableWidth
                        height: 4

                        // Track background
                        Rectangle {
                            anchors.fill: parent
                            radius: 2
                            color: palette.border
                        }

                        // Progress fill
                        Rectangle {
                            width: seekSlider.visualPosition * parent.width
                            height: parent.height
                            radius: 2
                            color: palette.playhead
                            opacity: 0.7
                        }
                    }

                    handle: Rectangle {
                        x: seekSlider.leftPadding + seekSlider.visualPosition * seekSlider.availableWidth - width / 2
                        y: seekSlider.topPadding + seekSlider.availableHeight / 2 - height / 2
                        width: 16; height: 16
                        radius: 8
                        color: palette.playhead
                        border.color: "#000000"
                        border.width: 2
                    }

                    onMoved: transport.position = value
                }

                Rectangle { color: palette.border; width: 1; height: 40 }

                // ── Volume Knob / Fader ───────────────────────────────
                ColumnLayout {
                    spacing: 4

                    Text {
                        text: "Vol"
                        color: palette.textMuted
                        font.pixelSize: 9
                        font.family: "Courier New"
                        font.letterSpacing: 2
                        Layout.alignment: Qt.AlignHCenter
                    }

                    Slider {
                        id: gainSlider
                        from: 0.0
                        to: 1.0
                        value: 0.8
                        implicitWidth: 80
                        implicitHeight: 24

                        background: Item {
                            x: gainSlider.leftPadding
                            y: gainSlider.topPadding + gainSlider.availableHeight / 2 - height / 2
                            width: gainSlider.availableWidth
                            height: 3
                            Rectangle {
                                anchors.fill: parent
                                radius: 1
                                color: palette.border
                            }
                            Rectangle {
                                width: gainSlider.visualPosition * parent.width
                                height: parent.height
                                radius: 1
                                color: palette.accent
                            }
                        }
                        handle: Rectangle {
                            x: gainSlider.leftPadding + gainSlider.visualPosition * gainSlider.availableWidth - width / 2
                            y: gainSlider.topPadding + gainSlider.availableHeight / 2 - height / 2
                            width: 12; height: 12
                            radius: 6
                            color: palette.accent
                        }
                    }
                }
            }
        }
    }
}
