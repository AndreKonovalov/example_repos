#ifndef CREGISTRATIONMODEL_H
#define CREGISTRATIONMODEL_H

#include <QVector>
#include "cuserdata.h"

class CRegistrationModel // : public QObject
{
//    Q_OBJECT
public:
    explicit CRegistrationModel(); //QObject *parent = nullptr
    virtual ~CRegistrationModel();

    static CRegistrationModel* getInstance();

    int count() const;
    void registerUser(CUserData::Ptr item);
    CUserData::Ptr findEmail(QString email);
    CUserData::Ptr setCurrent(QString email, QString password);

signals:

public slots:
private:
    CUserData::Ptr m_current;
    QVector<CUserData::Ptr> m_collection;
    bool readFromFile();
    bool writeToFile();

};

#endif // CREGISTRATIONMODEL_H
