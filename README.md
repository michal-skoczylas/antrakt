Aplikacja ma służyć do łączenia zdjęć w serie a następnie wyciąganie z nich tekstu i na tej podstawie tworzenia pdfów. Docelowo ma również mieć wsparcie dla symboli LaTeX.
## Backend
### Przetwarzanie obrazów
Do przetwarzania obrazów chcemy użyć `Tesseract` i `open-cv`. Dodatkowo do pomocy w manipulowaniu obrazami `pillow` w wersji testowej w pythonie a w docelowej `image crate` w Rust.
W przypadku matematycznych wzorów można użyć jakiegoś math ocr np.:
- https://github.com/lukas-blecher/LaTeX-OCR
- https://github.com/VikParuchuri/texify 
- https://github.com/luopeixiang/im2latex
który wypluje kod tex. Do tego będzie potrzebny `torch`
### Tworzenie pdfów
Do stworzenia pdfów użyjemy `MuPDF` dla rust lub python w zależności od fazy.
Formuły matematyczne będziemy wstawiać przy użyci `PyLatex`

## Frontend
### Aplikacja 
Do stworzenia aplikacji użyjemy **Qt Quick** aby mieć możliwość implementacji na urządzenia mobilne i fancy design.
Użycie `PySide6`

## UI
W UI powinny wyswietlać się wybrane obrazy zestackowane na sobie, obok znajdować się będą przyciski do sterowania aplikacją.

![image](https://github.com/user-attachments/assets/a8bcf4e0-ff10-4135-995f-6297e6c9ab78)
