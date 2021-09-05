import QtQuick 2.12
import QtQuick.Controls 2.12
import com.abc.qmlcomponents 1.0

Rectangle {
    id: oForm
    visible: false
    anchors.fill: parent
    color: "black"

    signal exit

    function clear() {
        oEditModel.clear()
    }
    onVisibleChanged: if(visible) { clear(); o1.forceActiveFocus(); }

    Text {
        x: 150
        y: 20

        color: "#ffbe1c"
        text: qsTr("Sign up")
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

    InputBox {
        id: o1
        y: 80
        anchors.horizontalCenter: parent.horizontalCenter
        textColor: "white"
        text: oEditModel.email
        onTextChanged: oEditModel.email = text
        dummyText: "E-MAIL"
        nextInFocus: o2
        validator: RegExpValidator { regExp: /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/ }
    }
    InputBox {
        id: o2
        y: 140
        anchors.horizontalCenter: parent.horizontalCenter
        textColor: "white"
        text: oEditModel.name
        onTextChanged: oEditModel.name = text
        dummyText: "FIRSTNAME"
        nextInFocus: o3
    }
    InputBox {
        id: o3
        y: 200
        anchors.horizontalCenter: parent.horizontalCenter
        textColor: "white"
        text: oEditModel.lastname
        onTextChanged: oEditModel.lastname = text
        dummyText: "LASTNAME"
        nextInFocus: o4
    }
    InputBox {
        id: o4
        y: 260
        anchors.horizontalCenter: parent.horizontalCenter
        textColor: "white"
        text: oEditModel.password
        onTextChanged: oEditModel.password = text
        dummyText: "PASSWORD"
        nextInFocus: o5
    }
    InputBox {
        id: o5
        y: 320
        anchors.horizontalCenter: parent.horizontalCenter
        textColor: "white"
        text: oEditModel.password2
        onTextChanged: oEditModel.password2 = text
        dummyText: "RE-ENTER PASSWORD"
        nextInFocus: o1
    }

    Button {
        id: oSignIn
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        width: 200
        height: background.height
        text: "Register"
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
        onClicked: { if(oEditModel.commit()) exit(); }
    }

    CUserData {
        id: oEditModel
        onShowErrors: {
            errorsMessageBox.message = errors.join("\n");
            errorsMessageBox.vShow(oForm);
        }
    }

    MessageBox {
        id: errorsMessageBox
        title: "Error"
    }
}
