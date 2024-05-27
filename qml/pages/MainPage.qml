import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    objectName: "mainPage"
    allowedOrientations: Orientation.All

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
            anchors.bottom: notesListView.top
            anchors.bottomMargin:30
            horizontalAlignment: Text.AlignHCenter
        }

    ListView {
        id: notesListView
        objectName: "notesListView"
        anchors.fill: parent
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 200
        anchors.leftMargin: 100
        anchors.rightMargin: 100
        spacing: 20
        model: ListModel {
            ListElement {
                title: "Note 1"
                description: "This is the description of note 1."
            }
            ListElement {
                title: "Note 2"
                description: "This is the description of note 2."
            }
            ListElement {
                title: "Note 3"
                description: "This is the description of note 3."
            }
            ListElement {
                title: "Note 4"
                description: "This is the description of note 4."
            }
            ListElement {
                title: "Note 5"
                description: "This is the description of note 5."
            }
            ListElement {
                title: "Note 6"
                description: "This is the description of note 6."
            }
        }

        delegate: Item {
            width: parent.width
            height: Theme.itemSizeMedium

            Rectangle {
                width: parent.width
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
                    }
                    Label {
                        text: model.description
                        font.pixelSize: Theme.fontSizeSmall
                        elide: Label.ElideRight
                    }
                }
            }
        }
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        Button {
            objectName: "addNoteButton"
            icon.source: "image://theme/icon-m-add"
            onClicked: pageStack.push(Qt.resolvedUrl("NewNotePage.qml"))
        }
    }
}


