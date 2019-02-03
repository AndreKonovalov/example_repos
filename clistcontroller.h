#ifndef CLISTCONTROLLER_H
#define CLISTCONTROLLER_H

#include <QObject>

namespace Mutronic {

class CListController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(int iCount READ iCount WRITE vSetCount NOTIFY vCountChanged)
    Q_PROPERTY(int iItemsPerPage READ iItemsPerPage WRITE vSetItemsPerPage NOTIFY vItemsPerPageChanged)
    Q_PROPERTY(int iCurrentItem READ iCurrentItem WRITE vSetCurrentItem NOTIFY vCurrentItemChanged)
    Q_PROPERTY(bool boIsPrevEnabled READ boIsPrevEnabled NOTIFY vIsPrevEnabledChanged)
    Q_PROPERTY(bool boIsNextEnabled READ boIsNextEnabled NOTIFY vIsNextEnabledChanged)

public:
    explicit CListController(QObject *parent = nullptr);
    ~CListController();

    int iCount() const;
    int iItemsPerPage() const;
    int iCurrentItem() const;
    bool boIsPrevEnabled() const { return m_boIsPrevEnabled; }
    bool boIsNextEnabled() const { return m_boIsNextEnabled; }
    Q_INVOKABLE void vPreviousItem();
    Q_INVOKABLE void vNextItem();
    Q_INVOKABLE void vPreviousPage();
    Q_INVOKABLE void vNextPage();

signals:
    void vCountChanged(int arg);
    void vItemsPerPageChanged(int arg);
    void vCurrentItemChanged(int arg);
    void vIsPrevEnabledChanged();
    void vIsNextEnabledChanged();

public slots:
    void vSetCount(int arg);
    void vSetItemsPerPage(int arg);
    void vSetCurrentItem(int arg);
    void vSetup(int newCount, int newIndex);

private:
    int m_iCount;
    int m_iItemsPerPage;
    int m_iCurrentItem;
    bool m_boIsPrevEnabled;
    bool m_boIsNextEnabled;
    int iGetValidIndex(int iIndex);
    void vSetNewCurrentItem(int iIndex);
    void vOnCountChanged();
    void vUpdateEnabled();
    void setPrevEnabled(bool enabled);
    void setNextEnabled(bool enabled);
};

}

#endif // CLISTCONTROLLER_H
