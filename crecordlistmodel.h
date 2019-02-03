#ifndef CRECORDLISTMODEL_H
#define CRECORDLISTMODEL_H

#include <QObject>
#include <QAbstractListModel>

class CRecordListModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count READ count NOTIFY countChanged)
public:
    explicit CRecordListModel(QObject *parent = nullptr);

    virtual QHash<int, QByteArray> roleNames() const;
    virtual int count() const;
    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QVariant data(const QModelIndex &oIndex, int iRole) const;
signals:
    void countChanged();
protected:
    virtual QObject *getRecord(int row) const;
};

#endif // CRECORDLISTMODEL_H
