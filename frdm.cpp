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
    if(frdm->isWritable()){
        frdm->write("r");
    }else{
        emit error("Error code 'P'");
    }

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
        serialData.clear();
    }else if(QString::fromStdString(serialData.toStdString())=="T"){
        emit triggerTimeChanged(serialBuffer);
        qDebug()<<serialBuffer<<"TTT";
        serialBuffer="";
        emit systemOff();
        serialData.clear();
    }else if(QString::fromStdString(serialData.toStdString())=="S"){
        serialBuffer="";
        emit systemOff();
        serialData.clear();
    }else if(QString::fromStdString(serialData.toStdString())=="N"){
        emit triggerNChanged(serialBuffer);
        qDebug()<<serialBuffer<<"NNN";
        serialBuffer="";
        emit systemOff();
        serialData.clear();
    }else if(QString::fromStdString(serialData.toStdString())=="M"){
        qDebug()<<serialBuffer;
        currentMode=serialBuffer.toInt();
        emit modeChanged(currentMode);
        qDebug()<<"current mode: "<<serialBuffer.toInt();
        serialBuffer="";
        serialData.clear();
        emit systemStart();
    }else{
        serialBuffer = serialBuffer + QString::fromStdString(serialData.toStdString());
        serialData.clear();
    }
}

void Frdm::setNorT(QString n, int b)
{
    QString number=n;
    for(int i=0;i<number.length();i++)
            if(number[i]<'0' || number[i]>'9' || number.length()>999999){
                qDebug()<<"Invalid input";
                return;
            }

        if(frdm->isWritable()){
            if(b==1)
                frdm->write("n");
            else
                frdm->write("s");
            number+="!";
            frdm->write(number.toStdString().c_str());

        }else{
            qDebug() << "Couldnt write to serial";
        }
        qDebug()<<number <<" "<<b;
}

void Frdm::changeMode(int mode)
{
    if(frdm->isWritable()){
        frdm->write("m");
        frdm->write(QString::number(mode).toStdString().c_str());
    }else{
        qDebug() << "Couldnt write to serial";
    }
    qDebug()<<"mode: "+QString::number(currentMode);
}

void Frdm::startSystem()
{

    if(frdm->isWritable()){
        frdm->write("m");
        frdm->write(QString::number(currentMode).toStdString().c_str());
    }else{
        qDebug() << "Couldnt write to serial";
    }
    qDebug()<<"mode: "+QString::number(currentMode);
}

void Frdm::stopSystem()
{
    if(frdm->isWritable()){
        frdm->write("#");
    }else{
        qDebug() << "Couldnt write to serial";
    }
    qDebug()<<"mode: "+QString::number(currentMode);
}


