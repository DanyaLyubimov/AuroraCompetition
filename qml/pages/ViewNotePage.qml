import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "viewNotePage"
    allowedOrientations: Orientation.All

    property string noteTitle: ""
    property string noteDescription: ""

    PageHeader {
        id: pageHeader
        objectName: "pageHeader"
        title: qsTr("View Note")
    }

    Column {
        id: formContainer
        anchors {
            top: pageHeader.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 20
        }
        spacing: Theme.paddingLarge

        Rectangle {
            width: parent.width - 40
            height: Theme.itemSizeMedium + 40
            color: "#f5f5f5"
            radius: 10
            border.color: "#cccccc"
            border.width: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20

            Column {
                anchors.fill: parent
                anchors.margins: 20

                Label {
                    text: qsTr("Title")
                    font.pixelSize: Theme.fontSizeLarge
                    color: "#333333"
                    leftPadding: 10
                    rightPadding: 10

                }

                Label {
                    id: titleLabel
                    text: noteTitle
                    leftPadding: 10
                    rightPadding: 10

                    wrapMode: Text.WordWrap
                    color: "#555555"
                    font.pixelSize: Theme.fontSizeMedium
                }
            }
        }

        Rectangle {
            width: parent.width - 40
            height: parent.height * 0.5
            color: "#ffffff"
            radius: 10
            border.color: "#cccccc"
            border.width: 1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20

            Column {
                anchors.fill: parent
                anchors.margins: 20

                Label {
                    text: qsTr("Description")
                    leftPadding: 10
                    rightPadding: 10
                    font.pixelSize: Theme.fontSizeLarge
                    color: "#333333"
                }

                Label {
                    id: descriptionLabel
                    leftPadding: 10
                    rightPadding: 10
                    text: noteDescription
                    width: parent.width
                    wrapMode: Text.WordWrap
                    color: "#555555"
                    font.pixelSize: Theme.fontSizeMedium
                }
            }
        }

        Item {
            width: parent.width
            height: 20
        }

        Button {
            text: qsTr("Back")
            onClicked: pageStack.pop()
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width * 0.5
            anchors.topMargin: 20

            // Изменение цвета текста
            color: "white"
        }

        Item {
            width: parent.width
            height: 20
        }
    }

    function loadNote(title, description) {
        noteTitle = title;
        noteDescription = description;
    }
}
