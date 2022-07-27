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
    if(c==counter)
        return;
    counter=c;
    emit counterChanged(c);
}

void Frdm::readSerial()
{
    serialData = frdm->readAll();

    if(QString::fromStdString(serialData.toStdString())=="\r"){
        setCounter(serialBuffer);
        serialBuffer = "";
    }else if(QString::fromStdString(serialData.toStdString())=="T"){
        emit triggerTimeChanged(serialBuffer);
        serialBuffer="";
    }else if(QString::fromStdString(serialData.toStdString())=="N"){
        emit triggerNChanged(serialBuffer);
        serialBuffer="";
    }else if(QString::fromStdString(serialData.toStdString())=="M"){

    }else{
        serialBuffer = serialBuffer + QString::fromStdString(serialData.toStdString());
        serialData.clear();
    }
}

void Frdm::setNorT(QString number, int b)
{
    for(int i=0;i<number.length();i++)
            if(number[i]<'0' || number[i]>'9' || number.length()>999999){
                qDebug()<<"Invalid input";
                return;
            }

        if(frdm->isWritable()){
            if(b)
                frdm->write("n");
            else
                frdm->write("s");
            number+="!";
            frdm->write(number.toStdString().c_str());

        }else{
            qDebug() << "Couldnt write to serial";
        }
        qDebug()<<number;
}

