import QtQuick.Layouts 1.0
import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Item {

    id : myButtons

    signal buttonPressed();
    signal buttonPressedMod(var mod);
    signal buttonSetPressed(var setText,var b);

    Text{
        text: "Time\nTringger:"
        color: "white"
        font.pixelSize: 13
        anchors{
            bottom: button11.top
            bottomMargin: 5
            left: button11.left
        }
    }

    Text{
        text: "Movement\nTringger:"
        color: "white"
        font.pixelSize: 13
        anchors{
            bottom: button11.top
            bottomMargin: 5
            left: button12.left
        }
    }

    MyButton{
        id : button11
        anchors{
            top: parent.top
            topMargin: 80
            left: parent.left
            leftMargin:20
        }
        mode: 3
    }
    MyButton{
        anchors{
            top: parent.top
            topMargin: 125
            left: parent.left
            leftMargin:20
        }
        buttonText: "res: 2x"
        mode: 4
    }
    MyButton{
        anchors{
            top: parent.top
            topMargin: 170
            left: parent.left
            leftMargin:20
        }
        buttonText: "res: 4x"
        mode: 5
    }


    MyButton{
        id:button12
        anchors{
            top: parent.top
            topMargin: 80
            left: parent.left
            leftMargin:120
        }
        mode: 0
    }
    MyButton{
        id:button22
        anchors{
            top: parent.top
            topMargin: 125
            left: parent.left
            leftMargin:120
        }
        buttonText: "res: 2x"
        mode: 1
    }
    MyButton{
        id:button32
        anchors{
            top: parent.top
            topMargin: 170
            left: parent.left
            leftMargin:120
        }
        buttonText: "res: 4x"
        mode: 2
    }
    StartButton{
        id : startButton
        anchors{
            top: button22.top
            left: parent.left
            leftMargin:240
        }
    }
    StopButton{
        id : stopButton
        anchors{
            top: button32.top
            left: parent.left
            leftMargin:240
        }
    }

    Rectangle{
        id : greenLight
        radius: 5
        width: 25
        height: 25
        color: "#025502"
        border.width: 2
        border.color: "black"
        anchors{
            bottom: startButton.top
            bottomMargin: 10
            left: stopButton.left
            leftMargin: 9
        }
        Text{
            text: "on"
            color: "white"
            font.pixelSize: 14
            anchors{
                bottom:parent.top
                bottomMargin: 1
                horizontalCenter: parent.horizontalCenter
            }
        }
    }
    Rectangle{
        id : redLight
        radius: 5
        width: 25
        border.color: "black"
        border.width: 2
        height: 25
        color: "#ff2020"
        anchors{
            bottom: startButton.top
            bottomMargin: 10
            left: greenLight.right
            leftMargin: 13
        }
        Text{
            text: "off"
            color: "white"
            font.pixelSize: 14
            anchors{
                bottom:parent.top
                bottomMargin: 1
                horizontalCenter: parent.horizontalCenter
            }
        }
    }
    SetButton{
        id:timeButton
        objectName: "setTime"
        anchors{
            left: parent.left
            leftMargin: 155
            top: parent.top
            topMargin: 356
        }
    }
    SetButton{
        id:nButton
        objectName: "setN"
        anchors{
            left: parent.left
            leftMargin: 155
            top: parent.top
            topMargin: 412
        }
    }

    Text{
        id: setTimeActive
        text: "T: 20ms"
        anchors{
            left: timeButton.right
            leftMargin: 10
            verticalCenter: timeButton.verticalCenter
        }
        color: "white"
        font.pixelSize: 15
    }
    Text{
        id: setNActive
        text: "N: 50"
        anchors{
            left: nButton.right
            leftMargin: 10
            verticalCenter: nButton.verticalCenter
        }
        color: "white"
        font.pixelSize: 15
    }

    Column{
        id: lineEdits
        anchors{
            top: parent.top
            left: parent.left
            topMargin: 335
            leftMargin: 20
        }
        spacing: 5
        Text{
         text:"Time for trigger [ms]:"
         color: "white"
        }

        Rectangle{
           id: textT
           radius: 3
           width: 125
           height: 30
           color: "white"
           border.color: "gray"
           border.width: 2

           TextInput{
               id : inputTime
               font.pixelSize: 16
               horizontalAlignment: TextInput.AlignHCenter
               verticalAlignment: TextInput.AlignVCenter
               anchors.fill: parent
           }
        }
        Text{
         text:"Trigger at N counts:"
         color: "white"
        }
        Rectangle{
           id: textN
           radius: 3
           width: 125
           height: 30
           color: "white"
           border.color: "gray"
           border.width: 2

           TextInput{
               id : inputN
               font.pixelSize: 16
               horizontalAlignment: TextInput.AlignHCenter
               verticalAlignment: TextInput.AlignVCenter
               anchors.fill: parent
           }

        }

    }

    property string inputNText: inputN.text;
    property string inputTText: inputTime.text;

    Component.onCompleted: {
        myButtons.buttonPressedMod.connect(changeBorderColorText);
        myButtons.buttonSetPressed.connect(_frdm.setNorT);
        _frdm.triggerTimeChanged.connect(setTimeForTrigger);
        _frdm.triggerNChanged.connect(setNForTrigger);
        _frdm.systemOff.connect(setOffButtonColor);
        _frdm.systemStart.connect(onSystemStart);
    }

    function onSystemStart(){
        greenLight.color = "#09ff09"
        redLight.color = "#881111"
    }
    function setOffButtonColor(){
        greenLight.color = "#025502";
        redLight.color = "#ff2020";
    }

    function setTimeForTrigger(tt){
        setTimeActive.text="T: "+tt+"ms"
    }
    function setNForTrigger(tt){
        setNActive.text="N: "+tt
    }

    function sendInputText(){
        if(timeButton.isItOn){
            buttonSetPressed(inputTText,0);
            console.log(inputTText);
        }
        if(nButton.isItOn){
            buttonSetPressed(inputNText,1);
        }
    }

    function changeBorderColorText(mod){
        if(mod===3 || mod===4 || mod===5){
            textT.border.color="black"
            textT.color="white"
            textN.color="#777777"
            textN.border.color="black"
        }else{
            textT.color="#777777"
            textN.color="white"
            textT.border.color="black"
            textN.border.color="black"
        }
    }
}
