import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0

Rectangle{
    id : myButton


    property alias buttonText: buttonText.text

    property bool isItOn: false
    property color borderRed: "#777777"
    property color borderGreen: "white"
    Component.onCompleted: {
        myButtons.buttonPressedMod.connect(changeBorderColor);
    }
    function changeBorderColor(mod){
        if(objectName==="setTime"){
            if(mod===3 || mod===4 || mod===5){
                isItOn=true
                border.color = borderGreen
            }else{
                isItOn=false
                border.color = borderRed
            }
        }
        if(objectName==="setN"){
            if(mod===0 || mod===1 || mod===2){
                isItOn=true
                border.color = borderGreen
            }else{
                isItOn=false
                border.color = borderRed
            }
        }
    }

    radius: 3
    height: 30
    width: 85
    color: "#111111"
    border.color: "gray"
    border.width: 3

    Text {
            id: buttonText
            color: "white"
            text: "set"
            anchors.centerIn: parent
            font.pixelSize: 13
            font.bold: true
        }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            border.color = "gray"
        }

        onReleased: {
            if(isItOn){
                border.color = borderGreen
            }
            else{
                border.color = borderRed
            }
            myButtons.sendInputText();
        }
    }
}
