#ifndef CREGISTRATIONMODEL_H
#define CREGISTRATIONMODEL_H

#include <QObject>

class CRegistrationModel : public QObject
{
    Q_OBJECT
public:
    explicit CRegistrationModel(QObject *parent = nullptr);

signals:

public slots:
};

#endif // CREGISTRATIONMODEL_H