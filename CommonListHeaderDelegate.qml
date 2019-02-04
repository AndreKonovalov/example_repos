import QtQuick 2.12

Rectangle {
    id: oHeaderDelegate
    property variant oHeadersModel: ListModel {}
    color: "#5941b3"
    
    Row {
        id: row
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: oHeaderLine.top
            leftMargin: 10
        }
        
        Repeater {
            model: oHeaderDelegate.oHeadersModel
            clip: true
            
            ListHeaderItem {
                anchors.top: model.sub ? parent.verticalCenter : parent.top
                anchors.bottom: parent.bottom
                width: model.width
                text: model.header
                horizontalAlignment: model.align ? model.align : Text.AlignVCenter
            }
        }
    }
    HeaderLine {
        id: oHeaderLine
    }
}
