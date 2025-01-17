import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

    signal addNoteRequested()

    PageHeader {
        objectName: "pageHeader"
        id: pageHeader
        title: qsTr("Notes")
        extraContent.children: [
            IconButton {
                objectName: "aboutButton"
                icon.source: "image://theme/icon-m-about"
                anchors.verticalCenter: parent.verticalCenter

                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        ]
    }

    Label {
        id: headerLabel
        text: qsTr("My Notes")
        font.pixelSize: Theme.fontSizeExtraLarge
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin:30
        horizontalAlignment: Text.AlignHCenter
    }

    ListView {
            id:  noteListView
            anchors.top: headerLabel.bottom
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.margins: 100
            spacing: 20
            model: ListModel {
                id: notesModel
            }

            delegate: Item {
                height: Theme.itemSizeMedium
                Row{
                    Rectangle {
                        width: noteListView.width
                        height: Theme.itemSizeMedium
                        color: "#69adb5"
                        radius: 5
                        border.color: "#D0D0D0"
                        border.width: 1

                        Column {
                            anchors.fill: parent
                            anchors.margins: 10
                            width: parent.width
                            anchors.verticalCenter: parent.verticalCenter

                            Label {
                                text: model.title
                                font.pixelSize: Theme.fontSizeLarge
                                elide: Label.ElideRight
                               horizontalAlignment: Text.AlignLeft
                               width: parent.width*0.6
                            }
                            Label {
                                text: model.description
                                font.pixelSize: Theme.fontSizeSmall
                                elide: Label.ElideRight
                               horizontalAlignment: Text.AlignLeft
                               width: parent.width
                            }

                        }
                        MouseArea {
                               anchors.fill: parent
                               onClicked: {
                                   var viewNotePage = pageStack.push(Qt.resolvedUrl("ViewNotePage.qml"));
                                   viewNotePage.loadNote(model.title, model.description);
                               }
                               onPressAndHold: {
                                   var editNotePage = pageStack.push(Qt.resolvedUrl("EditNotePage.qml"));
                                   editNotePage.loadNote(model.title, model.description);
                                   editNotePage.noteUpdated.connect(selectNotes);
                               }
                           }

                        Button {
                         id: btnDelete
                         text: "Edit"
                         onClicked: {
                             var editNotePage = pageStack.push(Qt.resolvedUrl("EditNotePage.qml"));
                             editNotePage.loadNote(model.title, model.description);
                             editNotePage.noteUpdated.connect(selectNotes); // Подключение сигнала к функции обновления
                         }
                         anchors.right: parent.right
                         width:parent.width*0.3
                         height: Theme.fontSizeLarge
                         }
                    }

                }
            }
        }

    Component.onCompleted:{
        initializeDatabase();
        selectNotes();
        ;
    }



    Column {
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        Button {
            objectName: "addNoteButton"
            text: "Добавить"
            icon.source: "image://theme/icon-m-add"
            onClicked: addNoteRequested()
        }

        Button {
            objectName: "avf"
            text: "Обновить"
            icon.source: "image://theme/icon-m-add"
            onClicked: selectNotes()
        }

        Button {
            objectName: "avf"
            text: "Удалить"
            icon.source: "image://theme/icon-m-add"
            onClicked:{ clearNotes();
                selectNotes();}
        }
    }

    onAddNoteRequested: {
            var newNotePage = pageStack.push(Qt.resolvedUrl("NewNotePage.qml"));
            newNotePage.noteAdded.connect(selectNotes); // Подключение сигнала к функции обновления
    }

    function initializeDatabase() {
         var db = LocalStorage.openDatabaseSync("notesDB", "1.0", "NotesDatabase", 1000000)
         db.transaction(function(tx) {
            tx.executeSql('CREATE TABLE IF NOT EXISTS notes(title TEXT, description TEXT)')
            console.log("Таблица создана")
         })
     }

    function selectNotes(){
        var db = LocalStorage.openDatabaseSync("notesDB", "1.0", "NotesDatabase", 1000000)
        db.transaction(function (tx) {
            var results = tx.executeSql('SELECT title, description FROM notes ')
            notesModel.clear()
            for (var i = 0; i < results.rows.length; i++) {
                notesModel.append({
                    title: results.rows.item(i).title,
                    description: results.rows.item(i).description
                })
            }
        })
    }

    function  clearNotes() {
    var db = LocalStorage.openDatabaseSync("notesDB", "1.0", "NotesDatabase", 1000000)
    db.transaction(function (tx) {
     tx.executeSql("DELETE FROM notes");
    });
    }

    function  deleteNote(title) {
    var db = LocalStorage.openDatabaseSync("notesDB", "1.0", "NotesDatabase", 1000000)
    db.transaction(function (tx) {
     tx.executeSql("DELETE FROM notes WHERE title LIKE ?", [title]);
    });
    }

    function insertNote(title, description) {
    var db = LocalStorage.openDatabaseSync("notesDB", "1.0", "NotesDatabase", 1000000)
    db.transaction(function (tx) {
     tx.executeSql("INSERT INTO notes (title, description)
     VALUES(?,?);", [title, description]);
    });
    }
}
