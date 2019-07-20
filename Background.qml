import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

import "gameLogic.js" as Game

Rectangle {
    id: game
    width: 500
    height: 400
    color: "black"

    property int horizontalDirection: -1
    property int verticalDirection: 1

    state: "starting"

    onStateChanged: {
        console.log("State =", game.state)
        if (state === "starting") {
            ball.x = 200 + (Math.floor(Math.random() * 100))
            ball.y = Math.floor(Math.random() * gameField.height)
            //ball.x = game.width - 20
            //ball.y = game.height - 40
        }
    }

    function playerDown(event) {
        if (leftHandle.y < (gameField.height - leftHandle.height)) {
            leftHandle.y = leftHandle.y + 5
            event.accepted = true
        }
    }

    function secondPlayerDown(event) {
        if (rightHandle.y < (gameField.height - leftHandle.height)) {
            rightHandle.y = rightHandle.y + 5
            event.accepted = true
        }
    }

    function playerUp(event) {
        if (leftHandle.y > 0) {
            leftHandle.y = leftHandle.y - 5
            event.accepted = true
        }
    }

    function secondPlayerUp(event) {
        if (rightHandle.y > 0) {
            rightHandle.y = rightHandle.y - 5
            event.accepted = true
        }
    }

    function togglePause() {
        gameTimer.running = !gameTimer.running
    }

    ColumnLayout {
        anchors.fill: parent
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 80

            Text {
                visible: game.state === "starting"
                text: "Press space to start"
                color: "black"
                anchors.centerIn: parent
            }
        }

        Item {
            id: gameField
            Layout.fillWidth: true
            Layout.fillHeight: true

            Rectangle {
                id: leftHandle
                width: handleWidth
                y: 0
                height: handleHeight
                anchors.left: parent.left
            }

            Rectangle {
                id: rightHandle
                width: handleWidth
                height: handleHeight
                anchors.right: parent.right
            }

            Ball {
                id: ball
            }

            Item {
                width: parent.width / 2
                height: parent.height / 2
                anchors.centerIn: parent
                visible: game.state === "point" || game.state === "waiting"
                Text {
                    anchors.centerIn: parent
                    color: "white"
                    text: "Computer scores"
                }
            }
        }
    }

    Timer {
        id: gameTimer
        interval: timerInterval
        repeat: true
        onTriggered: {

            //console.log("game tick ", ball.x, ball.y)
            ball.x = ball.x + (verticalDirection * pixelPerMove)
            ball.y = ball.y + (horizontalDirection * pixelPerMove)
            if (Game.checkLeftCollision(ball, leftHandle)) {
                console.log("left swipe")
                verticalDirection = 1
            } else if (Game.checkRightCollision(ball, rightHandle)) {
                console.log("right swipe")
                verticalDirection = -1
            } else if (ball.x > game.width) {
                state = "point"
                state = "waiting"
            } else if (ball.x < 0) {
                state = "point"
                state = "waiting"
            }

            if (ball.y > gameField.height - ball.height)
                horizontalDirection = -1
            else if (ball.y < ball.height)
                horizontalDirection = 1
            if (useCpu)
                Game.computerMove(ball, rightHandle)
        }
    }

    Timer {
        id: waitTimer
        interval: 3000
        running: false
        repeat: false
        onTriggered: {
            console.log("asd")
            game.state = "starting"
        }
    }

    states: [
        State {
            name: "starting"
        },
        State {
            name: "running"
            PropertyChanges {
                target: gameTimer
                running: true
            }
        },
        State {
            name: "point"
            PropertyChanges {
                target: gameTimer
                running: false
            }
        },
        State {
            name: "waiting"
            PropertyChanges {
                target: waitTimer
                running: true
            }
        }
    ]
}
