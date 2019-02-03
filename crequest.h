#ifndef CREQUEST_H
#define CREQUEST_H

#include <QObject>
#include <QSharedPointer>

class CRequest : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString number READ number WRITE setnumber NOTIFY numberChanged)
    Q_PROPERTY(QString email READ email WRITE setemail NOTIFY emailChanged)
    Q_PROPERTY(QString name READ name WRITE setname NOTIFY nameChanged)
    Q_PROPERTY(QString subject READ subject WRITE setsubject NOTIFY subjectChanged)
    Q_PROPERTY(QString text READ text WRITE settext NOTIFY textChanged)
public:
    typedef QSharedPointer<CRequest> Ptr;

    explicit CRequest(QObject *parent = nullptr);

    QString number() const {
        return m_number;
    }
    QString email() const {
        return m_email;
    }
    QString name() const {
        return m_name;
    }
    QString subject() const {
        return m_subject;
    }
    QString text() const {
        return m_text;
    }

    void setField(int i, QString val);

signals:
    void numberChanged(QString arg);
    void emailChanged(QString arg);
    void nameChanged(QString arg);
    void subjectChanged(QString arg);
    void textChanged(QString arg);

public slots:
    void setnumber(QString arg) {
        if (m_number != arg) {
            m_number = arg;
            emit numberChanged(arg);
        }
    }
    void setemail(QString arg) {
        if (m_email != arg) {
            m_email = arg;
            emit emailChanged(arg);
        }
    }
    void setname(QString arg) {
        if (m_name != arg) {
            m_name = arg;
            emit nameChanged(arg);
        }
    }
    void setsubject(QString arg) {
        if (m_subject != arg) {
            m_subject = arg;
            emit subjectChanged(arg);
        }
    }
    void settext(QString arg) {
        if (m_text != arg) {
            m_text = arg;
            emit textChanged(arg);
        }
    }

protected:
    QString m_number;
    QString m_email;
    QString m_name;
    QString m_subject;
    QString m_text;
};

#endif // CREQUEST_H
