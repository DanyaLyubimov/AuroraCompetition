import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

Page {
    objectName: "editNotePage"
    allowedOrientations: Orientation.All

    signal noteUpdated()

    property string noteTitle: ""
    property string noteDescription: ""

    PageHeader {
        objectName: "pageHeader"
        title: qsTr("Edit Note")
    }

    Column {
        id: formContainer
        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 100
        }
        spacing: Theme.paddingLarge

        Label {
            text: qsTr("Title")
            font.pixelSize: Theme.fontSizeLarge
            horizontalAlignment: Text.AlignHCenter
        }

        TextField {
            id: titleField
            width: parent.width
            text: noteTitle
            placeholderText: qsTr("Enter note title")
        }

        Label {
            text: qsTr("Description")
            font.pixelSize: Theme.fontSizeLarge
            horizontalAlignment: Text.AlignHCenter
        }

        TextArea {
            id: descriptionField
            width: parent.width
            height: parent.height * 0.5
            text: noteDescription
            placeholderText: qsTr("Enter note description")
        }

        Rectangle {
            width: parent.width
            height: Theme.itemSizeSmall
            color: "#E0E0E0"
            radius: 5
            border.color: "#B0B0B0"
            border.width: 1

            Text {
                text: qsTr("Save Note")
                anchors.centerIn: parent
                font.pixelSize: Theme.fontSizeMedium
                color: "black"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    updateNote(titleField.text, descriptionField.text);
                    noteUpdated();
                    pageStack.pop();
                }
            }
        }
    }

    function loadNote(title, description) {
        noteTitle = title;
        noteDescription = description;
    }

    function updateNote(title, description) {
        var db = LocalStorage.openDatabaseSync("notesDB", "1.0", "NotesDatabase", 1000000)
        db.transaction(function(tx) {
            tx.executeSql("UPDATE notes SET title = ?, description = ? WHERE title = ?", [title, description, noteTitle]);
        });
    }
}
