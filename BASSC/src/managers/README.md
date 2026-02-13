# Backend Manager Skeletons

## ⚠️ IMPORTANT

**These are SKELETON files only. They contain NO implementation.**

All methods are empty stubs with TODO comments. Do NOT expect any functionality from these classes until they are manually implemented.

## Purpose

These skeleton classes define the interface between the QML UI and the future C++ backend. They serve as:

1. **Interface contracts** - Define what methods the UI expects
2. **Documentation** - Show what needs to be implemented
3. **Compilation placeholders** - Allow project to build without backend

## Files

### ProjectManager
**File:** `ProjectManager.h` / `ProjectManager.cpp`

**Responsibility:** Project lifecycle management

**Methods to implement:**
- `createProject(name, path)` - Create new project structure
- `openProject(path)` - Load existing project
- `saveProject()` - Save current project state
- `closeProject()` - Close current project
- `getRecentProjects()` - Retrieve recent project list

**Signals:**
- `projectCreated(path)`
- `projectOpened(path)`
- `projectSaved()`
- `projectClosed()`
- `errorOccurred(message)`

**Do NOT implement here:**
- File I/O operations
- Project directory management
- Configuration parsing
- Data persistence

---

### AudioManager
**File:** `AudioManager.h` / `AudioManager.cpp`

**Responsibility:** Audio file management and playback

**Methods to implement:**
- `loadAudioFile(filePath)` - Load audio file
- `play()` - Start playback
- `pause()` - Pause playback
- `stop()` - Stop playback
- `seek(position)` - Seek to position
- `getSpectrogram(filePath)` - Generate spectrogram image
- `getAudioFiles()` - List audio files in project

**Signals:**
- `spectrogramReady(image)`
- `playbackStateChanged()`
- `positionChanged()`
- `errorOccurred(message)`

**Do NOT implement here:**
- Audio file I/O
- Audio processing (FFT, STFT)
- Spectrogram generation algorithms
- Audio codec handling

---

### ModelManager
**File:** `ModelManager.h` / `ModelManager.cpp`

**Responsibility:** ML model training and evaluation

**Methods to implement:**
- `startTraining()` - Begin model training
- `stopTraining()` - Stop training
- `exportModel(path)` - Export trained model
- `loadModel(path)` - Load existing model
- `getMetrics()` - Get performance metrics
- `getConfusionMatrix()` - Get confusion matrix data
- `predict(features)` - Run model inference

**Signals:**
- `trainingProgressChanged(epoch, total)`
- `metricsChanged()`
- `modelExported(path)`
- `predictionReady(label)`
- `errorOccurred(message)`

**Do NOT implement here:**
- ML training algorithms
- Model architecture
- Data preprocessing
- Evaluation logic

---

## Integration Steps

### 1. Register Singletons in main.cpp

```cpp
#include "managers/ProjectManager.h"
#include "managers/AudioManager.h"
#include "managers/ModelManager.h"

// In main() before engine.load():
qmlRegisterSingletonType<ProjectManager>(
    "BASSC.Managers", 1, 0, "ProjectManager",
    [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        return new ProjectManager();
    }
);

qmlRegisterSingletonType<AudioManager>(
    "BASSC.Managers", 1, 0, "AudioManager",
    [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        return new AudioManager();
    }
);

qmlRegisterSingletonType<ModelManager>(
    "BASSC.Managers", 1, 0, "ModelManager",
    [](QQmlEngine *engine, QJSEngine *scriptEngine) -> QObject * {
        Q_UNUSED(engine)
        Q_UNUSED(scriptEngine)
        return new ModelManager();
    }
);
```

### 2. Add to CMakeLists.txt

```cmake
qt_add_qml_module(appBASSC
    # ... existing QML_FILES ...
    SOURCES
        src/managers/ProjectManager.h
        src/managers/ProjectManager.cpp
        src/managers/AudioManager.h
        src/managers/AudioManager.cpp
        src/managers/ModelManager.h
        src/managers/ModelManager.cpp
        # ... other sources ...
)
```

### 3. Use in QML

```qml
import BASSC.Managers 1.0

Button {
    text: "New Project"
    onClicked: {
        ProjectManager.createProject(projectName, projectPath)
    }
}

Connections {
    target: ProjectManager
    function onProjectCreated(path) {
        console.log("Project created:", path)
        // Navigate to next page
    }
}
```

## Implementation Guidelines

### When implementing these classes:

1. **Separate concerns**
   - Manager classes should coordinate, not implement
   - Delegate actual work to specialized classes
   - Keep managers as thin adapters to QML

2. **Use existing backend code**
   - Connect to `Project` class in `libs/Project/`
   - Use appropriate audio libraries (Qt Multimedia, FFTW, etc.)
   - Integrate with ML framework (PyTorch, TensorFlow, etc.)

3. **Error handling**
   - Always emit `errorOccurred(message)` on failures
   - Validate inputs before processing
   - Provide descriptive error messages for UI

4. **Async operations**
   - Long operations should be asynchronous
   - Use Qt's signals/slots for progress updates
   - Consider QtConcurrent or QThread for heavy work

5. **Testing**
   - Create unit tests for each manager
   - Test signal emissions
   - Mock backend dependencies

## Example Implementation Pattern

```cpp
void ProjectManager::createProject(const QString &name, const QString &path)
{
    // Validate inputs
    if (name.isEmpty() || path.isEmpty()) {
        emit errorOccurred("Project name and path cannot be empty");
        return;
    }

    try {
        // Use backend Project class (from libs/Project/)
        Project project(path.toStdString(), "wav_dir");

        // Update state
        m_currentProjectName = name;
        m_currentProjectPath = path;
        emit currentProjectChanged();

        // Add to recent projects
        addToRecentProjects(path);

        // Notify success
        emit projectCreated(path);

    } catch (const std::exception &e) {
        emit errorOccurred(QString("Failed to create project: %1").arg(e.what()));
    }
}
```

## Current Status

- ✅ Skeleton interfaces defined
- ✅ Method signatures documented
- ⬜ Manager implementations (TODO)
- ⬜ Backend integration (TODO)
- ⬜ Unit tests (TODO)

## Notes

- These files are **optional** - UI works without them
- All current QML uses `console.log()` for backend operations
- Replace console.log calls with manager methods when implemented
- Keep skeleton/implementation separation clear in commits
