import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "../qml"

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: "Ping Monitor"

    menuBar: MainMenu {}

    PopupDialog {
        id: addNodePopup
        dialogWidth: parent.width
        onAccepted: {
            ls_model.add_item(host_name, host_ip)
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#ffffff"

        ListView {
            id: listView
            anchors.fill: parent
            model: ls_model
            delegate: ItemDelegate{}
            focus: true
        }

        Button {
            id: add_button
            text: "Add"
            width: parent.width
            height: 50
            icon.source: "../icons/add.svg"
            anchors.bottom: remove_button.top
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                addNodePopup.visible = true
            }
        }

        Button {
            id: remove_button
            text: "Remove"
            icon.source: "../icons/delete.svg"
            width: parent.width
            height: 50
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                if (listView.currentIndex >= 0) {
                    ls_model.remove_item(listView.currentIndex)
                }
            }
        }
    }
}