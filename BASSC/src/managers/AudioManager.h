#ifndef AUDIOMANAGER_H
#define AUDIOMANAGER_H

#include <QObject>
#include <QString>
#include <QImage>
#include <QStringList>

/**
 * @brief Skeleton interface for audio file management
 *
 * TODO: Implement all methods manually
 * - Do NOT implement audio processing logic here
 * - Do NOT implement spectrogram generation here
 * - Do NOT implement file I/O here
 * - Connect to actual audio processing library when ready
 */
class AudioManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString currentFile READ currentFile NOTIFY currentFileChanged)
    Q_PROPERTY(qreal duration READ duration NOTIFY durationChanged)
    Q_PROPERTY(qreal position READ position NOTIFY positionChanged)
    Q_PROPERTY(bool isPlaying READ isPlaying NOTIFY playbackStateChanged)

public:
    explicit AudioManager(QObject *parent = nullptr);

    // Property getters
    QString currentFile() const { return m_currentFile; }
    qreal duration() const { return m_duration; }
    qreal position() const { return m_position; }
    bool isPlaying() const { return m_isPlaying; }

public slots:
    // TODO: Implement audio file loading
    void loadAudioFile(const QString &filePath);

    // TODO: Implement audio playback
    void play();

    // TODO: Implement audio pause
    void pause();

    // TODO: Implement audio stop
    void stop();

    // TODO: Implement seek functionality
    void seek(qreal position);

    // TODO: Implement spectrogram generation
    QImage getSpectrogram(const QString &filePath);

    // TODO: Implement audio file list retrieval
    QStringList getAudioFiles();

signals:
    void currentFileChanged();
    void durationChanged();
    void positionChanged();
    void playbackStateChanged();
    void spectrogramReady(const QImage &spectrogram);
    void errorOccurred(const QString &message);

private:
    QString m_currentFile;
    qreal m_duration = 0.0;
    qreal m_position = 0.0;
    bool m_isPlaying = false;

    // TODO: Add audio processing state members
};

#endif // AUDIOMANAGER_H
