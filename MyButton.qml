import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0

Rectangle{
    id : myButton

    property alias buttonText: buttonText.text

    property bool isItOn: false
    property bool isItPressed: false
    property int mode

    Component.onCompleted: {
        _frdm.modeChanged.connect(checkColorOnModeChanged)
    }
    function checkColorOnModeChanged(m){
        console.log(mode);
        console.log(m);
        if(m===mode){
            border.color="green";
        }
        else{
            border.color="white";
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
            myButton.isItOn = true;
            if(myButton.isItOn){
                myButton.border.color = "gray"
            }
            myButton.isItPressed=true;
        }

        onReleased: {
            if(myButton.isItOn){
                myButton.border.color = "#ff2020"
            }
            else{
                myButton.border.color = "white"
            }
            _frdm.changeMode(mode);
            myButtons.buttonPressedMod(mode)
        }
    }
}

