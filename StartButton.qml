import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.0

Rectangle{
    id : myButton

    property alias buttonText: buttonText.text

    radius: 3
    height: 30
    width: 85
    color: "#111111"
    border.color: "#22aa22"
    border.width: 2

    Text {
            id: buttonText
            color: "white"
            text: "start/set"
            anchors.centerIn: parent
            font.pixelSize: 13
            font.bold: true
        }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            myButton.border.color = "gray"
        }

        onReleased: {
            myButton.border.color = "#22aa22"
            greenLight.color = "#09ff09"
            redLight.color = "#881111"
            _frdm._counter="0";
        }
    }
}

