import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    visible: false
    anchors.fill: parent
    color: "black"

    signal exit

    property alias o1text: o1.text
    property alias o3text: o3.text

    function clear() {
        o1text = "";
        o3text = "";
    }
    onVisibleChanged: if(visible) { clear(); o1.forceActiveFocus(); }

    Rectangle {
        y: 10
        width: 50
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        border.color: "green"
        border.width: 2
        Image {
            anchors.fill: parent
//            y: 100
//            width: 50
//            height: 50
//            anchors.horizontalCenter: parent.horizontalCenter
            source: "Pencil2.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
        }
    }

    InputBox {
        id: o1
        y: 150
        anchors.horizontalCenter: parent.horizontalCenter
        dummyText: "E-MAIL"
        nextInFocus: o3
        validator: RegExpValidator { regExp: /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/ }
    }
    InputBox {
        id: o3
        y: 250
        anchors.horizontalCenter: parent.horizontalCenter
        dummyText: "PASSWORD"
        nextInFocus: o1
    }

    Button {
        id: oSignIn
        anchors.horizontalCenter: parent.horizontalCenter
        y: 400
        width: 200
        height: background.height
        text: "Sign in"
        contentItem: Text {
            text: oSignIn.text
            font: oSignIn.font
            opacity: enabled ? 1.0 : 0.3
            color: oSignIn.down ? "#000000" : "#000000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: oSignIn.down ? "#ece7d3" : "#ffbe1c"
//            border.color: oSignIn.down ? "#17a81a" : "#5904b1"
//            border.width: 1
            radius: 5
        }
        onClicked: { console.log('clopg'); exit(); }
    }

}
