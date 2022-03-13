import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import Qt.labs.platform 1.1

Item {
    property alias prev: prevPageButton
    property alias next: nextPageButton
    property var max : 0
    signal filePath(var path)
    signal page(var num)
    signal startRead()
    RowLayout{
        anchors.fill: parent
        Button {
            Layout.preferredWidth: 60
            Layout.margins: 0
            text:"打开..."
            onClicked: {
                fd.open()
            }
        }

        TextField {
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: 100
            validator: RegExpValidator{regExp:/[0-9]+/}
            color:"#FFFFFF"
            onTextChanged: {
                console.log(max)
                var num = parseInt(text)
                if (num > max) {
                    text = max + ""
                }
            }
            Keys.enabled: true
            Keys.onEnterPressed: {
                page(parseInt(text))
            }
            Keys.onReturnPressed: {
                page(parseInt(text))
            }
            placeholderText: "输入跳转的章节"
        }
        Button{
            id : readtext
            Layout.fillWidth: true
            Layout.margins: 0
            text:"Read"
            onClicked: {
                startRead()
            }
        }
        Button{
            id : prevPageButton
            Layout.fillWidth: true
            Layout.margins: 0
            text:"上一章"
        }
        Button{
            id : nextPageButton
            Layout.fillWidth: true
            Layout.margins: 0
            text:"下一章"
        }
    }
    FileDialog{
        id : fd
        nameFilters: ["txt文件 (*.txt)"]
        onFileChanged:{
            var src = fd.file.toLocaleString()
            console.log(src.substring(8, src.length))
            filePath(src.substring(8, src.length))
        }
    }
}
