import QtQuick 2.13
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.13

Rectangle {
    id: ball
    width: 8
    height: 8
    radius: 4
    x: 200 + (Math.floor(Math.random() * 100))
    y: Math.floor(Math.random() * gameField.height)
}
