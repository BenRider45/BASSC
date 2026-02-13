# BASSC Quick Start Guide

## Run the Application Now

```bash
# From the BASSC directory:
./build/appBASSC.app/Contents/MacOS/appBASSC
```

The application is already built and ready to run!

## What You'll See

### 1. Project Selection Page (Launch Screen)
- Large "BASSC" title at top
- Recent projects list on left (3 mock projects)
- "New Project" and "Open Project" buttons on right
- Menu bar with File and Settings menus

**Try This:**
- Click "New Project" → enter a name → browse for directory → OK
- Or click on a recent project → automatically opens File Annotation Page

### 2. File Annotation Page
- Play/Pause/Stop buttons at top
- Large spectrogram display (scrollable, with mock visualization)
- Symbol grid at bottom showing A-F symbols
- Tab on right edge to open file browser
- "Go to Model" button in bottom-right corner

**Try This:**
- Click the tab on right edge → file panel slides out
- Click on any audio file → spectrogram updates with file name
- Drag mouse on spectrogram → creates selection box
- Click Play button → see console log
- Click a symbol in the grid → see console log
- Click "Go to Model" → navigates to model page

### 3. Classification Model Page
- Training status (epoch 47/100, 92.3% accuracy)
- Performance metrics grid (8 metrics)
- 6x6 confusion matrix with color coding
- Training history chart
- Start/Stop/Export buttons

**Try This:**
- Hover over confusion matrix cells → see tooltips
- Click Start/Stop Training → see console logs
- View all mock metrics and visualizations

## All Backend Operations Log to Console

Watch the terminal where you launched the app. You'll see output like:

```
Loading project: Sparrow Study 2024
Loading file: sparrow_morning_001.wav
Play audio
Annotation created at: 245 103 size: 156 87
Symbol selected: A
Start training
```

## If You Need to Rebuild

```bash
# Clean build
rm -rf build

# Reconfigure
cmake -B build -S . -DCMAKE_BUILD_TYPE=RelWithDebInfo

# Build
cmake --build build

# Run
./build/appBASSC.app/Contents/MacOS/appBASSC
```

## Navigation Flow

```
Project Selection Page
    ↓ (click New/Open/Recent)
File Annotation Page
    ↓ (click "Go to Model")
Classification Model Page
```

Use the menu bar to access File operations and Settings from any page.

## Mock Data Summary

- **3 recent projects** (Sparrow Study 2024, Finch Analysis, Canary Songs)
- **7 audio files** (sparrow_morning_001.wav, etc.)
- **6 symbols** (A, B, C, D, E, F with counts)
- **Confusion matrix** (6x6 with realistic values)
- **8 performance metrics** (Precision, Recall, F1, etc.)
- **Training progress** (Epoch 47/100, 92.3% accuracy)

## Key Features to Test

1. **Page Navigation** - Move between all three pages
2. **Dialogs** - Open New Project and Open Project dialogs
3. **File Panel** - Slide out/in from right edge
4. **Spectrogram Selection** - Drag to select annotation regions
5. **Symbol Selection** - Click symbols in grid
6. **Controls** - All buttons log actions
7. **Hover Effects** - Confusion matrix, file list, symbol grid
8. **Scrolling** - Spectrogram horizontal scroll, file list vertical scroll

## No Backend Yet

Everything works with mock data. All buttons log to console instead of performing real actions. This is intentional - the UI is ready, backend implementation comes later.

See `UI_README.md` for full documentation.
