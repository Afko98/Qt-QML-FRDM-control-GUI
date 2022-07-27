import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root
    width: 360
    height: 535
    visible: true
    title: qsTr("FRDM control")

    BoxCounter{
        id : counter
        anchors.fill: parent
    }
    MyMenu{
        anchors{
            left: parent.left
            top: parent.top
        }
    }
    MyButtons{

    }
}
