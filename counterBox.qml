import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    Rectangle{
        color: "black"
        anchors.fill: parent

        Rectangle{
            id: borderCounter
            border.color: "white"
            border.width: 3.5
            color: "black"
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                rightMargin: 10
                leftMargin: 10
            }
            height: parent.height/5
            radius: 5

            Label{
                id: labelCounter
                text: "Counter:"
                color: "white"
                font.pixelSize: 35
                anchors{
                    verticalCenter: borderCounter.verticalCenter
                    left: borderCounter.left
                    leftMargin: 20
                }
            }

            Text{
                id : counterNumber
                color: "White"
                text: "0000"
                font.pixelSize: 35
                anchors{
                    right: borderCounter.right
                    verticalCenter: borderCounter.verticalCenter
                    rightMargin: 35
                }
            }
        }
    }
}
