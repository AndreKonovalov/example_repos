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

    Text {
        x: 150
        y: 20

        color: "#ffbe1c"
        text: qsTr("Sign in")
        font.pixelSize: 14
    }
    ToolButton {
        x: 30
        y: 10
        height: 20
        width: 20
        icon.source: "left.png"
        onClicked: exit()
    }
    Rectangle {
        y: 50
        x: 0
        width: parent.width
        height: 2
        color: "darkgrey"
    }
    Rectangle {
        y: 110
        width: 50
        height: 50
        anchors.horizontalCenter: parent.horizontalCenter
        color: "transparent"
        Image {
            anchors.fill: parent
            source: "Pencil2.png"
            smooth: true
            fillMode: Image.PreserveAspectFit
        }
    }

    InputBox {
        id: o1
        y: 200
        anchors.horizontalCenter: parent.horizontalCenter
        textColor: "white"
        dummyText: "E-MAIL"
        nextInFocus: o3
        validator: RegExpValidator { regExp: /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/ }
    }
    InputBox {
        id: o3
        y: 300
        anchors.horizontalCenter: parent.horizontalCenter
        textColor: "white"
        dummyText: "PASSWORD"
        nextInFocus: o1
    }

    Button {
        id: oSignIn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
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
            radius: 5
        }
        onClicked: { exit(); }
    }

}
