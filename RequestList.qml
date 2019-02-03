import QtQuick 2.12
import QtQuick.Controls 2.12
import com.abc.qmlcomponents 1.0

Rectangle {
    visible: false
    anchors.fill: parent
    color: "black"

    signal exit
    signal add(variant listModel)

    CRequestListModel {
        id: oModel
        iCurrentIndex: oListController.iCurrentItem
    }
//    ListModel {
//        id: oModel
//        property int spacing: 10;
//        ListElement { number: "1"; spacing: 2; checked: true }
//        ListElement { number: "2"; spacing: 2; checked: false }
//        ListElement { number: "3"; spacing: 2; checked: false }
//        ListElement { number: "4"; spacing: 2; checked: false }
//    }
    Component {
        id: oListDelegatePart1
        RequestListRowDelegate {
            id: oRow
            width: oListView.width
            height: oListView.itemHeight
            onHeightChanged: console.log('height2 ' + width + ' ' + height)
        }
    }
    Item {
        id: internal
        property variant model: oModel
        CListController {
            id: oListController
            iCount: internal.model.count
            iCurrentItem: 0
            iItemsPerPage: 10
        }
    }

    Rectangle {
        id: oHeader
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60
    }
    Rectangle {
        anchors.top: oHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: oSignIn.top
        anchors.margins: 5
        color: "transparent"
        border.color: "white"
        border.width: 2

        ListView {
            property int itemsPerHeader: 1
            property int itemHeight: oListView.height/(oListController.iItemsPerPage + itemsPerHeader)
            property CListController controller: oListController
            onControllerChanged: if (controller) { currentIndex = controller.iCurrentItem; }
            onCurrentIndexChanged:
                if (controller) controller.vSetCurrentItem(currentIndex)

            id: oListView
            objectName: "table-view"
            anchors.fill: parent
            anchors.margins: 2
            focus: true
            interactive: true
            clip: true
            model: oModel
            delegate: RequestListRowDelegate {
                width: oListView.width
                height: oListView.itemHeight
            }
//            delegate: oListDelegatePart1
            Connections {
                target: controller
                onICurrentItemChanged: oListView.currentIndex = controller.iCurrentItem
            }
        }
    }


    Button {
        id: oSignIn
        anchors.horizontalCenter: parent.horizontalCenter
        y: 400
        width: 200
        text: "Cancel"
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
        onClicked: exit()
    }
    Button {
        id: oEdit
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: oSignIn.bottom
        anchors.topMargin: 2
        width: 200
        text: "Add request"
        contentItem: Text {
            text: oEdit.text
            font: oEdit.font
            opacity: enabled ? 1.0 : 0.3
            color: oEdit.down ? "#000000" : "#000000"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: oEdit.down ? "#ece7d3" : "#ffbe1c"
//            border.color: oSignIn.down ? "#17a81a" : "#5904b1"
//            border.width: 1
            radius: 5
        }
        onClicked: add(oModel)
    }
}
