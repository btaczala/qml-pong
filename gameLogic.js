
function checkLeftCollision(ball, handle) {
    if ( ball.y > handle.y && (ball.y < handle.y + handle.height) && (ball.x <= handle.x + handle.width)) {
        return true
    }
    return false
}

function checkRightCollision(ball, handle) {
    console.log(handle.x, ball.x)
    if ( handle.x === ball.x) {
    console.log("yyy", ball.y, handle.y, handle.y + handle.height)
    }
    if ( ball.y > handle.y && (ball.y < handle.y + handle.height) && (handle.x === ball.x)) {
        return true
    }
    return false
}

function computerMove(ball, handle) {
    handle.y = ball.y - 10
}
