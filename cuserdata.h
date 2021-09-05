#ifndef CUSERDATA_H
#define CUSERDATA_H

#include <QObject>
#include <QString>
#include <QSharedPointer>

class CUserData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString email READ email WRITE setemail NOTIFY emailChanged)
    Q_PROPERTY(QString name READ name WRITE setname NOTIFY nameChanged)
    Q_PROPERTY(QString lastname READ lastname WRITE setlastname NOTIFY lastnameChanged)
    Q_PROPERTY(QString password READ password WRITE setpassword NOTIFY passwordChanged)
    Q_PROPERTY(QString password2 READ password2 WRITE setpassword2 NOTIFY password2Changed)
public:
    typedef QSharedPointer<CUserData> Ptr;

    explicit CUserData(QObject *parent = nullptr);

    Q_INVOKABLE void clear();
    Q_INVOKABLE bool commit();
    Q_INVOKABLE bool checkPassword();

    QString email() const {
        return m_email;
    }
    QString name() const {
        return m_name;
    }
    QString lastname() const {
        return m_lastname;
    }
    QString password() const {
        return m_password;
    }
    QString password2() const {
        return m_password2;
    }
    void setField(int i, QString val);

signals:
    void showErrors(const QStringList &errors);

    void emailChanged();
    void nameChanged();
    void lastnameChanged();
    void passwordChanged();
    void password2Changed();

public slots:
    void setemail(QString arg) {
        if (m_email != arg) {
            m_email = arg;
            emit emailChanged();
        }
    }
    void setname(QString arg) {
        if (m_name != arg) {
            m_name = arg;
            emit nameChanged();
        }
    }
    void setlastname(QString arg) {
        if (m_lastname != arg) {
            m_lastname = arg;
            emit lastnameChanged();
        }
    }
    void setpassword(QString arg) {
        if (m_password != arg) {
            m_password = arg;
            emit passwordChanged();
        }
    }
    void setpassword2(QString arg) {
        if (m_password2 != arg) {
            m_password2 = arg;
            emit password2Changed();
        }
    }

private:
    QString m_email;
    QString m_name;
    QString m_lastname;
    QString m_password;
    QString m_password2;
};

#endif // CUSERDATA_H
