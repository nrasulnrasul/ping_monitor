import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
    id: root
    width: parent ? parent.width : 0
    height: 90
    property bool isSelected: listView.currentIndex === index
    Rectangle {
        id: background
        anchors.fill: parent
        color: isSelected ? "#e0f7fa" : "white"
        border.width: 1
        border.color: isSelected ? "#80deea" : "#eeeeee"

        Row {
            spacing: 16
            anchors.fill: parent
            anchors.margins: 10

            Column {
                width: parent.width - 60
                spacing: 10

                Rectangle {
                    height: 20
                    width: parent.width
                    anchors.left: parent.left
                    id: name_row
                    color: background.color

                    Text {
                        text: name
                        font.family: "Roboto"
                        font.pointSize: 16
                        color: "#212121"
                        anchors.left: parent.left
                    }
                }

                Rectangle {
                    height: 20
                    width: parent.width -70
                    id: ip_row
                    color: background.color

                    Text {
                        text: ip
                        font.family: "Roboto"
                        font.pointSize: 12
                        color: "#757575"
                        anchors.left: parent.left
                    }
                }

                Rectangle {
                    height: 20
                    width: parent.width -70
                    id: status_row
                    color: background.color

                    Text {
                        text: info
                        font.family: "Roboto"
                        font.pointSize: 12
                        color: "#757575"
                        anchors.left: parent.left
                    }
                }
            }

            Rectangle {
                id: status_icon
                anchors.right: parent.right
                //x: name_row.width + 10
                //y: root.height/2 - 20
                height: 40
                width: 40
                radius: 20

                color: is_reachable ? "seagreen" : "mistyrose"

                Image {
                    source: "../icons/signal.svg"
                    sourceSize: Qt.size(24, 24)
                    anchors.centerIn: parent
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: listView.currentIndex = index
        }
    }
}
