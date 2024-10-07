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

class Backend(QObject):
    def __init__(self):
        super().__init__()
        self.ocr_results=""

    @Slot(list)
    def processImages(self, file_urls):
        for file_url in file_urls:
            image_path = QUrl(file_url).toLocalFile()
            print(f"Processing image: {image_path}")
            image = cv2.imread(image_path)
            if image is None:
                print(f"Could not open {image_path}")
                print("failxd")
            continue
            ocr_result = pytesseract.image_to_string(image)
            print("Wyswiet;a,m")
            print(ocr_result)
            self.ocr_results += ocr_result + "\n"
        print(self.ocr_results) # Połączenie skanów wszystkkich zdjęć w jednego stringa

    @Slot()
    def generatePdf(self):
        doc=Document()
        section=Section("Outpu")
        section.append(self.ocr_results) # tu zmienic na latexowa forme
        doc.append(section)

        doc.generate_pdf("output",clean_tex=False,compiler='pdflatex')
        print("Pdf wygenerowany")


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
