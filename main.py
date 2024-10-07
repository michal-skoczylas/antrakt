# This Python file uses the following encoding: utf-8
import sys
import cv2
import pytesseract
from reportlab.pdfgen import canvas
from pylatex import Document, Section, Math
from pathlib import Path
from PySide6.QtCore import QObject, Slot, QUrl
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtWidgets import QFileDialog

class Backend(QObject):
    def __init__(self):
        super().__init__()
        self.ocr_results=""
        self.save_path=""

    @Slot(list)
    def processImages(self, file_urls):
        for file_url in file_urls:
            image_path = QUrl(file_url).toLocalFile()
            print(f"Processing image: {image_path}")
            image = cv2.imread(image_path)
            image_gray=cv2.cvtColor(image,cv2.COLOR_BGR2GRAY)
            if image is None:
                print(f"Could not open {image_path}")
                continue
            ocr_result = pytesseract.image_to_string(image_gray)
            print("Wyswietlam")
            print(ocr_result)
            self.ocr_results += ocr_result + "\n"
        print(self.ocr_results) # Połączenie skanów wszystkkich zdjęć w jednego stringa

    @Slot()
    def generatePdf(self):
        # file_dialog=QFileDialog()
        # save_path, _=file_dialog.getSaveFileName(
        # None,
        # "Save PDF",
        # "",
        # "PDF Files(*.pdf)"
        # )
        # if save_path:
        #     #Dodaj .pdf jesli uzytkownik tego nie podal
        #     if not save_path.endswith(".pdf"):
        #         save_path+=".pdf"


        doc=Document()
        section=Section("Output")
        section.append(self.ocr_results) # tu zmienic na latexowa forme
        doc.append(section)

        doc.generate_pdf(self.save_path,clean_tex=False,compiler='pdflatex')
        print(f"Pdf wygenerowany w {self.save_path}")
    @Slot(str)
    def savePath(self,path):
        self.save_path=QUrl(path).toLocalFile()
        print(f"Save path set to: {self.save_path}")
        
    

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    qml_file = Path(__file__).resolve().parent / "main.qml"
    engine.load(qml_file)
    backend=Backend()
    engine.rootContext().setContextProperty("backend",backend) #Dzieki temu qml widzi obiekt backend i moze sie do niego odwolywac i uzywa  jego funkcji
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())
