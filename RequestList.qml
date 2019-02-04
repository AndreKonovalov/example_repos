import QtQuick 2.12
import QtQuick.Controls 2.12
import com.abc.qmlcomponents 1.0

Rectangle {
    visible: false
    anchors.fill: parent
    color: "lightblue"

    signal exit
    signal add(variant listModel)

    onVisibleChanged: if(visible) oList.forceActiveFocus()

    CRequestListModel {
        id: oModel
        iCurrentIndex: oListController.iCurrentItem
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
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: oEdit.top
        anchors.margins: 1
        color: "transparent"
        border.color: "grey"
        border.width: 1

        Item {
            anchors.fill: parent
            id: oListView
            property int itemsPerHeader: 1
            property int itemHeight: oListView.height/(oListController.iItemsPerPage + itemsPerHeader)

            TableViewComponent {
                id: oList
                anchors.fill: parent
                controller: oListController
                model: internal.model
                header: RequestListHeader {
                    width: oListView.width
                    height: oListView.itemHeight * oListView.itemsPerHeader
                }
                delegate: RequestListRowDelegate {
                    width: oListView.width
                    height: oListView.itemHeight
                }
            }
        }
    }
    ToolButton {
        x: 8
        y: 11
        icon.source: "left.png"
        height: 16
        width: 16
        onClicked: exit()
    }

    Button {
        id: oEdit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 2
        text: "Add request"
        contentItem: Text {
            text: oEdit.text
            font: oEdit.font
            opacity: enabled ? 1.0 : 0.3
            color: "white"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        background: Rectangle {
            implicitHeight: 40
            opacity: enabled ? 1 : 0.3
            color: oEdit.down ? "#292193" : "#5941b3"
            radius: 2
        }
        onClicked: add(oModel)
    }
}
