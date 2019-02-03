import QtQuick 2.12
import QtQuick.Controls 2.12
import com.abc.qmlcomponents 1.0

Rectangle {
    visible: false
    anchors.fill: parent
    color: "black"

    signal exit

    CRequestEditModel {
        id: oEditModel
    }

    function show(listModel, create) {
        if (create)
            oEditModel.vClear(listModel);
        else
            oEditModel.vAssignFrom(listModel);
//        visible = true;
    }

    InputBox {
        id: oEmail
        y: 50
        anchors.horizontalCenter: parent.horizontalCenter
        text: oEditModel.email
        onTextChanged: oEditModel.email = text
        dummyText: "E-MAIL"
        nextInFocus: oName
        validator: RegExpValidator { regExp: /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/ }
    }
    InputBox {
        id: oName
        y: 150
        anchors.horizontalCenter: parent.horizontalCenter
        text: oEditModel.name
        onTextChanged: oEditModel.name = text
        dummyText: ""
        nextInFocus: oSubject
    }
    InputBox {
        id: oSubject
        y: 250
        anchors.horizontalCenter: parent.horizontalCenter
        text: oEditModel.subject
        onTextChanged: oEditModel.subject = text
        dummyText: ""
        nextInFocus: oText
    }
    InputBox {
        id: oText
        y: 350
        anchors.horizontalCenter: parent.horizontalCenter
        text: oEditModel.text
        onTextChanged: oEditModel.text = text
        dummyText: ""
        nextInFocus: oEmail
    }

    Button {
        id: oSignIn
        anchors.horizontalCenter: parent.horizontalCenter
        y: 400
        width: 200
        text: "Send"
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
        onClicked: { if(oEditModel.commit()) exit(); }
    }
    Button {
        id: oCancel
        anchors.horizontalCenter: parent.horizontalCenter
        y: 460
        width: 200
        text: "Cancel"
        contentItem: Text {
            text: oCancel.text
            font: oCancel.font
            opacity: enabled ? 1.0 : 0.3
            color: oCancel.down ? "#000000" : "#000000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: oCancel.down ? "#ece7d3" : "#ffbe1c"
//            border.color: oSignIn.down ? "#17a81a" : "#5904b1"
//            border.width: 1
            radius: 5
        }
        onClicked: exit()
    }
}
