#include "crequesteditmodel.h"

#include <QDebug>

CRequestEditModel::CRequestEditModel(QObject *parent) : CRequest(parent)
{

}

void CRequestEditModel::vAssignFrom(CRequestListModel* model) {
    qDebug() << "vAssignFrom" << model->iCurrentIndex();
    m_model = model;
    assign(model->getCurrentItem());
}

void CRequestEditModel::vClear(CRequestListModel* model) {
    qDebug() << "vCleare";
    m_model = model;
    assign(QSharedPointer<CRequest>());
}

bool CRequestEditModel::commit() {
    QStringList errors;
    qDebug() << "commit" << m_email << m_name << m_subject << m_text;
    if(m_email.isEmpty())
        errors << tr("Email must be set.");
    if(m_name.isEmpty())
        errors << tr("Name must be set.");
    if(m_subject.isEmpty())
        errors << tr("Subject must be set.");
    if (!errors.empty())
    {
        emit showErrors(errors);
        return false;
    }

    QSharedPointer<CRequest> ptr = m_poRequest;
    if(!ptr) {
        CRequest* a = new CRequest();
        a->setnumber(QString::number(m_model->getCollection().count() + 1));
        ptr.reset(a);
        qDebug() << "before add" << m_model->getCollection().count();
        m_model->add(ptr);
    }
    ptr->setemail(m_email);
    ptr->setname(m_name);
    ptr->setsubject(m_subject);
    ptr->settext(m_text);
    qDebug() << "commit success" << m_model->getCollection().count();
    return true;
}

void CRequestEditModel::remove() {
    return;
}

void CRequestEditModel::assign(QSharedPointer<CRequest> poRequest)
{
    m_poRequest = poRequest;
    if(poRequest) {
        setemail(poRequest->email());
        setname(poRequest->name());
        setsubject(poRequest->subject());
        settext(poRequest->text());
    } else {
        setemail(QString());
        setname(QString());
        setsubject(QString());
        settext(QString());
    }
}
