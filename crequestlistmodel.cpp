#include "crequestlistmodel.h"

#include <QFile>
#include <QDebug>

//STATIC(qmlRegisterType<CRequestListModel>("com.abc.qmlcomponents", 1, 0, "CRequestListModel"))

CRequestListModel::CRequestListModel(QObject *parent)
    : CRecordListModel(parent), m_boIndexValid(), m_iCurrentIndex(-1)
{
    readFromFile();
}

CRequestListModel::~CRequestListModel() {
    writeToFile();
}

#define NUM_FIELDS  4
bool CRequestListModel::readFromFile() {
    qDebug() << "readFromFile";
    QFile file("D:\\0Mutronic\\a12.txt");
    if (file.open(QFile::ReadOnly | QFile::Text)) {
        QTextStream stream(&file);
        QString str, buf[NUM_FIELDS];
        int iRec = 1;
        int iField = 0;
        qDebug() << "begin" << iRec << iField;
        while(1) {
            if(stream.atEnd())
                break;
            str = stream.readLine();
            qDebug() << "str" << iRec << iField << str;
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

//    CRequest* ptr = new CRequest();
//    ptr->setnumber("1");
//    QSharedPointer<CRequest> qptr(ptr);
//    m_collection.push_back(qptr);
//    ptr = new CRequest();
//    ptr->setnumber("2");
//    qptr = QSharedPointer<CRequest>(ptr);
//    m_collection.push_back(qptr);

    return true;
}

bool CRequestListModel::writeToFile() {
    qDebug() << "writeToFile";
    QFile file("D:\\0Mutronic\\b12.txt");
//    QFile file("a12.txt");
    if (!file.open(QFile::WriteOnly | QFile::Text)) {
        qDebug() << "false" << m_collection.count();
        return  false;
    }
    qDebug() << "write" << m_collection.count();
    QTextStream stream(&file);
    QString str, buf[NUM_FIELDS];
    foreach(auto ptr, m_collection) {
        qDebug() << "ptr" << ptr->email() << ptr->name() << ptr->subject() << ptr->text();
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

void CRequestListModel::setCurrent(CRequest::Ptr duese)
{
    if (duese)
        vSetCurrentIndex(getCollection().indexOf(duese));
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
    foreach (auto oldObject, m_collection)
    {
        if (!collection.contains(oldObject))
            deleteRecord(oldObject);
    }
    m_collection = collection;
//    qSort(m_collection);
    endResetModel();
    emit countChanged();
}

void CRequestListModel::sort()
{
    emit layoutAboutToBeChanged();
//    qSort(m_collection);
    emit layoutChanged();
}


QObject *CRequestListModel::getRecord(int row) const
{
    CRequest* object = m_collection[row].data();
    qDebug() << "getRecord" << object->name() << object->number();
    return object;
}

void CRequestListModel::createRecord(CRequest::Ptr object)
{
//    auto record = new CRequest(this);
//    m_records[object] = record;
}

void CRequestListModel::deleteRecord(CRequest::Ptr object)
{
//    if (!m_records.contains(object))
//        return;

//    delete m_records[object];
//    m_records.remove(object);
}

void CRequestListModel::add(CRequest::Ptr item) {
//    beginInsertRows(QModelIndex(), 0, 0);
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
//    deleteRecord(item);
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
