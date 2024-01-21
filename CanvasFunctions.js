// let programmers do his things
let _debugDots = true;
// let _elementsColor = Qt.rgba(0.9, 0.9, 0.9, 1);
// let _elementsFillColor = Qt.rgba(0.9, 0.9, 0.9, 0.2);
// let _textColor = Qt.rgba(1, 1, 1, 1);


function drawDot(ctx, x, y, radius)
{
    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 2 * Math.PI);
    ctx.fill();
    ctx.stroke();
}

/////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// ARROW /////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////
function drawBezier(ctx, start_x, start_y, cp1_x, cp1_y, cp2_x, cp2_y, end_x, end_y)
{
    ctx.beginPath();
    ctx.moveTo(start_x, start_y);
    ctx.bezierCurveTo(cp1_x, cp1_y, cp2_x, cp2_y, end_x, end_y);
    ctx.stroke();
}

function drawArrowHead(ctx, front_x, front_y, angle, size = 10)
{
    function vectorFromAngle(angle){
        let radians = (angle + root.degree) * (Math.PI / 180);


        let x = Math.cos(radians);
        let y = Math.sin(radians);

        let vectorLength = Math.sqrt(x * x + y * y);
        let unitVector = {
            x: x / vectorLength,
            y: y / vectorLength
        };

        return unitVector
    }

    // drawDot(ctx, front_x, front_y, 5);

    // let mvec = vectorFromAngle(angle);
    let lvec = vectorFromAngle(angle + 20);
    let rvec = vectorFromAngle(angle - 20);

    let moveArrowToFront = vectorFromAngle(angle + 180)
    let moveFWDOffset = 4



    ctx.beginPath();

    // middle
    // ctx.moveTo(front_x + moveArrowToFront.x * moveFWDOffset, front_y + moveArrowToFront.y * moveOffset);
    // ctx.lineTo(front_x + mvec.x * size, front_y + mvec.y);

    // left top
    ctx.moveTo(front_x + moveArrowToFront.x * moveFWDOffset, front_y + moveArrowToFront.y * moveFWDOffset);
    ctx.lineTo(front_x + lvec.x * size, front_y + lvec.y * size);

    // right top
    ctx.moveTo(front_x + moveArrowToFront.x * moveFWDOffset, front_y + moveArrowToFront.y * moveFWDOffset);
    ctx.lineTo(front_x + rvec.x * size, front_y + rvec.y * size);

    ctx.stroke();
}

function drawArrow(ctx, start_x, start_y, cp1_x, cp1_y, cp2_x, cp2_y, end_x, end_y, head_angle, head_size, color)
{
    ctx.strokeStyle = color;

    ctx.lineWidth = 2;
    drawBezier(ctx, start_x, start_y, cp1_x, cp1_y, cp2_x, cp2_y, end_x, end_y);
    if(_debugDots){
        drawDot(ctx, cp1_x, cp1_y);
        drawDot(ctx, cp2_x, cp2_y);
    }

    drawArrowHead(ctx, end_x, end_y, head_angle, head_size);

}

function drawStraightArrow(ctx, start_x, start_y, end_x, end_y, head_angle, head_size, color)
{
    drawArrow(ctx,
             start_x, start_y, start_x, start_y, start_x, start_y,
             end_x, end_y,
             head_angle, head_size, color)
}




//////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// CIRCLE /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
function drawText(ctx, x, y, text, text_size, color)
{
    ctx.fillStyle = color;

    ctx.font = "bold " + text_size + "px sans-serif";
    ctx.fillText(text, x-6, y+6);
}

function drawCircle(ctx, x, y, radius, color, fillColor)
{
    ctx.strokeStyle = color;
    ctx.fillStyle = fillColor;

    ctx.beginPath();
    ctx.arc(x, y, radius, 0, 2 * Math.PI);
    ctx.fill();
    ctx.stroke();

}


//////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////// ADDITIONAL /////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////



































