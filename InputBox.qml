import QtQuick 2.12

FocusScope {
    property alias textColor: oInput.color
    property alias text: oInput.text
    property alias validator: oInput.validator
    property alias dummyText: oDummy.text
    property Item nextInFocus: oInput.nextItemInFocusChain() // Item {}
    width: 300
    height: 30

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        property int textSize: 16
        TextInput {
            id: oInput
            clip: true
            focus: true
            color: "black"
            font.pixelSize: parent.textSize
            anchors.verticalCenter: parent.verticalCenter
            KeyNavigation.tab: nextInFocus
        }
        Text {
            id: oDummy
            color: "gray"
            font.italic: true
            text: ""
            font.pixelSize: parent.textSize
            anchors.verticalCenter: parent.verticalCenter
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                oInput.forceActiveFocus()
            }
        }
        Rectangle {
            anchors.bottom: parent.bottom
            width: parent.width
            height: 2
            color: "#5941b3"
        }
    }

    transitions: Transition {
        from: "0"
        to: "1"
        PropertyAnimation { target: oDummy; property: "opacity"; duration: 500 }
    }
    states: [
        State {
            name: "0"
            when: oInput.text.length === 0
            PropertyChanges { target: oDummy; opacity: 1 }
        },
        State {
            name: "1"
            when: oInput.text.length !== 0
            PropertyChanges { target: oDummy; opacity: 0 }
        }
    ]
}
