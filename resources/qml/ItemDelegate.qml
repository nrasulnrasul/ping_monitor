import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
    id: root
    width: parent ? parent.width : 0
    height: 90
    property bool isSelected: listView.currentIndex === index

    // Define properties for dimensions and spacing
    property int itemHeight: 90
    property int borderRadius: 8
    property int margin: 16
    property int spacing: 8
    property int iconSize: 40
    property int iconRadius: 20
    property int textSizeName: 16
    property int textSizeIpInfo: 14

    Rectangle {
        id: background
        anchors.fill: parent
        color: isSelected ? "#e0f7fa" : "white"
        border.width: 1
        border.color: isSelected ? "#80deea" : "#eeeeee"
        radius: borderRadius

        Row {
            spacing: spacing
            anchors.fill: parent
            anchors.margins: margin

            // Column for text elements
            Column {
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - iconSize - spacing

                Text {
                    text: name
                    font.family: "Roboto"
                    font.pointSize: textSizeName
                    font.bold: true
                    color: "#212121"
                    width: parent.width
                    elide: Text.ElideRight
                }

                Text {
                    text: ip
                    font.family: "Roboto"
                    font.pointSize: textSizeIpInfo
                    color: "#757575"
                    width: parent.width
                    elide: Text.ElideRight
                }

                Text {
                    text: info
                    font.family: "Roboto"
                    font.pointSize: textSizeIpInfo
                    color: "#757575"
                    width: parent.width
                    elide: Text.ElideRight
                }
            }

            // Status icon
            Rectangle {
                id: status_icon
                height: iconSize
                width: iconSize
                radius: iconRadius
                color: is_reachable ? "#4caf50" : "#f44336"

                Image {
                    source: "../icons/signal.svg"
                    sourceSize: Qt.size(iconSize - 8, iconSize - 8)
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