#pragma once
#include "Project.h"
#include <QDebug>
#include <QObject>

class ProjectHandler : public QObject {
  Q_OBJECT
  Q_PROPERTY(Project *currentProject READ currentProject NOTIFY
                 currentProjectChanged);

public:
  static ProjectHandler &instance();
  ~ProjectHandler() override;

  ProjectHandler(const ProjectHandler &) = delete;
  ProjectHandler &operator=(const ProjectHandler &) = delete;

  Project *currentProject() const;

  Q_INVOKABLE void newProject(const QString &name, const QString &path);
  Q_INVOKABLE bool loadProject(const QString &filePath);
  Q_INVOKABLE bool saveProject();
  Q_INVOKABLE bool saveProjectAs(const QString &filePath);
  Q_INVOKABLE void closeProject();

  Q_INVOKABLE bool hasOpenProject() const;

signals:
  void currentProjectChanged();
  void projectSaved();
  void errorOccured(const QString &message);

private:
  explicit ProjectHandler(QObject *parent = nullptr);

  void setCurrentProject(Project *project);

  Project *m_currentProject = nullptr;
};
