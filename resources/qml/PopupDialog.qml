import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Dialog {
    id: popupDialog
    modal: true
    visible: false
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside


    property int dialogWidth: 360
    property int dialogHeight: 200

    title: "Enter Network Host and IP"
    font.family: "Roboto"
    font.pointSize: 18
    width: dialogWidth
    height: dialogHeight

    background: Rectangle {
        color: "white"
        radius: 8
    }

    ColumnLayout {
        id: mainLayout
        anchors.fill: parent
        spacing: 15

        TextField {
            id: input_filed_hostname
            Layout.fillWidth: true
            font.family: "Roboto"
            font.pointSize: 14
            placeholderText: "Hostname (e.g., mydevice)"

            background: Rectangle {
                color: "#f5f5f5"
                border.width: 1
                border.color: "#e0e0e0"
                radius: 4
            }
            padding: 8
        }

        TextField {
            id: input_filed_ip
            Layout.fillWidth: true
            font.family: "Roboto"
            font.pointSize: 14
            placeholderText: "IP Address (e.g., 192.168.1.100)"

            background: Rectangle {
                color: "#f5f5f5"
                border.width: 1
                border.color: "#e0e0e0"
                radius: 4
            }
            padding: 8
        }

        RowLayout {
            spacing: 10
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            Button {
                text: "Accept"
                font.family: "Roboto"
                font.pointSize: 14
                Layout.fillWidth: true
                Layout.preferredWidth: dialogWidth / 2 - 20

                background: Rectangle {
                    color: "#4caf50"
                    radius: 4
                }

                contentItem: Text {
                    color: "white"
                    font.family: "Roboto"
                    font.pointSize: 14
                    text: parent.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    ls_model.add_item(input_filed_hostname.text, input_filed_ip.text)
                    input_filed_hostname.text = ""
                    input_filed_ip.text = ""
                    popupDialog.close()
                }
            }

            Button {
                text: "Cancel"
                font.family: "Roboto"
                font.pointSize: 14
                Layout.fillWidth: true
                Layout.preferredWidth: dialogWidth / 2 - 20

                background: Rectangle {
                    color: "lightgray"
                    radius: 4
                }
                contentItem: Text {
                    color: "black"
                    font.family: "Roboto"
                    font.pointSize: 14
                    text: parent.text
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
                onClicked: {
                    popupDialog.visible = false
                    input_filed_hostname.text = ""
                    input_filed_ip.text = ""
                }
            }
        }
    }

    signal onAccepted(string host_name, string host_ip)
}
