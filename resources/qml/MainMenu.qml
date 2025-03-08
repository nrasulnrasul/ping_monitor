import QtQuick 2.15
import QtQuick.Controls 2.15

MenuBar {
    Menu {
        title: "File"
        MenuItem {
            text: "Load"
            onTriggered: console.log("New selected")
        }
        MenuItem {
            text: "Exit"
            onTriggered: Qt.quit()
        }
    }

    Menu {
        title: "Help"
        MenuItem {
            text: "About"
            onTriggered: aboutDialog.open()
        }
    }

    Dialog {
        id: aboutDialog
        title: "About"
        modal: true
        width: 400
        height: 250
        standardButtons: Dialog.Ok
        contentItem: Column {
            spacing: 10
            Text {
                text: "Ping Monitor App\nVersion 0.1.0\n(c) 2024 Nayabrasul Shaik"
                font.pixelSize: 14
            }
        }
    }
}


