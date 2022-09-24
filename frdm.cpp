#include "frdm.h"
#include <QFile>
#include <QTextStream>
#include <QFileInfo>

Frdm::Frdm(QObject *parent)
    : QObject{parent}
{
     filename = "data.txt";

     file = new QFile(filename);
     stream = new QTextStream(file);
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
void Frdm::writeToFile(QString serialBuffer){


        if (file->open(QIODevice::ReadWrite| QIODevice::Append)) {

                        *stream<<serialBuffer<<"\n";
            file->close();
                }
            else
            qDebug()<<"error opening file";
}
void Frdm::readSerial()
{
    serialData = frdm->readAll();
    QString simbol = QString::fromStdString(serialData.toStdString());
    if(simbol=="\r"){
        setCounter(serialBuffer);
        writeToFile(serialBuffer);
        serialBuffer = "";
        emit error("No errors");
        serialData.clear();
    }else if(simbol=="T"){
        emit triggerTimeChanged(serialBuffer);
        serialBuffer="";
        emit systemOff();
        emit error("No errors");
        serialData.clear();
    }else if(simbol=="S"){
        serialBuffer="";
        emit systemOff();
        emit error("No errors");
        serialData.clear();
    }else if(simbol=="N"){
        emit triggerNChanged(serialBuffer);
        emit error("No errors");
        serialBuffer="";
        emit systemOff();
        serialData.clear();
    }else if(simbol=="M"){
        currentMode=serialBuffer.toInt();
        emit modeChanged(currentMode);
        qDebug()<<"current mode: "<<serialBuffer.toInt();
        serialBuffer="";
        emit error("No errors");
        serialData.clear();
        emit systemStart();
    }else{
        serialBuffer = serialBuffer + simbol;
        serialData.clear();
    }
}

void Frdm::setNorT(QString n, int b)
{
    QString number=n;
    for(int i=0;i<number.length();i++)
        if(number[i]<'0' || number[i]>'9' || number.length()>999999){
            emit error("Invalid Input");
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
        emit error("Error code 'P' - Neispravno otvaranje porta");
    }
}

void Frdm::changeMode(int mode)
{
    if(frdm->isWritable()){
        frdm->write("m");
        frdm->write(QString::number(mode).toStdString().c_str());
    }else{
        emit error("Error code 'P' - Neispravno otvaranje porta");
    }
}

void Frdm::startSystem()
{
    if(frdm->isWritable()){
        frdm->write("m");
        frdm->write(QString::number(currentMode).toStdString().c_str());
    }else{
        emit error("Error code 'P' - Neispravno otvaranje porta");
    }
}

void Frdm::stopSystem()
{
    if(frdm->isWritable()){
        frdm->write("#");
    }else{
        emit error("Error code 'P' - Neispravno otvaranje porta");
    }
}


