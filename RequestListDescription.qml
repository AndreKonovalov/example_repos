import QtQuick 2.12

ListModel {
    ListElement { width:  20; header: QT_TR_NOOP("N"); role: "number"; strDefault: "" }
    ListElement { width: 170; header: QT_TR_NOOP("E-Mail"); role: "email"; strDefault: "" }
    ListElement { width: 100; header: QT_TR_NOOP("Name"); role: "name"; strDefault: "" }
    ListElement { width: 100; header: QT_TR_NOOP("Subject"); role: "subject"; strDefault: "" }
    ListElement { width: 300; header: QT_TR_NOOP("Text"); role: "text"; strDefault: "" }
}
