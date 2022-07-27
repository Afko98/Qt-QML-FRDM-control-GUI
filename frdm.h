#ifndef FRDM_H
#define FRDM_H

#include <QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QList>
#include <QObject>
#include <QString>

class Frdm : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString _counter MEMBER counter NOTIFY counterChanged)
public:
    explicit Frdm(QObject *parent = nullptr);
    void open();
    ~Frdm();
    QString getCounter();
    void setCounter(const QString&);

signals:
    void counterChanged(QString);
    void triggerTimeChanged(QString);
    void triggerNChanged(QString);
public slots:
    void readSerial();
    void setNorT(QString,int);


private:
    QSerialPort *frdm;
    QByteArray serialData;
    QString serialBuffer;
    QString counter="0";
};

#endif // FRDM_H
