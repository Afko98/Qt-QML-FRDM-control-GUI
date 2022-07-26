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
    border.color: "red"
    border.width: 2

    Text {
            id: buttonText
            color: "white"
            text: "stop"
            anchors.centerIn: parent
            font.pixelSize: 13
            font.bold: true
        }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            myButton.border.color = "orange"
        }

        onReleased: {
            myButton.border.color = "red"
            greenLight.color = "#097709"
            redLight.color = "#ff2222"
        }
    }
}

