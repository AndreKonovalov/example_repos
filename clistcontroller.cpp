#include "clistcontroller.h"

CListController::CListController(QObject *parent) :
    QObject(parent),
    m_iCount(0),
    m_iItemsPerPage(10),
    m_iCurrentItem(0),
    m_boIsPrevEnabled(false),
    m_boIsNextEnabled(false)
{
}

CListController::~CListController()
{

}

int CListController::iCount() const
{
    return m_iCount;
}

int CListController::iItemsPerPage() const
{
    return m_iItemsPerPage;
}

int CListController::iCurrentItem() const
{
    return m_iCurrentItem;
}

void CListController::vPreviousItem()
{
    vSetNewCurrentItem(iCurrentItem() - 1);
}

void CListController::vNextItem()
{
    vSetNewCurrentItem(iCurrentItem() + 1);
}

void CListController::vPreviousPage()
{
    vSetNewCurrentItem(iCurrentItem() - iItemsPerPage());
}

void CListController::vNextPage()
{
    vSetNewCurrentItem(iCurrentItem() + iItemsPerPage());
}

void CListController::vSetCount(int arg)
{
    if (m_iCount != arg) {
        m_iCount = arg;
        vOnCountChanged();
        emit vCountChanged(arg);
    }
}

void CListController::vSetItemsPerPage(int arg)
{
    if (m_iItemsPerPage != arg) {
        m_iItemsPerPage = arg;
        emit vItemsPerPageChanged(arg);
    }
}

void CListController::vSetCurrentItem(int arg)
{
    if (m_iCurrentItem != arg) {
        m_iCurrentItem = arg;
        emit vCurrentItemChanged(arg);
        vUpdateEnabled();
    }
}

void CListController::vSetup(int newCount, int newIndex)
{
    m_iCount = newCount;
    emit vCountChanged(newCount);
    vSetNewCurrentItem(newIndex);
    emit vCurrentItemChanged(iCurrentItem());
    vUpdateEnabled();
}

int CListController::iGetValidIndex(int iIndex)
{
    if (iCount() <= 0) return -1;
    if (iIndex >= iCount()) return iCount() - 1;
    if (iIndex < 0) return 0;

    return iIndex;
}

void CListController::vSetNewCurrentItem(int iIndex)
{
    vSetCurrentItem(iGetValidIndex(iIndex));
}

void CListController::vOnCountChanged()
{
    vSetNewCurrentItem(iCurrentItem());
    vUpdateEnabled();
}

void CListController::vUpdateEnabled()
{
    setPrevEnabled(iCurrentItem() > 0);
    setNextEnabled(iCurrentItem() < iCount() - 1);
}

void CListController::setPrevEnabled(bool enabled)
{
    if (m_boIsPrevEnabled != enabled) {
        m_boIsPrevEnabled = enabled;
        emit vIsPrevEnabledChanged();
    }
}

void CListController::setNextEnabled(bool enabled)
{
    if (m_boIsNextEnabled != enabled) {
        m_boIsNextEnabled = enabled;
        emit vIsNextEnabledChanged();
    }
}
