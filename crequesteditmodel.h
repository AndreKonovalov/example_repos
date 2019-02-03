#ifndef CREQUESTEDITMODEL_H
#define CREQUESTEDITMODEL_H

#include "crequestlistmodel.h"

class CRequestEditModel : public CRequest
{
    Q_OBJECT
public:
    explicit CRequestEditModel(QObject *parent = nullptr);

signals:

public slots:
    void vAssignFrom(CRequestListModel* model);
    void vClear(CRequestListModel* model);
    bool commit();
    void remove();

private:
    QSharedPointer<CRequest> m_poRequest;
    CRequestListModel* m_model;

    void assign(QSharedPointer<CRequest> poRequest);
};

#endif // CREQUESTEDITMODEL_H
