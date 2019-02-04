import QtQuick 2.12
import QtQuick.Controls 2.12

PopupBase {
    id: messageBox
    property string title
    property string message

    GroupBoxWithToolBar {
        title: messageBox.title
        titleFont.bold: true
        titleFont.pixelSize: 25
        anchors {
            fill: parent
            topMargin: 0.191 * parent.height
            rightMargin: 0.191 * parent.width
            bottomMargin: 0.191 * parent.height
            leftMargin: 0.191 * parent.width
        }
        buttons: [
            Button {
                id: oButton
                width: 60
                height: background.height
                contentItem: Text {
                    text: "Ok"
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                background: Rectangle {
                    implicitHeight: 20
                    color: oButton.down ? "#ece7d3" : "#ffbe1c"
                    radius: 5
                }
                onClicked: messageBox.vClose();
            }
        ]
        
        Text {
            x: 10
            y: 100
//            anchors.horizontalCenter: parent.horizontalCenter
//            anchors.bottom: oButton.top
//            anchors.bottomMargin: 10

//            anchors.centerIn: parent
//            anchors.fill: parent
            text: messageBox.message
            wrapMode: Text.Wrap
            color: "white"
            font.pixelSize: 20
        }
    }
}
