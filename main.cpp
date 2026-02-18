#include "libs/ProjectCore/include/ProjectCore/ProjectHandler.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSettings>

int main(int argc, char *argv[]) {
  QGuiApplication app(argc, argv);

  QSettings settings("JinGroup", "BASSC");

  QQmlApplicationEngine engine;
  engine.rootContext()->setContextProperty("projectHandler",
                                           &ProjectHandler::instance());
  QObject::connect(
      &engine, &QQmlApplicationEngine::objectCreationFailed, &app,
      []() { QCoreApplication::exit(-1); }, Qt::QueuedConnection);
  engine.loadFromModule("BASSC", "Main");

  return app.exec();
}
