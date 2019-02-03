import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
//    visible: false
    anchors.fill: parent
    color: "black"

    signal showSignIn
    signal showSignUp
    signal showProjects

    Button {
        id: oSignIn
        anchors.horizontalCenter: parent.horizontalCenter
        y: 100
        width: 200
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
        onClicked: showSignIn()
    }
    Button {
        id: oSignUp
        anchors.horizontalCenter: parent.horizontalCenter
//        anchors.horizontalCenter: parent
        y: 200
        width: 200
        text: "Sign up"
        contentItem: Text {
            text: oSignUp.text
            font: oSignUp.font
            opacity: enabled ? 1.0 : 0.3
            color: oSignUp.down ? "#000000" : "#000000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: oSignUp.down ? "#ece7d3" : "#ffbe1c"
//            border.color: oSignUp.down ? "#17a81a" : "#5904b1"
//            border.width: 1
            radius: 5
        }
        onClicked: showSignUp()
    }
    Button {
        id: oViewProject
        anchors.horizontalCenter: parent.horizontalCenter
        y: 300
        width: 200
        text: "View Projects"
        contentItem: Text {
            text: oViewProject.text
            font: oViewProject.font
            opacity: enabled ? 1.0 : 0.3
            color: oViewProject.down ? "#000000" : "#000000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: oViewProject.down ? "#ece7d3" : "#ffbe1c"
//            border.color: oViewProject.down ? "#17a81a" : "#5904b1"
//            border.width: 1
            radius: 5
        }
        onClicked: showProjects()
    }

}
