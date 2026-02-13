# BASSC - Qt Quick UI Documentation

## Overview

This document describes the modular Qt Quick UI implementation for BASSC (Bird Audio Syllable Segmentation and Classification).

## Architecture

### Page-Based Navigation

The application uses a `StackView` for page navigation with three main pages:

1. **Project Selection Page** - Entry point for creating/opening projects
2. **File Annotation Page** - Manual syllable annotation interface
3. **Classification Model Page** - Model training and evaluation

### Directory Structure

```
qml/
├── Main.qml                           # Application entry point with navigation
├── pages/
│   ├── ProjectSelectionPage.qml       # Page 1: Project management
│   ├── FileAnnotationPage.qml         # Page 2: Annotation interface
│   └── ClassificationModelPage.qml    # Page 3: Model dashboard
├── components/
│   ├── TopMenuBar.qml                 # Reusable menu bar (all pages)
│   ├── SpectrogramViewer.qml          # Scrollable spectrogram display
│   ├── SymbolGrid.qml                 # Grid of annotated symbols
│   ├── FileSelectionPanel.qml         # Slide-out file browser
│   └── ConfusionMatrix.qml            # Confusion matrix visualization
└── dialogs/
    └── ProjectDialog.qml              # New/Open project dialog
```

## Page Details

### 1. Project Selection Page

**Purpose:** Application entry point for project management

**Features:**
- Centered application title
- Recent projects list (scrollable)
- Action buttons: New Project, Open Project
- Top menu bar with File and Settings menus

**Mock Data:** Recent projects list with 3 sample projects

**Navigation:** Opens File Annotation Page when project is selected/created

### 2. File Annotation Page

**Purpose:** Manual annotation of syllables in audio files

**Layout:**
- **Top Half:** Spectrogram section
  - Play/Pause/Stop controls
  - Large scrollable spectrogram viewer
  - Mouse selection for annotation regions

- **Bottom Half:** Symbol grid
  - Displays all defined symbols
  - Shows spectrogram snippet and label for each
  - Click to select symbol for annotation

- **Right Side:** File selection panel
  - Slides out from tab on right edge
  - Lists all audio files in project
  - Shows duration and annotation count
  - Search functionality

**Mock Data:**
- 7 sample audio files (sparrow recordings)
- 6 predefined symbols (A-F) with mock counts
- Mock spectrogram visualization

**Navigation:**
- "Go to Model" button (bottom-right) → Classification Model Page
- Menu bar → Project Selection Page (via back)

### 3. Classification Model Page

**Purpose:** Display classification model status and performance

**Sections:**

1. **Training Status**
   - Status indicator (Ready/Training/Error)
   - Current epoch progress
   - Overall accuracy
   - Control buttons: Start/Stop Training, Export Model

2. **Performance Metrics**
   - Grid of metric cards: Precision, Recall, F1 Score, Loss, etc.
   - 8 mock metrics with colored values

3. **Confusion Matrix**
   - 6x6 matrix for symbols A-F
   - Color-coded cells (green = correct, red = misclassified)
   - Hover tooltips with details
   - Visual legend

4. **Training History**
   - Loss curve over epochs
   - Mock chart visualization

**Mock Data:**
- Training at epoch 47/100 with 92.3% accuracy
- Realistic confusion matrix values
- Performance metrics in expected ranges

**Navigation:**
- Menu bar → other pages

## Component Details

### TopMenuBar

**Reusable menu bar component included in all pages**

Signals:
- `newProjectClicked()`
- `openProjectClicked()`
- `saveProjectClicked()`
- `settingsClicked()`

Menus:
- File: New, Open, Save, Exit
- Settings: Preferences

### SpectrogramViewer

**Scrollable spectrogram display with annotation support**

Features:
- Horizontal scrolling for long audio files
- Mock spectrogram visualization (Canvas-based)
- Mouse drag selection for creating annotations
- Displays current file name

Properties:
- `currentFile` (string) - Name of loaded audio file

### SymbolGrid

**Grid view of annotated symbols**

Features:
- 200x150px cards in grid layout
- Each card shows:
  - Mock spectrogram snippet
  - Symbol label
  - Instance count
- Hover effects
- Click to select symbol

Mock Data: 6 symbols (A-F) with different colors

### FileSelectionPanel

**Slide-out file browser panel**

Features:
- Slides from right edge (30px tab when closed)
- 270px wide panel when open
- Search field for filtering
- File list with:
  - File name
  - Duration
  - Annotation count
- File count display at bottom

Mock Data: 7 audio file entries

### ConfusionMatrix

**6x6 confusion matrix visualization**

Features:
- Color-coded cells:
  - Green shades: Correct predictions (diagonal)
  - Red shades: Misclassifications
  - Intensity based on count
- Bold borders on diagonal
- Hover tooltips showing details
- Legend explaining colors
- Row/column labels (A-F)

## Backend Integration Points

### Current State
All backend operations currently use `console.log()` for debugging. The UI is fully functional with mock data.

### Backend Interfaces Needed (Skeletons Only)

**1. ProjectManager (C++ Singleton)**
```cpp
// TODO: Implement these methods manually
Q_INVOKABLE void createProject(QString name, QString path);
Q_INVOKABLE void openProject(QString path);
Q_INVOKABLE void saveProject();
Q_INVOKABLE QStringList getRecentProjects();
```

**2. AudioManager (C++ Singleton)**
```cpp
// TODO: Implement these methods manually
Q_INVOKABLE void loadAudioFile(QString path);
Q_INVOKABLE void play();
Q_INVOKABLE void pause();
Q_INVOKABLE void stop();
Q_INVOKABLE QImage getSpectrogram(QString file);
```

**3. ModelManager (C++ Singleton)**
```cpp
// TODO: Implement these methods manually
Q_INVOKABLE void startTraining();
Q_INVOKABLE void stopTraining();
Q_INVOKABLE void exportModel(QString path);
Q_INVOKABLE QVariantMap getMetrics();
Q_INVOKABLE QVariantList getConfusionMatrix();
```

### Integration Strategy

When backend C++ classes are implemented:

1. Register singletons in `main.cpp`:
```cpp
qmlRegisterSingletonType<ProjectManager>("BASSC", 1, 0, "ProjectManager", ...);
```

2. Replace `console.log()` calls in QML with actual backend calls:
```qml
// Before:
console.log("Loading project:", model.name)

// After:
ProjectManager.openProject(model.path)
```

3. Connect backend signals to update UI:
```qml
Connections {
    target: AudioManager
    function onSpectrogramReady(image) {
        spectrogramViewer.updateImage(image)
    }
}
```

## Build Instructions

```bash
# Configure
cmake -B build -S . -DCMAKE_BUILD_TYPE=RelWithDebInfo

# Build
cmake --build build

# Run
./build/appBASSC.app/Contents/MacOS/appBASSC
```

## Testing the UI

### Project Selection Page
1. Launch application
2. View recent projects list
3. Click "New Project" → enter name and select directory
4. Click "Open Project" → select directory
5. Select a recent project from list → navigates to annotation page

### File Annotation Page
1. From project page, open/create a project
2. Click tab on right edge → file panel slides out
3. Click a file in the list → mock spectrogram updates
4. Click Play/Pause/Stop buttons → check console logs
5. Drag mouse on spectrogram → selection rectangle appears
6. Release → annotation region logged to console
7. Click symbols in bottom grid → selection logged
8. Click "Go to Model" → navigates to model page

### Classification Model Page
1. From annotation page, click "Go to Model"
2. View training status (epoch 47/100, 92.3% accuracy)
3. View performance metrics grid
4. View confusion matrix
5. Hover over matrix cells → tooltips appear
6. View training history chart
7. Click Start/Stop/Export buttons → check console logs

## Design Principles

1. **Modularity** - Each component is self-contained and reusable
2. **Mock Data** - All data is mocked, UI works without backend
3. **Clear Separation** - UI logic separate from business logic
4. **Extensibility** - Easy to add new pages and components
5. **Clarity** - Descriptive names, readable code, TODO comments

## Future Enhancements

- Add annotation label input dialog
- Implement zoom controls for spectrogram
- Add keyboard shortcuts for annotation workflow
- Export annotations to file
- Model training progress visualization (real-time)
- Audio waveform display alongside spectrogram
- Multi-file batch annotation mode
- Project settings dialog implementation
- User preferences persistence

## Notes

- All C++ backend code is SKELETON ONLY
- No real file I/O, audio processing, or ML logic
- TODO comments mark backend integration points
- UI designed for 1280x800 minimum resolution
- All animations use 200ms duration with InOutQuad easing
- Color scheme: Dark blues (#1a1a2e, #0f3460) with accent colors
