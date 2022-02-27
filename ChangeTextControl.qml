import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import Qt.labs.platform 1.1

Item {
    property alias combobox: combobox
    property alias lmodel: lmodel
    property TextArea ta
    RowLayout {
        anchors.fill: parent
        Layout.margins: 0
        Label {
            Layout.fillHeight: true
            Layout.preferredWidth: 30
            text: "字体"
            verticalAlignment: Text.AlignVCenter
        }
        ComboBox {
            id: fontcombobox
            Layout.fillHeight: true
            Layout.fillWidth: true
            model: Qt.fontFamilies()
            onCurrentIndexChanged: {
                var fs = Qt.fontFamilies()
                ta.font.family = fs[currentIndex]
            }
        }

        Label {
            Layout.fillHeight: true
            Layout.preferredWidth: 60
            text: "字体大小"
            verticalAlignment: Text.AlignVCenter
        }
        ComboBox {
            id: fontsizecombobox
            Layout.fillHeight: true
            Layout.fillWidth: true
            model:sizemodel
            ListModel{
                id : sizemodel
            }
            Component.onCompleted: {
                for(var i = 12; i < 33; ++i) {
                    var dd = {}
                    dd.dd = i
                    sizemodel.append(dd)
                    //                    sizemodel.append({
                    //                                         "dd" : i
                    //                                     })
                }
                fontsizecombobox.currentIndex = 0
            }
            onCurrentIndexChanged: {
                console.log(sizemodel.get(currentIndex).dd)
                ta.font.pointSize = sizemodel.get(currentIndex).dd
            }
        }

        Label {
            Layout.fillHeight: true
            Layout.preferredWidth: 40
            text: "背景色"
            verticalAlignment: Text.AlignVCenter
        }

        Button {
            Layout.fillHeight: true
            Layout.fillWidth:true
            text:"选择"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    colorDialog.open()
                }
            }
            ColorDialog {
                id: colorDialog
                title: qsTr("选择颜色")
                color: "#AAAAAA"
                onColorChanged: {
                    back.color = color
                    ta.background = back
                }
            }
        }

        Label {
            Layout.fillHeight: true
            Layout.preferredWidth: 60
            text: "字体颜色"
            verticalAlignment: Text.AlignVCenter
        }
        Button {
            Layout.fillHeight: true
            Layout.fillWidth:true
            text:"选择"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    colorDialog1.open()
                }
            }
            ColorDialog {
                id: colorDialog1
                title: qsTr("选择颜色")
                color: "#AAAAAA"
                onColorChanged: {
                    ta.color = color
                }
            }
        }

        Label {
            Layout.fillHeight: true
            Layout.preferredWidth: 60
            text: "章节目录"
            verticalAlignment: Text.AlignVCenter
        }

        ComboBox {
            id:combobox
            Layout.fillHeight: true
            Layout.fillWidth: true
            model : lmodel
            onCurrentIndexChanged: {
                var content = fileProcess.getChapterContent(combobox.currentIndex + 1)
                showText.text = content
                changeState()
            }
        }
        ListModel{
            id:lmodel
        }
    }
    Rectangle {
        id:back
        anchors.fill: ta
    }
}
