import QtQuick 2.12

Text {
    clip: true
    height: parent.height
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignLeft
    color: "black"
    font.pixelSize: 18
    textFormat: Text.PlainText
    wrapMode: Text.WordWrap
    elide: Text.ElideNone
}
