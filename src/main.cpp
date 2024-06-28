#include <auroraapp.h>
#include <QtQuick>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>

int main(int argc, char *argv[])
{
    QScopedPointer<QGuiApplication> application(Aurora::Application::application(argc, argv));
    application->setOrganizationName(QStringLiteral("ru.auroraos"));
    application->setApplicationName(QStringLiteral("Notes"));

    QScopedPointer<QQuickView> view(Aurora::Application::createView());
    view->setSource(Aurora::Application::pathTo(QStringLiteral("qml/Notes.qml")));
    view->show();

    return application->exec();
}

bool createConnection()
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("notes.db");

    if (!db.open()) {
        qWarning() << "Error opening database:" << db.lastError().text();
        return false;
    }

    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT)");

    return true;
}

void addNoteToDatabase(const QString &title, const QString &description)
{
    QSqlQuery query;
    query.prepare("INSERT INTO notes (title, description) VALUES (:title, :description)");
    query.bindValue(":title", title);
    query.bindValue(":description", description);
    if (!query.exec()) {
        qWarning() << "Error executing query:" << query.lastError().text();
    }
}

QStringList getNotesFromDatabase()
{
    QStringList notes;

    QSqlQuery query("SELECT title, description FROM notes");
    while (query.next()) {
        QString title = query.value(0).toString();
        QString description = query.value(1).toString();
        notes.append(title + ": " + description);
    }

    return notes;
}
