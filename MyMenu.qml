import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
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
        width: 100
        height: 86
        border.color: "white"
        radius: 3
        border.width: 3
        color: "black"
        anchors{
            left: parent.left
            leftMargin: 248
            top: parent.top
            topMargin: 381
        }
        Text{
            anchors.fill: parent
            text: "Error log:\n---"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "white"
            font.pixelSize: 16
        }
    }
}
