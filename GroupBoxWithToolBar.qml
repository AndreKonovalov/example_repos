import QtQuick 2.12

Rectangle {
    default property alias dat: inner.data
    property alias buttons: toolBar.children
    property alias title: oTitle.text
    property alias titleComponent: oTitle
    property alias titleFont: oTitle.font
    
    border.color: "white"
    border.width: 1
    radius: 2
    color: "#0b384e"
    
    Text {
        id: oTitle
        anchors {
            top: parent.top
            margins: 10
            horizontalCenter: parent.horizontalCenter
        }
        color: "white"
        font.pixelSize: 20
        wrapMode: Text.Wrap
    }
    Column {
        id: toolBar
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        spacing: 10
    }
    Item {
        id: inner
        anchors.rightMargin: 10
        anchors.right: toolBar.left
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
    }
}
