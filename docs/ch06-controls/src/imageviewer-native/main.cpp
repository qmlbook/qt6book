#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

// ...

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    // ...

    QQmlApplicationEngine engine;
    QQuickStyle::setStyle("Fusion");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
