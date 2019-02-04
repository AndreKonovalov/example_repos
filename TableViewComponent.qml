import QtQuick 2.12
import QtQuick.Controls 2.12
import com.abc.qmlcomponents 1.0

Item {
    objectName: "table-view"
    
    property alias model: oListViewInternal.model
    property alias currentIndex: oListViewInternal.currentIndex
    property alias header: oHeader.sourceComponent
    property alias delegate: oListViewInternal.delegate
    property CListController controller: CListController {}
    onControllerChanged: if (controller) { oListViewInternal.currentIndex = controller.iCurrentItem; }

    focus: false
    onActiveFocusChanged: if(activeFocus) oListViewInternal.forceActiveFocus()
    
    Loader {
        id: oHeader
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }
    ListView {
        id: oListViewInternal
        anchors.top: oHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        focus: true
        interactive: true
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        onCurrentIndexChanged: {
            if (controller) controller.vSetCurrentItem(currentIndex)
        }
        highlightMoveDuration: 1

        ScrollBar.vertical: ScrollBar { id: vbar; active: true }
    }
    Connections {
        target: controller
        onICurrentItemChanged: oListViewInternal.currentIndex = controller.iCurrentItem
    }
}
