#include "cuserdata.h"
#include "cregistrationmodel.h"

#include <QDebug>

CUserData::CUserData(QObject *parent) : QObject(parent)
{
}

void CUserData::clear() {
    m_email = "";
    m_name = "";
    m_lastname = "";
    m_password = "";
    m_password2 = "";
}

bool CUserData::commit() {
    CRegistrationModel* model = CRegistrationModel::getInstance();

    QStringList errors;
    qDebug() << "commit CUserData" << m_email << m_name << m_password << m_password2;
    if(m_email.isEmpty())
        errors << tr("Email must be set");
    else if(model->findEmail(m_email))
        errors << tr("User already exists");

    if(m_name.isEmpty())
        errors << tr("Name must be set");
    if(m_password.isEmpty())
        errors << tr("Password must be set");
    else if(m_password != m_password2)
        errors << tr("Password not confirmed");

    if (!errors.empty())
    {
        emit showErrors(errors);
        return false;
    }

    QSharedPointer<CUserData> ptr;
    CUserData* a = new CUserData();
    ptr.reset(a);
    ptr->setemail(m_email);
    ptr->setname(m_name);
    ptr->setpassword(m_password);
    ptr->setlastname(m_lastname);
    model->registerUser(ptr);
    qDebug() << "commit success" << model->count();
    return true;
}

bool CUserData::checkPassword() {
    CRegistrationModel* model = CRegistrationModel::getInstance();

    QStringList errors;
    qDebug() << "commit checkPassword" << m_email << m_name << m_password << m_password2;
    if(m_email.isEmpty())
        errors << tr("Email must be set");
    if(m_password.isEmpty())
        errors << tr("Password must be set");

    if(!model->setCurrent(m_email, m_password))
        errors << tr("Incorrect email/password");

    if (!errors.empty())
    {
        emit showErrors(errors);
        return false;
    }

    qDebug() << "checkPassword OK";
    return true;
}

void CUserData::setField(int i, QString val) {
    switch (i) {
    case 0:
        setemail(val);
        break;
    case 1:
        setname(val);
        break;
    case 2:
        setlastname(val);
        break;
    case 3:
        setpassword(val);
        break;
    default:
        break;
    }
}
