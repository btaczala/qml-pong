import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 600

    readonly property int handleHeight: 80
    readonly property int handleWidth: 5
    readonly property int timerInterval: 20
    readonly property int pixelPerMove: 3

    readonly property bool useCpu: false

    Background {
        id: game
        anchors.fill: parent
        focus: true
        Keys.onPressed: {
            if (event.key == Qt.Key_Down) {
                game.playerDown(event)
            }
            if (event.key == Qt.Key_K && !useCpu) {
                game.secondPlayerDown(event)
            }
            if (event.key == Qt.Key_J && !useCpu) {
                game.secondPlayerUp(event)
            }

            if (event.key == Qt.Key_Up) {
                game.playerUp(event)
            }

            if (event.key === Qt.Key_Space) {
                if (game.state === "starting") {
                    game.state = "running"
                } else if (game.state === "running") {
                    game.togglePause()
                }
            }
        }
    }
}
