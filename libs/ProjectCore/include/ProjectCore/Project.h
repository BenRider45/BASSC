#pragma once
#include <QObject>
#include <QString>

// Forward-declare anything heavy your project holds
// class SceneModel;

class Project : public QObject {
  Q_OBJECT

  Q_PROPERTY(QString name READ name NOTIFY nameChanged)
  Q_PROPERTY(QString filePath READ filePath NOTIFY filePathChanged)
  Q_PROPERTY(bool isDirty READ isDirty NOTIFY isDirtyChanged)

public:
  // New project constructor
  explicit Project(const QString &name, const QString &filePath,
                   QObject *parent = nullptr);

  // Empty constructor — call load() after construction
  explicit Project(QObject *parent = nullptr);

  QString name() const;
  QString filePath() const;
  bool isDirty() const;

  bool load(const QString &filePath);
  bool save();
  bool saveAs(const QString &newFilePath);

  // Call this whenever the project data is modified
  void markDirty();

signals:
  void nameChanged();
  void filePathChanged();
  void isDirtyChanged();

private:
  QString m_name;
  QString m_filePath;
  bool m_isDirty = false;
};
