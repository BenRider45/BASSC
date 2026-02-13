#ifndef PROJECTMANAGER_H
#define PROJECTMANAGER_H

#include <QObject>
#include <QString>
#include <QStringList>

/**
 * @brief Skeleton interface for project management
 *
 * TODO: Implement all methods manually
 * - Do NOT implement file I/O logic here
 * - Do NOT implement project parsing logic here
 * - Connect to actual Project class when ready
 */
class ProjectManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentProjectName READ currentProjectName NOTIFY currentProjectChanged)
    Q_PROPERTY(QString currentProjectPath READ currentProjectPath NOTIFY currentProjectChanged)
    Q_PROPERTY(bool hasUnsavedChanges READ hasUnsavedChanges NOTIFY unsavedChangesChanged)

public:
    explicit ProjectManager(QObject *parent = nullptr);

    // Property getters
    QString currentProjectName() const { return m_currentProjectName; }
    QString currentProjectPath() const { return m_currentProjectPath; }
    bool hasUnsavedChanges() const { return m_hasUnsavedChanges; }

public slots:
    // TODO: Implement project creation logic
    void createProject(const QString &name, const QString &path);

    // TODO: Implement project loading logic
    void openProject(const QString &path);

    // TODO: Implement project saving logic
    void saveProject();

    // TODO: Implement project closing logic
    void closeProject();

    // TODO: Implement recent projects retrieval
    QStringList getRecentProjects();

signals:
    void currentProjectChanged();
    void unsavedChangesChanged();
    void projectCreated(const QString &path);
    void projectOpened(const QString &path);
    void projectSaved();
    void projectClosed();
    void errorOccurred(const QString &message);

private:
    QString m_currentProjectName;
    QString m_currentProjectPath;
    bool m_hasUnsavedChanges = false;

    // TODO: Add project state management members
};

#endif // PROJECTMANAGER_H
