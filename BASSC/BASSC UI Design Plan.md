> [!tldr]
> This Document is a design plan for the QT Quick UI for BASSC. This doument details the main structure, product flow, and core UI components of the application

# Global Design choices
All windows will have access to a menu-bar at the top of the application, allowing for access to file/project operations (save project, new project, open project), Button to 
    open the settings menu, etc.
    
# Assertions
All c++ classes will be structed as independant liubraries, with their own Cmake files. 
All qt code will be as modular as possible to maxmize reusability

All QT implementations will be independent of later c++ implementation. Skeleton implementations of singleton classes for UI operations are sparsely allowed
# Window Structure
The window structure for this application will have multiple pages, each main functionality of the app being in a different page. Additionally, action which require further configuration and user-selected options will open dialogs in order to gather this information (i.e when "new project" button is pressed a dialog appear to gather directory information, project name, etc.)

## 1. Project selection page 
This window is the first window of the app, this window will handle displaying recent projects in a scrolling combo box for the user to select, along with this there will be buttons to open new project creation dialogs.
### Button layout
Buttons will be in a row grid layout near the middle of the screen. Left side holds open recent project scrolling list box. Project title at the top-center of the screen

## 2. File Annotation window

This file will be used to manually annotate syllables of .wav files within a project directory, At the top center, there will be a large side-scrolling window which will hold the spectrogram of the current audio file. right above this window there will be play pause and stop buttons for playing the file. This spectrogram window will take up about half of the window. Below this there will be a grid list which will display examples of all currently defined symbols, showing the piece of spectrogram image associated with that syllable, along with its label. On the right side there will be a menu bar that slide out upon pressing an exposed tab, in order to select the currently displayed file. 
At the button right corner, there will be a button to switch to page 3, which is the classification model page


# 3. Classification model screen 

This screen will display information regarding the classification model, things such as the confusion matrix, training status, error values, will be displayed in a viewable and easy to digest way. 
