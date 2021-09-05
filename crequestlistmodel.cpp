#include "crequestlistmodel.h"

#include <QFile>
#include <QDebug>

CRequestListModel::CRequestListModel(QObject *parent)
    : CRecordListModel(parent), m_boIndexValid(), m_iCurrentIndex(-1)
{
    readFromFile();
}

CRequestListModel::~CRequestListModel() {
    writeToFile();
}

static QString requestFile = "D:\\request.txt";

#define NUM_FIELDS  4
bool CRequestListModel::readFromFile() {
    qDebug() << "readFromFile";
    QFile file(requestFile);
    if (file.open(QFile::ReadOnly | QFile::Text)) {
        QTextStream stream(&file);
        QString str, buf[NUM_FIELDS];
        int iRec = 1;
        int iField = 0;
        while(1) {
            if(stream.atEnd())
                break;
            str = stream.readLine();
            if(str == "#") {
                CRequest* ptr = new CRequest();
                ptr->setnumber(QString::number(iRec));
                for(int i = 0; i < NUM_FIELDS; i++) {
                    ptr->setField(i, buf[i]);
                    buf[i] = "";
                }
                QSharedPointer<CRequest> qptr(ptr);
                m_collection.push_back(qptr);

                iRec++;
                iField = 0;
            } else {
                if(iField < NUM_FIELDS) { buf[iField] = str; iField++; }
            }
        }
        file.close();
    }

    return true;
}

bool CRequestListModel::writeToFile() {
    qDebug() << "writeToFile";
    QFile file(requestFile);
    if (!file.open(QFile::WriteOnly | QFile::Text))
        return  false;
    QTextStream stream(&file);
    QString str, buf[NUM_FIELDS];
    foreach(auto ptr, m_collection) {
        stream << ptr->email() << "\n";
        stream << ptr->name() << "\n";
        stream << ptr->subject() << "\n";
        stream << ptr->text() << "\n";
        stream << "#" << "\n";
    }
    stream.flush();
    file.close();
    return true;
}

void CRequestListModel::setCurrent(CRequest::Ptr req)
{
    if (req)
        vSetCurrentIndex(getCollection().indexOf(req));
}

void CRequestListModel::vSetCurrentIndex(int currentIndex)
{
    if (m_iCurrentIndex != currentIndex)
    {
        m_iCurrentIndex = currentIndex;
        vCalcIndexValid();
        emit vCurrentIndexChanged();
    }
}

void CRequestListModel::vCalcIndexValid()
{
    bool indexValid = iCurrentIndex() != -1 && iCurrentIndex() < getCollection().size();
    if (m_boIndexValid != indexValid)
    {
        m_boIndexValid = indexValid;
        emit vIndexValidChanged();
    }
}

QSharedPointer<CRequest> CRequestListModel::getCurrentItem()
{
    return boIsIndexValid() ? getCollection()[m_iCurrentIndex] : QSharedPointer<CRequest>();
}

void CRequestListModel::setCollection(const QVector<CRequest::Ptr> &collection)
{
    beginResetModel();
    m_collection = collection;
    endResetModel();
    emit countChanged();
}

QObject *CRequestListModel::getRecord(int row) const
{
    return  m_collection[row].data();
}

void CRequestListModel::add(CRequest::Ptr item) {
    beginResetModel();
    m_collection.push_back(item);
    endResetModel();

    if (item)
        vSetCurrentIndex(getCollection().indexOf(item));
    emit countChanged();
}

void CRequestListModel::remove(CRequest::Ptr item)
{
    int iIndex = m_collection.indexOf(item);
    if (iIndex == -1)
        return;
    beginRemoveRows(QModelIndex(), iIndex, iIndex);
    m_collection.remove(iIndex);
    endRemoveRows();
    emit countChanged();
}

void CRequestListModel::insert(int iBeforeRow, CRequest::Ptr item)
{
    beginInsertRows(QModelIndex(), iBeforeRow, iBeforeRow);
    m_collection.insert(iBeforeRow, item);
    endInsertRows();
    emit countChanged();
}
