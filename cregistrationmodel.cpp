#include "cregistrationmodel.h"

#include <QFile>
#include <QDebug>

static CRegistrationModel* registrationModel;

CRegistrationModel* CRegistrationModel::getInstance() {
    if(!registrationModel)
        registrationModel = new CRegistrationModel();
    return registrationModel;
}

CRegistrationModel::CRegistrationModel()
{
    readFromFile();
}

CRegistrationModel::~CRegistrationModel() {
    qDebug() << "Destr of CRegistrationModel";
    writeToFile();
    registrationModel = nullptr;
}

CUserData::Ptr CRegistrationModel::findEmail(QString email) {
    qDebug() << "findEmail0" << email << m_collection.count();
    foreach(auto ptr, m_collection) {
        qDebug() << "findEmail" << ptr->email() << email;
        if(ptr->email() == email)
            return ptr;
    }

    qDebug() << "findEmail not found" << email;
    return CUserData::Ptr();
}

int CRegistrationModel::count() const {
    return m_collection.count();
}

void CRegistrationModel::registerUser(CUserData::Ptr item) {
    m_collection.push_back(item);
    m_current = item;
}

CUserData::Ptr CRegistrationModel::setCurrent(QString email, QString password) {
    CUserData::Ptr ptr = findEmail(email);
    if(!ptr)
        return ptr;
    qDebug() << "setCurrent" << email << ptr->email() << password << ptr->password();
    if(ptr->password() == password) {
        m_current = ptr;
        return ptr;
    }

    return CUserData::Ptr();
}

static QString registrFile = "D:\\registration.txt";

#define NUM_FIELDS  4
bool CRegistrationModel::readFromFile() {
    qDebug() << "readFromFile CRegistrationModel";
    QFile file(registrFile);
    if (file.open(QFile::ReadOnly | QFile::Text)) {
        QTextStream stream(&file);
        QString str, buf[NUM_FIELDS];
        int iRec = 0;
        int iField = 0;
        while(1) {
            if(stream.atEnd())
                break;
            str = stream.readLine();
            if(str == "#") {
                CUserData* ptr = new CUserData();
                for(int i = 0; i < NUM_FIELDS; i++) {
                    ptr->setField(i, buf[i]);
                    buf[i] = "";
                }
                QSharedPointer<CUserData> qptr(ptr);
                m_collection.push_back(qptr);

                iRec++;
                iField = 0;
            } else {
                if(iField < NUM_FIELDS) { buf[iField] = str; iField++; }
            }
        }
        file.close();
        qDebug() << "readFromFile end CRegistrationModel" << iRec;
    }

    return true;
}

bool CRegistrationModel::writeToFile() {
    qDebug() << "writeToFile CRegistrationModel";
    QFile file(registrFile);
    if(!file.open(QFile::WriteOnly | QFile::Text))
        return  false;
    QTextStream stream(&file);
    QString str, buf[NUM_FIELDS];
    foreach(auto ptr, m_collection) {
        stream << ptr->email() << "\n";
        stream << ptr->name() << "\n";
        stream << ptr->lastname() << "\n";
        stream << ptr->password() << "\n";
        stream << "#" << "\n";
    }
    stream.flush();
    file.close();
    qDebug() << "write end" << m_collection.count();
    return true;
}
