#ifndef CUSERDATA_H
#define CUSERDATA_H

#include <QObject>

class CUserData : public QObject
{
    Q_OBJECT
public:
    explicit CUserData(QObject *parent = nullptr);

signals:

public slots:
};

#endif // CUSERDATA_H