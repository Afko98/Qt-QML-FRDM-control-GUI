#ifndef FRDM_H
#define FRDM_H

#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QList>
#include <QObject>
#include <QString>
#include <QFile>


class Frdm : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _counter MEMBER counter NOTIFY counterChanged)



public:
    explicit Frdm(QObject *parent = nullptr);
    void writeToFile(QString);
    void open();
    ~Frdm();
    QString getCounter();
    void setCounter(const QString&);

signals:
    void counterChanged(QString);
    void triggerTimeChanged(QString);
    void triggerNChanged(QString);
    void systemOff();
    void modeChanged(int);
    void systemStart();
    void error(QString);

public slots:
    void readSerial();
    void setNorT(QString,int);
    void changeMode(int);
    void startSystem();
    void stopSystem();

private:
    QSerialPort *frdm;
    QByteArray serialData;
    QString serialBuffer;
    QString counter="0";
    int currentMode=-1;
    bool fileCreated=false;
    QString filename;
    QFile *file;
    QTextStream *stream;
};

#endif // FRDM_H
