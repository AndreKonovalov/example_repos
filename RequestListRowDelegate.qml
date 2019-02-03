import QtQuick 2.12

CommonListRowDelegate {
    oRowData: model
    oObject: model.object
    oColumnsModel: RequestListDescription {}
}
