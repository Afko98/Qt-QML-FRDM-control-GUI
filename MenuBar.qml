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
        text: "port"
        onClicked: {
            menu.open();
        }
    }
}
