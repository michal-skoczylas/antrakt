import QtQuick 2.15
import QtQuick.Controls 2.15
import "colors.js" as Colors

Button {
    id: cstmButton
    implicitWidth: 130
    implicitHeight: 35
    text: qsTr("Select image")
    font.pixelSize: 20

    background: Rectangle {
        id: bgBtn
        color: Colors.primary600  // Użycie koloru primary600
        radius: 12
        anchors.fill: parent

        // Cień pod przyciskiem
        Rectangle {
            anchors.fill: parent
            z: -1
            radius: 12
            opacity: 0.2
            color: Colors.neutral100  // Użycie koloru neutral100
            anchors.topMargin: 5
            anchors.leftMargin: 5
            id: shadowRect
        }

        // Animacja zmiany kolorów
        Behavior on color {
            ColorAnimation {
                duration: 150
            }
        }

        // MouseArea do obsługi najechania i kliknięcia
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true

            // Zmiana koloru po kliknięciu
            onPressed: {
                bgBtn.color = Colors.accent500;  // Użycie koloru z palety accent
            }
            onReleased: {
                bgBtn.color = mouseArea.containsMouse ? Colors.accent400 : Colors.primary600;  // Użycie kolorów z palety
            }

            // Zmiana koloru po najechaniu
            onEntered: {
                bgBtn.color = Colors.accent400;  // Użycie koloru z palety accent
            }
            onExited: {
                bgBtn.color = Colors.primary600;  // Powrót do koloru primary600
            }
        }
    }
}
