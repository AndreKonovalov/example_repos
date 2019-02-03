#include "crecordlistmodel.h"

CRecordListModel::CRecordListModel(QObject *parent) :
    QAbstractListModel(parent)
{
}

QHash<int, QByteArray> CRecordListModel::roleNames() const {
    QHash<int, QByteArray> arr = QAbstractListModel::roleNames();
    arr.insert(Qt::UserRole, "object");
    return arr;
}

int CRecordListModel::count() const
{
    return 0;
}

int CRecordListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return count();
}

QVariant CRecordListModel::data(const QModelIndex &oIndex, int iRole) const
{
    if (!oIndex.isValid() || oIndex.row() < 0 || oIndex.row() >= count())
        return QVariant();

    return (iRole == Qt::UserRole)? QVariant::fromValue(getRecord(oIndex.row())) :QVariant();
}

QObject *CRecordListModel::getRecord(int row) const
{
    Q_UNUSED(row)
    return nullptr;
}
