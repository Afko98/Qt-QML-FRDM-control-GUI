import QtQuick 2.0
import QtQuick.Controls 6.3
import QtQuick.Layouts 1.0

Rectangle{
    id : myButton

    property alias buttonText: buttonText.text

    radius: 3
    height: 25
    width: 70
    color: "#111111"
    border.color: "White"
    border.width: 2

    Text {
            id: buttonText
            color: "white"
            text: "start"
            anchors.centerIn: parent
            font.pixelSize: 13
            font.bold: true
        }

    MouseArea{
        anchors.fill: parent
        onPressed: {
            myButton.border.color = "green"
        }

        onReleased: {
            myButton.border.color = "white"
        }
    }
}

