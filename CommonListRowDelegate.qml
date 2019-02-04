import QtQuick 2.12
import "Common.js" as Common

Rectangle {
    id: oItem
    clip: true
    color: "transparent"
//    color: Common.premiumTableStyle.row.even.background
    height: row.height

    property variant oRowData: model
    property variant oObject: model.object
    property string textColor: Common.premiumTableStyle.row.text
    property int textSize: 12
    property bool textEllipsize: false
    property alias oColumnsModel: listView.model
    property bool dynamicHeight: false
    property int textFormat: Text.PlainText
    signal clicked

    Row {
        id: row
        anchors.leftMargin: 10
        anchors.fill: parent
        focus: false
        spacing: oColumnsModel.spacing ? oColumnsModel.spacing : 2
        onSpacingChanged: console.log('spacing ' + spacing)
        onChildrenChanged: {
            if (oItem.dynamicHeight) {
                var maxHeight = 0.0;
                for (var i = 0; i < children.length; i++) {
                    var curHeight = children[i].implicitHeight;
                    if (curHeight > maxHeight)
                        maxHeight = curHeight;
                }
                height = maxHeight + Common.DynamicRowSpace
            }
        }
        
        Repeater {
            id: listView
            delegate: CommonCell {
                width: model.width
                text: oItem.oObject[model.role]
                horizontalAlignment: model.align? model.align: Text.AlignLeft
                color: oItem.textColor
                font.pixelSize: oItem.textSize
                elide: textEllipsize ? Text.ElideRight : Text.ElideNone
                textFormat: oItem.textFormat
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            console.log('rowClicked')
            oItem.forceActiveFocus()
            oItem.clicked()
            var tableView = Common.oFindAncestor(oItem, "table-view")
            if (tableView && tableView.controller)
                tableView.controller.vSetCurrentItem(oRowData.index)
        }
    }
    states: State {
        name: "Current"
        when: oItem.ListView.isCurrentItem
        PropertyChanges {
            target: oItem;
            color: Common.premiumTableStyle.row.current.background
            textColor: "white"
        }
    }
}
