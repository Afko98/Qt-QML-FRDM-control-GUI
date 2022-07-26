import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0

Rectangle{
    id : myButton

    property alias buttonText: buttonText.text

    property bool isItOn: false
    property bool isItPressed: false
    property int mode: -1

    Component.onCompleted: {
        myButtons.buttonPressed.connect(checkColor)
    }

    function checkColor(){
        if(isItOn && !isItPressed){
            border.color="white";
            isItOn=false;
        }
    }

    radius: 4
    height: 30
    width: 85
    color: "#111111"
    border.color: "White"
    border.width: 2

    Text {
            id: buttonText
            color: "white"
            text: "res: 1x"
            anchors.centerIn: parent
            font.pixelSize: 13
            font.bold: true
        }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            myButton.isItOn = !myButton.isItOn
            if(myButton.isItOn){
                myButton.border.color = "gray"
            }
            myButton.isItPressed=true;
            myButtons.buttonPressed();
        }

        onReleased: {
            if(myButton.isItOn){
                myButton.border.color = "#22aa22"
            }
            else{
                myButton.border.color = "white"
            }
            myButton.isItPressed=false;
            myButtons.buttonPressedMod(myButton.mode)
        }
    }
}

