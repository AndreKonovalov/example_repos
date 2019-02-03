#include "crequest.h"

CRequest::CRequest(QObject *parent) : QObject(parent)
{

}

void CRequest::setField(int i, QString val) {
    switch (i) {
    case 0:
        setemail(val);
        break;
    case 1:
        setname(val);
        break;
    case 2:
        setsubject(val);
        break;
    case 3:
        settext(val);
        break;
    default:
        break;
    }
}
