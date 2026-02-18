#include "../include/ProjectCore/Project.h"
#include <QDebug>

Project::Project(const QString &name, const QString &filePath, QObject *parent)
    : QObject(parent), m_name(name), m_filePath(filePath), m_isDirty(false) {
  qDebug() << "Project created:" << name;
}

Project::Project(QObject *parent)
    : QObject(parent), m_isDirty(false) {
  qDebug() << "Empty project created";
}

QString Project::name() const {
  return m_name;
}

QString Project::filePath() const {
  return m_filePath;
}

bool Project::isDirty() const {
  return m_isDirty;
}

bool Project::load(const QString &filePath) {
  qDebug() << "Loading project from:" << filePath;
  // TODO: Implement actual loading logic
  m_filePath = filePath;
  m_isDirty = false;
  emit filePathChanged();
  emit isDirtyChanged();
  return true;
}

bool Project::save() {
  qDebug() << "Saving project to:" << m_filePath;
  // TODO: Implement actual saving logic
  m_isDirty = false;
  emit isDirtyChanged();
  return true;
}

bool Project::saveAs(const QString &newFilePath) {
  qDebug() << "Saving project as:" << newFilePath;
  // TODO: Implement actual saving logic
  m_filePath = newFilePath;
  m_isDirty = false;
  emit filePathChanged();
  emit isDirtyChanged();
  return true;
}

void Project::markDirty() {
  if (!m_isDirty) {
    m_isDirty = true;
    emit isDirtyChanged();
  }
}
