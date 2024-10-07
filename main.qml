import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.15
import QtCore
import QtQuick.Dialogs
import QtQuick.Layouts 2.15
Window {
    id: window
    width: 640
    height: 480
    visible: true
    color: "#232730"
    title: qsTr("Antrakt")


    Rectangle {
        id: backgroud
        color: "#232730"
        anchors.fill: parent

        Rectangle {
            id: buttonBackground
            y: 0
            color: "#f0464b55"
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
                color: "#f0565c68"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 320

                Button {
                    id: pdfButton
                    text: qsTr("Generate PDF")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 15
                    anchors.rightMargin: 15
                    anchors.topMargin: 100
                    anchors.bottomMargin: 15
                    font.bold: true
                    onClicked:
                        if(backend){
                            backend.generatePdf()
                        }else{
                            console.log("Backend nie jest zdefiniownay")
                        }
                }

                Button {
                    id: imgButton
                    text: qsTr("Select image")
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 15
                    anchors.rightMargin: 15
                    anchors.topMargin: 20
                    anchors.bottomMargin: 95
                    font.bold: true
                    onClicked: fileDialog.open()

                }
            }
        }

        Rectangle {
            id: imgBackground
            color: "#2f3440"
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
            Repeater{
                id: imageRepeater
                model: imageModel
            Image {
               source: modelData
                anchors.centerIn: parent
                // Offset for each image
                // Offset for each image
                opacity: 0.95
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 0
                anchors.rightMargin: 1
                anchors.topMargin: 0
                anchors.bottomMargin: 1
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

}
