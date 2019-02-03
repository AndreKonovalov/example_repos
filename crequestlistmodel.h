#ifndef CREQUESTLISTMODEL_H
#define CREQUESTLISTMODEL_H

#include "crecordlistmodel.h"
#include "crequest.h"

class CRequestListModel : public CRecordListModel
{
    Q_OBJECT
    Q_PROPERTY(int iCurrentIndex READ iCurrentIndex WRITE vSetCurrentIndex NOTIFY vCurrentIndexChanged)
    Q_PROPERTY(bool boIsEditActive READ boIsEditActive NOTIFY vIndexValidChanged)
public:
    explicit CRequestListModel(QObject *parent = nullptr);
    int iCurrentIndex() const { return m_iCurrentIndex; }
    bool boIsEditActive() const { return boIsIndexValid(); }
    CRequest::Ptr getCurrentItem();
    void setCurrent(CRequest::Ptr duese);

    virtual int count() const { return m_collection.count(); }
    void setCollection(const QVector<CRequest::Ptr> &collection);
    void sort();
    void add(CRequest::Ptr item);
    void remove(CRequest::Ptr item);
    void insert(int iBeforeRow, CRequest::Ptr item);
    const QVector<CRequest::Ptr> &getCollection() const { return m_collection; }
    virtual QObject *getRecord(int row) const;
    virtual ~CRequestListModel();
signals:
    void vCurrentIndexChanged();
    void vIndexValidChanged();

public slots:
    void vSetCurrentIndex(int currentIndex);

private:
    bool m_boIndexValid;
    int m_iCurrentIndex;
    bool boIsIndexValid() const { return m_boIndexValid; }
    void vCalcIndexValid();

    QVector<CRequest::Ptr> m_collection;
//    QVector<CRequest*> m_records;
    void createRecord(CRequest::Ptr object);
    void deleteRecord(CRequest::Ptr object);
    bool readFromFile();
    bool writeToFile();
};

#endif // CREQUESTLISTMODEL_H
