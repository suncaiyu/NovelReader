#ifndef READER_H
#define READER_H
#include <QObject>
#include <QTextToSpeech>
#include <QQmlEngine>

class Reader : public QObject
{
    Q_OBJECT
public:
    static QObject *reader_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine);
    static Reader &Instance();
    Q_INVOKABLE void say(QString text);
    Q_INVOKABLE void close() {mSpeech->stop();};
    Reader();
    ~Reader(){
       close();
       mSpeech->deleteLater();
    };
private:
    QTextToSpeech *mSpeech;
//        static Reader *mMe;
};

#endif // READER_H
