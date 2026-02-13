#ifndef MODELMANAGER_H
#define MODELMANAGER_H

#include <QObject>
#include <QString>
#include <QVariantMap>
#include <QVariantList>

/**
 * @brief Skeleton interface for classification model management
 *
 * TODO: Implement all methods manually
 * - Do NOT implement ML training logic here
 * - Do NOT implement model evaluation here
 * - Do NOT implement file I/O here
 * - Connect to actual ML framework when ready
 */
class ModelManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isTraining READ isTraining NOTIFY trainingStateChanged)
    Q_PROPERTY(int currentEpoch READ currentEpoch NOTIFY trainingProgressChanged)
    Q_PROPERTY(int totalEpochs READ totalEpochs NOTIFY trainingProgressChanged)
    Q_PROPERTY(qreal accuracy READ accuracy NOTIFY metricsChanged)

public:
    explicit ModelManager(QObject *parent = nullptr);

    // Property getters
    bool isTraining() const { return m_isTraining; }
    int currentEpoch() const { return m_currentEpoch; }
    int totalEpochs() const { return m_totalEpochs; }
    qreal accuracy() const { return m_accuracy; }

public slots:
    // TODO: Implement model training
    void startTraining();

    // TODO: Implement training stop
    void stopTraining();

    // TODO: Implement model export
    void exportModel(const QString &path);

    // TODO: Implement model loading
    void loadModel(const QString &path);

    // TODO: Implement metrics retrieval
    QVariantMap getMetrics();

    // TODO: Implement confusion matrix retrieval
    QVariantList getConfusionMatrix();

    // TODO: Implement prediction
    QString predict(const QVariantMap &features);

signals:
    void trainingStateChanged();
    void trainingProgressChanged(int epoch, int total);
    void metricsChanged();
    void modelExported(const QString &path);
    void modelLoaded(const QString &path);
    void predictionReady(const QString &label);
    void errorOccurred(const QString &message);

private:
    bool m_isTraining = false;
    int m_currentEpoch = 0;
    int m_totalEpochs = 100;
    qreal m_accuracy = 0.0;

    // TODO: Add model state management members
};

#endif // MODELMANAGER_H
