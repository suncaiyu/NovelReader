#include "Reader.h"
#include <QDebug>
//Reader *Reader::mMe = nullptr;
QObject *Reader::reader_qobject_singletontype_provider(QQmlEngine *engine, QJSEngine *scriptEngine)
{
//    if (mMe == nullptr) {
//        mMe = new Reader();
//    }
//    return mMe;
    static Reader instance;
    return &instance;
}

Reader &Reader::Instance()
{
    qDebug() << "isntance";
    static Reader instance;
    return instance;
}

void Reader::say(QString text)
{
    mSpeech->stop();
    mSpeech->say(text);
}

Reader::Reader()
{
    qDebug() << "init";
    mSpeech = (new QTextToSpeech());
}
