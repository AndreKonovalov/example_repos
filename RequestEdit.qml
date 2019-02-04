import QtQuick 2.12
import QtQuick.Controls 2.12
import com.abc.qmlcomponents 1.0

Rectangle {
    id: oForm
    visible: false
    anchors.fill: parent
    color: "#eff3f7"

    signal exit

    CRequestEditModel {
        id: oEditModel
        onShowErrors: {
            errorsMessageBox.message = errors.join("\n");
            errorsMessageBox.vShow(oForm);
        }
    }

    function show(listModel, create) {
        if (create)
            oEditModel.vClear(listModel);
        else
            oEditModel.vAssignFrom(listModel);
    }

    Rectangle {
        id: oHeader
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 1
        height: 40
        color: "#5941b3"
        Text {
            anchors.verticalCenter: parent.verticalCenter
            x: 150

            color: "white"
            text: qsTr("Support")
            font.pixelSize: 14
        }
        ToolButton {
            icon.source: "left.png"
            x: 30
            y: 10
            height: 20
            width: 20
            onClicked: exit()
        }

    }
    Rectangle {
        anchors.top: oHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 10
        color: "white"
        height: 300

        InputBox {
            id: oEmail
            y: 50
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 15
            text: oEditModel.email
            onTextChanged: oEditModel.email = text
            dummyText: "E-MAIL"
            nextInFocus: oName
            validator: RegExpValidator { regExp: /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/ }
        }
        InputBox {
            id: oName
            y: 110
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 15
            text: oEditModel.name
            onTextChanged: oEditModel.name = text
            dummyText: "NAME"
            nextInFocus: oSubject
        }
        InputBox {
            id: oSubject
            y: 170
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 15
            text: oEditModel.subject
            onTextChanged: oEditModel.subject = text
            dummyText: "SUBJECT"
            nextInFocus: oText
        }
        InputBox {
            id: oText
            y: 230
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 15
            text: oEditModel.text
            onTextChanged: oEditModel.text = text
            dummyText: "TEXT"
            nextInFocus: oEmail
        }
    }


    Button {
        id: oSend
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 10
        text: "Send"
        contentItem: Text {
            text: oSend.text
            font: oSend.font
            opacity: enabled ? 1.0 : 0.3
            color: oSend.down ? "white" : "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: oSend.down ? "#292193" : "#5941b3"
            radius: 2
        }
        onClicked: if(oEditModel.commit()) exit();
    }

    MessageBox {
        id: errorsMessageBox
        title: "Error"
    }
}
