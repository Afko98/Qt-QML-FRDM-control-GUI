import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    id:mainMenu

    Component.onCompleted: {
        _frdm.error.connect(changeErrorLog);
    }

    function changeErrorLog(txt){
        errorText.text = "Sytem status:\n"+txt;
    }

    Menu{
        id : menu
        MenuItem{
            text: "COM1"
            onTriggered: console.log("COM1 clicked");
        }
    }
    Button{
        id : portButton
        text: "Port"
        onClicked: {
            menu.open();
        }
        height: 25
        width: 65
        background: Rectangle{
            gradient: Gradient {
                    GradientStop { position: -1.0; color: "white" }
                    GradientStop { position: 3.5; color: "black" }
                }
        }
    }

    Rectangle{
        id : errorLog
        width: 320
        height: 50
        border.color: "white"
        radius: 3
        border.width: 3
        color: "black"
        anchors{
            left: parent.left
            leftMargin: 20
            top: parent.top
            topMargin: 470
        }
        Text{
            id:errorText
            anchors.fill: parent
            text: "Sytem status:\nNo errors"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
            font.pixelSize: 16
        }
    }
}
