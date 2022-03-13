#include "FileProcess.h"
#include <QFileInfo>
#include <QDebug>
#include <QTextCodec>

QString FileProcess::GetCorrectUnicode(const QByteArray &ba)
{
    QTextCodec::ConverterState state;
    QTextCodec *codec = QTextCodec::codecForName("UTF-8");
    QString text = codec->toUnicode(ba.constData(), ba.size(), &state);
    if (state.invalidChars > 0) {
        text = QTextCodec::codecForName("GBK")->toUnicode(ba);
    } else {
        text = ba;
    }
    return text;
}

void FileProcess::GetFileContent()
{
    mContent.clear();
    QFile file(mPath);
    if (!file.open(QFile::ReadOnly | QFile::Text)) {
        qDebug() << "file open fail";
    }
    QTextStream readFile(&file);
    while(!readFile.atEnd()) {
        mContent += readFile.readLine();
        mContent += "\n";
    }
    file.close();
    qDebug() << mContent.size();
}

void FileProcess::SpliteContent()
{
    // TODO:目前这个地方在MSVC编译器下运行有问题，待修复
    spliteContent.clear();
    QRegExp rx("[第]\\w+[章]\\s*\\w+");
    int pos = 0;
    while ((pos=rx.indexIn(mContent, pos)) != -1) {
        pos += rx.matchedLength();
        spliteContent.push_back(QPair<qreal, QString>(pos, rx.cap(0)));
    }
    qDebug() << "splite size====" << spliteContent.size();
//    for (int i = 0; i < spliteContent.size(); ++i) {
//        qDebug() << spliteContent.at(i).first << spliteContent.at(i).second;
//    }
}

// num从  1 - spliteContent.size()
QString FileProcess::GetChapterContent(int num)
{
    if (num < 1) {
        return "";
    }
    if (num == spliteContent.size()) {
        chapterIndex = spliteContent.size();
        int posS = spliteContent[num - 1].first;
        QString name = spliteContent[num - 1].second;
        posS = posS - name.size();
        return mContent.mid(posS);
    }
    if (num > spliteContent.size()) {
        return "";
    }
    chapterIndex = num;
    int posS = spliteContent[num - 1].first;
    QString name = spliteContent[num - 1].second;
    posS = posS - name.size();
    int posE = spliteContent[num].first;
    name = spliteContent[num].second;
    posE = posE - name.size();
    return mContent.mid(posS, posE - posS);
}

QStringList FileProcess::GetContents()
{
    QStringList list;
    for (QPair<int, QString> pair : spliteContent) {
        list.append(pair.second);
    }
    return list;
}

void FileProcess::Prepare()
{
    GetFileContent();
//    Reader::Instance().say("这是一个测试");
    SpliteContent();
}

FileProcess::FileProcess(QString filepath) : mPath(filepath)
{
    Prepare();
    qDebug() << mPath;
}

FileProcess::FileProcess()
{

}

//QString FileProcess::GetContext(int size)
//{
//    QFile file(mPath);
//    if(!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
//        qDebug()<<"Can't open the file!"<<endl;
//    }
//    QByteArray array = file.read(size);
//    return GetCorrectUnicode(array);
//}
