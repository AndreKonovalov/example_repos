import QtQuick 1.1

ListModel {
    property string translationContext: "DuesenwahlListDescriptionPart1"
    ListElement { width: 40; header: QT_TR_NOOP("Nr."); role: "number"; strDefault: "" }
    ListElement { width: 300; header: QT_TR_NOOP("Düsenart"); role: "duesenart"; strDefault: "" }
    ListElement { width: 440; header: QT_TR_NOOP("Düsencode"); role: "duesencode"; strDefault: "" }
    ListElement { width: 120; header: QT_TR_NOOP("HD-Haspel"); role: "hdHaspel"; strDefault: "" }
}
