import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0

Page {
    objectName: "newNotePage"
    allowedOrientations: Orientation.All

    signal noteAdded(string title, string description)

    PageHeader {
        objectName: "pageHeader"
        title: qsTr("Add New Note")
    }

    Column {
        id: formContainer
        anchors {
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
            onEnableSoftwareInputPanelChanged:  { console.log("sdasdads")
                if (InputPanel.visible) {
                                                     // Клавиатура открыта, можно выполнить какие-то действия,
                                                     // например, сместить элементы вниз
                                                     textInput.y = 50; // Пример: смещаем элемент вниз на 50 единиц
                                                 } else {
                                                     // Клавиатура закрыта, можно вернуть элементы на исходное место
                                                     textInput.y = parent.height / 2 - textInput.height / 2;
                                                 }}
            id: titleField
            width: parent.width
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
                    insertNote(titleField.text, descriptionField.text);
                    noteAdded(titleField.text, descriptionField.text);
                    pageStack.pop();
                }
            }
        }
    }

    function insertNote(title, description) {
    var db = LocalStorage.openDatabaseSync("notesDB", "1.0", "NotesDatabase", 1000000)
    db.transaction(function (tx) {
     tx.executeSql("INSERT INTO notes (title, description)
     VALUES(?,?);", [title, description]);
    });
    }
}
