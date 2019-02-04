import QtQuick 2.12
import "Common.js" as Common

FocusScope {
    anchors.fill: parent
    visible: false
    default property alias content: oPopupContainer.data
    signal closed()
    signal opened()

    function vClose()
    {
        visible = false
        closed()
    }
    function vShow(owner)
    {
        parent = Common.oFindRoot(owner)
        visible = true
        forceActiveFocus()
        opened()
    }

    Item {
        anchors.fill: parent

        MouseArea {
            anchors.fill: parent
            onClicked: {}
            onPressed: {}
            onReleased: {}
        }

        Rectangle {
            anchors.fill: parent
            color: "#7a7a7a"
            opacity: 0.7
        }

        Item {
            id: oPopupContainer
            anchors.fill: parent
            focus: true
        }
    }
}
