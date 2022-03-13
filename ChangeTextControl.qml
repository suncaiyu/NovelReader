import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import Qt.labs.platform 1.1
import "./Function.js" as Fun
Item {
    property alias combobox: combobox
    property alias lmodel: lmodel
    property TextArea ta
    RowLayout {
        anchors.fill: parent
        Layout.margins: 0
        Label {
            Layout.preferredWidth: 30
            text: "字体"
            verticalAlignment: Text.AlignVCenter
        }
        ComboBox {
            id: fontcombobox
            Layout.fillWidth: true
            model: fontModel
            onCurrentIndexChanged: {
                Fun.setFont(ta.font, fontModel, currentIndex)
            }
            ListModel {
                id : fontModel
            }
            Component.onCompleted: {
                Fun.initFonts(fontModel)
                currentIndex = 0
            }
        }

        Label {
            Layout.preferredWidth: 60
            text: "字体大小"
            verticalAlignment: Text.AlignVCenter
        }
        ComboBox {
            id: fontsizecombobox
            Layout.fillWidth: true
            model:sizemodel
            ListModel{
                id : sizemodel
            }
//            popup: Popup {    //弹出项
//                y: fontsizecombobox.height
//                width: fontsizecombobox.width
//                implicitHeight: contentItem.implicitHeight
//                padding: 1
//                //istView具有一个模型和一个委托。模型model定义了要显示的数据
//                contentItem: ListView {   //显示通过ListModel创建的模型中的数据
//                    clip: true
//                    implicitHeight: contentHeight
//                    model: fontsizecombobox.popup.visible ? fontsizecombobox.delegateModel : null
//                    maximumFlickVelocity:7000
//                }
//                background: Rectangle {
//                    border.color: "green"
//                    radius: 2
//                }
//            }
//            background: Rectangle {   //背景项
//                 implicitWidth: 120
//                 implicitHeight: 40
//                 color: "green"
//                 border.width: 1
//                 radius: 2
//             }
//            delegate: ItemDelegate { //呈现标准视图项 以在各种控件和控件中用作委托
//                width: fontsizecombobox.width
//                contentItem: Text {
//                    text: modelData   //即model中的数据
//                    color: "green"
//                    font: fontsizecombobox.font
//                    verticalAlignment: Text.AlignVCenter
//                }
//            }
//            contentItem: Text { //界面上显示出来的文字
//                 leftPadding: 5 //左部填充为5
//                 text: fontsizecombobox.displayText //表示ComboBox上显示的文本
//                 font: fontsizecombobox.font    //文字大小
//                 color: fontsizecombobox.pressed ? "orange" : "black"   //文字颜色
//                 verticalAlignment: Text.AlignVCenter  //文字位置
//             }
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
//                console.log(sizemodel.get(currentIndex).dd)
                ta.font.pointSize = sizemodel.get(currentIndex).dd
            }
        }

        Label {
            Layout.preferredWidth: 40
            text: "背景色"
            verticalAlignment: Text.AlignVCenter
        }

        Button {
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
            Component.onCompleted: {
                ta.background = back
            }
        }

        Label {
            Layout.preferredWidth: 60
            text: "字体颜色"
            verticalAlignment: Text.AlignVCenter
        }
        Button {
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
            Layout.preferredWidth: 60
            text: "章节目录"
            verticalAlignment: Text.AlignVCenter
        }

        ComboBox {
            id:combobox
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
        color:"#e6f3e9"
    }
}
