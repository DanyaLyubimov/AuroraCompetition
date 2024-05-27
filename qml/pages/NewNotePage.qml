import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "newNotePage"
    allowedOrientations: Orientation.All

    PageHeader {
        objectName: "pageHeader"
        title: qsTr("Add New Note")
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
                    console.log("Title: " + titleField.text)
                    console.log("Description: " + descriptionField.text)
                }
            }
        }
    }
}
