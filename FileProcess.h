#ifndef FILEPROCESS_H
#define FILEPROCESS_H

#include <QObject>
#include "Reader.h"
class FileProcess : public QObject
{
    Q_OBJECT
public:
    FileProcess(QString filepath);
    FileProcess();
//    QString GetContext(int size);
    // 识别是中还是英文
    QString GetCorrectUnicode(const QByteArray &ba);
    QString GetChapterContent(int num);
    // 从1开始，算到spliteContent.size()
    int GetChapterSize() { return spliteContent.size(); }
    QStringList GetContents();
    int GetCurrentChapter() { return chapterIndex; }

    Q_INVOKABLE void setFilePath(QString str) {mPath = str;}
    Q_INVOKABLE QString getChapterContent(int num) { return GetChapterContent(num); }
    Q_INVOKABLE void prepare() {Prepare();}
    Q_INVOKABLE QList<QString> getContents() { return GetContents(); }
    Q_INVOKABLE int getChapterSize() { return GetChapterSize(); }
    Q_INVOKABLE int getCurrentIndex() { return GetCurrentChapter(); }
private:
    QString mPath;
    QString mContent;
    QVector<QPair<qreal, QString>> spliteContent;
    void GetFileContent();
    void Prepare();
    void SpliteContent();
    int chapterIndex = 0;
};

#endif // FILEPROCESS_H
