import QtQuick 2.12

ListModel {
    property string translationContext: "DuesenwahlListDescriptionPart1"
    ListElement { width: 170; header: QT_TR_NOOP("Nr."); role: "email"; strDefault: "" }
    ListElement { width: 100; header: QT_TR_NOOP("Düsenart"); role: "name"; strDefault: "" }
    ListElement { width: 100; header: QT_TR_NOOP("Düsencode"); role: "subject"; strDefault: "" }
    ListElement { width: 300; header: QT_TR_NOOP("HD-Haspel"); role: "text"; strDefault: "" }
}
