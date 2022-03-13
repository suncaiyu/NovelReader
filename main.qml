import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4
import QtQuick.Controls.Styles 1.4
import Furrain.FileProcess 1.0
import Qt.labs.platform 1.1
import Furrain.Reader 1.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    MyReader{
        id : myreader
    }

    FileProcess {
        id : fileProcess
    }
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        // 内容显示
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredHeight: 300
            Layout.margins: 0
            clip: true
            TextArea {
                id:showText
                text: "1"
                readOnly: true
                wrapMode: TextEdit.Wrap
                selectByMouse : true
                color:"#000000"
            }
        }

        ChangeTextControl {
            id:ctc
            Layout.fillWidth: true
            Layout.minimumHeight: 50
            Layout.maximumHeight: 50
            Layout.margins: 0
            ta:showText
        }

        // 上下章按钮
        ChangePageControlBar {
            id : cb
            Layout.fillWidth: true
            Layout.minimumHeight: 50
            Layout.maximumHeight: 50
            Layout.margins: 0
            Connections {
                target: cb.next
                onClicked : {
                    var index = fileProcess.getCurrentIndex()
                    ctc.combobox.currentIndex = index
                    changeState()
                }
            }
            prev.onClicked: {
                var index = fileProcess.getCurrentIndex()
                ctc.combobox.currentIndex = index - 2
                changeState()
            }
            onFilePath: {
                openFile(path)
            }
            onPage: {
                ctc.combobox.currentIndex = num - 1
                changeState()
            }
            onStartRead: {
                // TODO：目前只实现了阅读，没有界面跟随滚动的效果
                var text = showText.text
                myreader.say(text)
            }
        }
    }

    function changeState() {
        if (fileProcess.getCurrentIndex() == 1) {
            cb.prev.enabled = false
            cb.next.enabled = true
        } else if (fileProcess.getCurrentIndex() == fileProcess.getChapterSize()) {
            cb.next.enabled = false
            cb.prev.enabled = true
        } else {
            cb.next.enabled = true
            cb.prev.enabled = true
        }
    }
    onHeightChanged: {
        showText.update()
    }

    function openFile(str) {
        fileProcess.setFilePath(str);
        fileProcess.prepare()
        cb.max = fileProcess.getChapterSize()
        console.log(fileProcess.getChapterSize())
        var contents = fileProcess.getContents()
        for (var j = 0; j < contents.length; ++j) {
            var ob = {};
            ob.xx = contents[j]
            ctc.lmodel.append(ob);
        }
        ctc.combobox.currentIndex = 0
        changeState()
    }
}
