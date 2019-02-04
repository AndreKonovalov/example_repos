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
            scrollbarAnimation.start()
            if (controller) controller.vSetCurrentItem(currentIndex)
        }
        highlightMoveDuration: 1
//        highlightMoveSpeed: -1
        ScrollBar.vertical: oScrollBar
    }
    Connections {
        target: controller
        onICurrentItemChanged: oListViewInternal.currentIndex = controller.iCurrentItem
    }
    ScrollBar {
        id: oScrollBar
        anchors {
            top: oHeader.bottom
            right: parent.right
            bottom: parent.bottom
        }
        size: 1
        minimumSize: 1
        width: 10
//        trackMinHeight: 20
//        trackColor: "white"
        interactive: false
        property bool moving: oListViewInternal.moving || scrollbarAnimation.running
        opacity: oScrollBar.moving? 1.0: 0.0
        Behavior on opacity {
            NumberAnimation {
                duration: 500
                easing.type: Easing.InOutQuad
            }
        }
        SequentialAnimation {
            id: scrollbarAnimation
            running: true
            PauseAnimation { duration: 1000 }
        }
    }
}
