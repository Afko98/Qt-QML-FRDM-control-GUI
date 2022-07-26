#include "frdm.h"

Frdm::Frdm(QObject *parent)
    : QObject{parent}
{

}

void Frdm::open()
{
    frdm = new QSerialPort;
    frdm->setPortName("COM3");
    frdm->open(QSerialPort::ReadWrite);
    frdm->setBaudRate(QSerialPort::Baud9600);
    frdm->setDataBits(QSerialPort::Data8);
    frdm->setParity(QSerialPort::NoParity);
    frdm->setStopBits(QSerialPort::OneStop);
    frdm->setFlowControl(QSerialPort::NoFlowControl);
    QObject::connect(frdm,SIGNAL(readyRead()),this,SLOT(readSerial()));
}

Frdm::~Frdm()
{
    delete frdm;
}

QString Frdm::getCounter()
{
    return counter;
}

void Frdm::setCounter(const QString &c)
{
    counter=c;
}

void Frdm::readSerial()
{
    serialData = frdm->readAll();

    if(QString::fromStdString(serialData.toStdString())=="\r"){
        counter=serialBuffer;
        emit counterChanged(serialBuffer);
        serialBuffer = "";
    }else{
        serialBuffer = serialBuffer + QString::fromStdString(serialData.toStdString());
        serialData.clear();
    }
    qDebug()<<serialBuffer;
}

