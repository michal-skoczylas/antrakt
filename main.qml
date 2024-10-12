import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.15
import QtCore
import QtQuick.Dialogs
import QtQuick.Layouts 2.15
import "colors.js" as Colors

Window {
    id: window
    width: 640
    height: 480
    visible: true
    color: Colors.primary800
    title: qsTr("Antrakt")

    Rectangle {
        id: backgroud
        color: Colors.primary300
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Rectangle {
            id: buttonBackground
            y: 0
            color: Colors.primary300
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 472
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0

            Rectangle {
                id: btnBckg
                color: Colors.primary500
                radius: 10
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 320

                ColumnLayout {
                    id: columnLayout
                    x: 0
                    y: 0
                    width: 148
                    height: 150
                    spacing: 2

                    CustomButton {
                        id: customPdfButton
                        width: 139
                        height: 35
                        text: "Generate"
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        onClicked: {

                            saveFileDialog.open()
                        }
                    }

                    CustomButton {
                        id: customImgButton
                        width: 138
                        text: "Select image"
                        anchors.verticalCenter: btnBckg.verticalCenter
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                        onClicked: {
                            fileDialog.open()
                        }
                    }
                }

            }
        }

        Rectangle {
            id: imgBackground
            color: Colors.primary200
            radius: 4
            anchors.left: parent.left
            anchors.right: buttonBackground.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 10
            Item{
                id: imageContainer
                width: parent.width
                anchors.top:parent.top
                anchors.topMargin:5
                anchors.bottomMargin: 5
                anchors.left:parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 5
                anchors.rightMargin: 5

                Flickable {
                    width: parent.width
                    height: parent.height
                    contentWidth: parent.width
                    contentHeight: model.count * parent.height // Adjust height based on number of images

                    Repeater {
                        id: imageReapeter
                        model: imageModel

                        Image {
                            source: modelData
                            anchors.horizontalCenter: parent.horizontalCenter
                            fillMode: Image.PreserveAspectFit
                            width: parent.width
                            height: parent.height / 3
                            opacity: 1
                            y: index * (parent.height / 3)
                        }
                    }
                }
            }
        }
    }
    ListModel{
        id: imageModel
    }

    FileDialog{
        id: fileDialog
        nameFilters: ["Images (*.png *.jpg *.jpeg)"]
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        fileMode: FileDialog.OpenFiles
        onAccepted:{
            for(var i =0;i<fileDialog.selectedFiles.length;i++){
                imageModel.append({"source": fileDialog.selectedFiles[i]})

            }
            if(backend){
                backend.processImages(fileDialog.selectedFiles)

            }else{
                console.log("backend nie jest zdefiniopwany")
            }

        }
    }
    FileDialog{
        id: saveFileDialog
        title: "Save PDF"
        fileMode: FileDialog.SaveFile
        nameFilters: ["PDF files (*pdf)"]
        onAccepted: {
            if(backend){
                backend.savePath(saveFileDialog.selectedFile)
                backend.generatePdf()
            }
            else{
                console.log("Backend nie jest zdefiniowany")
            }
        }

    }

}
