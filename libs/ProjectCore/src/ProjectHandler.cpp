#include "../include/ProjectCore/ProjectHandler.h"
#include "../include/ProjectCore/Project.h"
#include <QDebug>

ProjectHandler &ProjectHandler::instance() {
  static ProjectHandler s_inst;
  return s_inst;
}

ProjectHandler::ProjectHandler(QObject *parent) : QObject(parent) {}

ProjectHandler::~ProjectHandler() = default;

Project *ProjectHandler::currentProject() const { return m_currentProject; }

void ProjectHandler::newProject(const QString &name, const QString &path) {
  qDebug() << "New Project!!!\n";
}

bool ProjectHandler::loadProject(const QString &filePath) {
  qDebug() << "Load Project:" << filePath << "\n";
  return true;
}

bool ProjectHandler::saveProject() {
  qDebug() << "Save Project\n";
  return true;
}

bool ProjectHandler::saveProjectAs(const QString &filePath) {
  qDebug() << "Save Project As:" << filePath << "\n";
  return true;
}

void ProjectHandler::closeProject() {
  qDebug() << "Close Project\n";
  setCurrentProject(nullptr);
}

bool ProjectHandler::hasOpenProject() const {
  return m_currentProject != nullptr;
}

void ProjectHandler::setCurrentProject(Project *project) {
  if (m_currentProject != project) {
    m_currentProject = project;
    emit currentProjectChanged();
  }
}
