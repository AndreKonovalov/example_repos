#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <QDebug>

#include "clistcontroller.h"
#include "crequestlistmodel.h"
#include "crequesteditmodel.h"
#include "cregistrationmodel.h"

#include "cuserdata.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qDebug() << "before 0";

    QGuiApplication app(argc, argv);

    qmlRegisterType<CListController>("com.abc.qmlcomponents", 1, 0, "CListController");
    qmlRegisterType<CRequestListModel>("com.abc.qmlcomponents", 1, 0, "CRequestListModel");
    qmlRegisterType<CRequestEditModel>("com.abc.qmlcomponents", 1, 0, "CRequestEditModel");
    qmlRegisterType<CUserData>("com.abc.qmlcomponents", 1, 0, "CUserData");

    QQmlApplicationEngine engine;
    qDebug() << "before";
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    qDebug() << "after";
    if (engine.rootObjects().isEmpty())
        return -1;
    qDebug() << "after 2";

    //    QRegExp()
    QString string = "WTZMbHp3WHQpci4iAxoSBGkGODhDJjQHKGUvKylCKQIyYjVaNxERJg==";
    //QString string = "andre-konovalov@yandex.ru:c53aafde-8901-4a0d-9c1b-3c654bde73cb";
    //QString string = "bmlraXRhLmFudG9ub3ZAaGVscGRlc2tlZGR5LmNvbTphMzI4NThiNC1hNjVlLTQ5ZWYtYTk2MC0wYjdlOGQ1ZDFlNDc";
    QByteArray ba;
    ba.append(string);
//    ba = ba.toBase64();
    qDebug() << "ba" << ba.data();
    QByteArray text;
    text = QByteArray::fromBase64(ba);
    qDebug() << "text" << text.data();

    QSharedPointer<CRegistrationModel> regPtr = QSharedPointer<CRegistrationModel>(CRegistrationModel::getInstance());
    qDebug() << "before 2";
    return app.exec();
}

// QNetworkAccessManager
