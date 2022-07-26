import QtQuick 2.0
import QtQuick.Controls 2.15

Item {
    ButtonGroup { id: radioGroup}

    Column {
        Label {
            text: qsTr("Radio:")
        }

        RadioButton {
            checked: true
            text: qsTr("res: 1000")
            font.italic: false
            ButtonGroup.group: radioGroup
        }

        RadioButton {
            text: qsTr("res: 2000")
            ButtonGroup.group: radioGroup
        }

        RadioButton {
            text: qsTr("res: 4000")
            ButtonGroup.group: radioGroup
        }

    }
}
