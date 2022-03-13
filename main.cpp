#include <QApplication>
#include <QQmlApplicationEngine>
#include "FileProcess.h"
#include "Reader.h"
int main(int argc, char *argv[])
{
    QApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    //一种设置风格的方法 需要引入Qt+= quickcontrols2    https://blog.csdn.net/zjgo007/article/details/104855648
//    QQuickStyle::setStyle("Universal");
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    qmlRegisterType<FileProcess>("Furrain.FileProcess", 1, 0, "FileProcess");
    qmlRegisterType<Reader>("Furrain.Reader", 1, 0, "MyReader");
//    qmlRegisterSingletonType<Reader>("Furrain.Reader", 1, 0, "Reader", Reader::reader_qobject_singletontype_provider);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
