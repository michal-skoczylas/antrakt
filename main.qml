import QtQuick
import QtQuick.Window
import QtQuick.Controls 2.15
import QtCore
import QtQuick.Dialogs
import QtQuick.Layouts 2.15
ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: qsTr("Antrakt")

    Button {
        id: imgButton
        x: 44
        y: 73
        text: qsTr("Select image")
        onClicked: fileDialog.open()

    }

    Image {
        id: image
        x: 38
        y: 166
        width: 298
        height: 261

        fillMode: Image.PreserveAspectFit
    }

    FileDialog{
        id: fileDialog
        nameFilters: ["Images (*.png *.jpg *.jpeg)"]
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)[0]
        fileMode: FileDialog.OpenFiles
        onAccepted:{
            if(backend){
            backend.processImages(fileDialog.selectedFiles)
            
            }else{
                console.log("backend nie jest zdefiniopwany")
            }

        }
    }

        Button {
            id: pdfButton
            x: 298
            y: 73
            text: qsTr("Wygeneruj PDF")
            onClicked: 
            if(backend){
backend.generatePdf()
            }else{
                console.log("Backend nie jest zdefiniownay")
            }
        }
}
