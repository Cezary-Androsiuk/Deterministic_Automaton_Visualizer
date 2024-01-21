import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material
import QtQuick.Shapes

import "CanvasFunctions.js" as CF // CanvasFunctions

Rectangle {
    anchors{
        fill: parent
    }
    color: "transparent"

    Rectangle {
        id: automatBackButtonContainer
        anchors{
            left: parent.left
            right: parent.right
            top: parent.top
        }
        color: "transparent"
        height: 80

        function goBack(){
            backend.goBackAction()
            mainLoader.source = "SetWordPage.qml"
        }

        Button{
            id: automatBackButton
            anchors{
                left: parent.left
                top: parent.top
                leftMargin: 20
                topMargin: 10
            }
            text: "Powrót"
            font.pixelSize: 25

            onClicked: parent.goBack()
        }
    }


    Rectangle {
        id: automatContentContainer
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            top: automatBackButtonContainer.bottom
        }
        color: "transparent"
        // color: "red"

        Rectangle {
            id: clipWordGroup
            anchors{
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                // topMargin: 30
            }
            clip: true
            width: parent.width * 4/5
            height: 60
            color: "transparent"
            // color: "darkgray"
            Rectangle {
                id: wordGroup
                anchors.centerIn: parent
                width: (lt.width + mt.width + rt.width) * 2
                height: parent.height

                color: "transparent"
                // color: "gray"

                Text{
                    id: lt
                    text: root.backendWordLeft
                    font.pixelSize: 25
                    anchors{
                        top: mt.top
                        right: mt.left
                    }
                    color: "lightgray"
                }
                Text{
                    id: mt
                    text: root.backendWordMiddle
                    font.bold: true
                    font.pixelSize: 25
                    anchors{
                        centerIn: parent
                    }
                    color: "lightgray"
                }
                Text{
                    id: rt
                    text: root.backendWordRight
                    font.pixelSize: 25
                    anchors{
                        top: mt.top
                        left: mt.right
                    }
                    color: "lightgray"
                }

                Text{
                    id: topMiddleWordPtr
                    anchors{
                        horizontalCenter: mt.horizontalCenter
                        bottom: mt.top
                    }
                    font.pixelSize: 15
                    text: "|"
                    color: "lightgray"
                }

                Text{
                    id: bottomMiddleWordPtr
                    anchors{
                        horizontalCenter: mt.horizontalCenter
                        top: mt.bottom
                    }
                    font.pixelSize: 15
                    text: "|"
                    color: "lightgray"
                }
            }
        }

        Rectangle {
            id: shiftWordButtonsContainer
            anchors{
                top: clipWordGroup.bottom
                horizontalCenter: parent.horizontalCenter
            }
            color: "transparent"
            // color: "red"
            width: parent.width * 4/5
            height: 70

            function leftClicked(){
                backend.decrementIndex();
                canvas.requestPaint();
            }
            function rightClicked(){
                backend.incrementIndex();
                canvas.requestPaint();
            }

            focus: true
            Keys.onEscapePressed: automatBackButtonContainer.goBack()
            Keys.onLeftPressed: leftClicked()
            Keys.onRightPressed: rightClicked()
            // Keys.onSpacePressed: {
            //     console.log(root.endWordType + " " + typeof(root.endWordType));
            //     console.log(root.automatonPos + " " + typeof(root.automatonPos));
            //     console.log( root.automatonPos === 2 ? "text" : "notext" );
            //     console.log(root.width + " " + root.height);
            // }

            Rectangle {
                id: lbContainer
                anchors{
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                color: "transparent"
                // color: "red"
                width: parent.width / 2

                Button{
                    id: lb
                    text: "lewo"
                    font.pixelSize: 25
                    anchors{
                        right: parent.right
                        rightMargin: parent.width * 1/3
                    }

                    onClicked: shiftWordButtonsContainer.leftClicked()
                }
            }

            Rectangle {
                id: rbContainer
                anchors{
                    right: parent.right
                    top: parent.top
                    bottom: parent.bottom
                }
                color: "transparent"
                // color: "red"
                width: parent.width / 2

                Button{
                    id: rb
                    text: "prawo"
                    font.pixelSize: 25
                    anchors {
                        left: parent.left
                        leftMargin: parent.width * 1/3
                    }

                    onClicked: shiftWordButtonsContainer.rightClicked()
                }
            }
        }

        Rectangle {
            id: canvasContainer
            anchors{
                top: shiftWordButtonsContainer.bottom
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height * 0.23
            }

            width: parent.width
            color: "transparent"
            // color: "green"
            // border.color: "white"

            Canvas {
                id: canvas
                anchors.fill: parent
                focus: true
                Keys.onEscapePressed: Qt.exit(0)

                onPaint: {
                    var ctx = canvas.getContext("2d");
                    ctx.clearRect(0, 0, width, height);

                    let _eca = root.colorElementColorActive;
                    let _ecd = root.colorElementColorDeactive;
                    let _fca = root.colorFillColorActive;
                    let _fcd = root.colorFillColorDeactive;

                    let _eecc = root.colorEndElementColorCorrect;
                    let _eecw = root.colorEndElementColorWrong;
                    let _efcc = root.colorEndFillColorCorrect;
                    let _efcw = root.colorEndFillColorWrong;

                    let x=30;
                    let y=-50;

                    function drawCircles(ctx, x = 0 ,y = 0)
                    {
                        let circle_size = 25;

                        function circle_x(id){ return 75 + (120 * id) + x }
                        let circle_y = 200 + y;

                        function text_x(id){ return circle_x(id) - 1 }
                        let text_y = circle_y - 3;

                        let font_size = 10

                        for(let i=0; i<5; i++){
                            let finishPrint = endWordType !== i;
                            let finishElementColor = endWordType === 4 ? _eecc : _eecw;
                            let finishFillColor = endWordType === 4 ? _efcc : _efcw;
                            CF.drawCircle(ctx, circle_x(i), circle_y, circle_size,
                                          root.automatonPos === i ? ( finishPrint ? _eca : finishElementColor) : _ecd,
                                          root.automatonPos === i ? ( finishPrint ? _fca : finishFillColor) : _fcd);
                            CF.drawText(ctx, text_x(i), text_y,  "q" + i, font_size,
                                        root.automatonPos === i ? _eca : _ecd);
                        }
                        // q4 additional ring
                        ctx.beginPath();
                        ctx.arc(circle_x(4), circle_y, circle_size - 4, 0, 2 * Math.PI);
                        ctx.stroke();
                    }
                    drawCircles(ctx, x, y);

                    function drawStrightLines(ctx, x = 0 ,y = 0)
                    {
                        function arr_x(id){ return 110 + (120 * id) + x }
                        let arr_y = 200 + y;

                        function text_x(id){ return 135 + (120 * id) + x }
                        let text_y = arr_y - 15;

                        let font_size = 14

                        // start arrow
                        CF.drawStraightArrow(ctx, 10+x,arr_y, 40+x,arr_y, 180, 10,
                                             root.automatonPos === -1 ? _eca : _ecd);

                        let letters = ["b", "b", "a", "a"];

                        for(let i=0; i<4; i++){
                            let printArrow = root.automatonPos === i && root.nextLetter === letters[i];
                            CF.drawStraightArrow(ctx, arr_x(i),arr_y, arr_x(i) + 50, arr_y, 180, 10,
                                                 printArrow ? _eca : _ecd);
                            CF.drawText(ctx, text_x(i), text_y, letters[i], font_size,
                                        printArrow ? _eca : _ecd);
                        }
                    }
                    drawStrightLines(ctx, x, y);

                    function drawLines(ctx, x = 0, y = 0)
                    {
                        let arr_x = 0 + x;
                        let arr_y = 0 + y;

                        let pos_below = 200+25+10+y
                        let pos_above = 200-25-10+y

                        let font_size = 14
                        function pos_x(id) { return 75+(120*id)+x }
                        let printArrow;

                        // q4 -a-> q0
                        printArrow = root.automatonPos === 4 && root.nextLetter === "a"
                        CF.drawArrow(ctx,
                                     pos_x(4), pos_below,
                                     pos_x(3.5), pos_below+100,
                                     pos_x(0.5)+10, pos_below+100-2,
                                     pos_x(0)+10, pos_below-2,
                                     53, 10,
                                     printArrow ? _eca : _ecd);
                        CF.drawText(ctx, pos_x(2), pos_below+90, "a", font_size,
                                    printArrow ? _eca : _ecd);

                        // q4 -b-> q1
                        printArrow = root.automatonPos === 4 && root.nextLetter === "b"
                        CF.drawArrow(ctx,
                                     pos_x(4), pos_above,
                                     pos_x(3.5), pos_above-100,
                                     pos_x(1.5)+10, pos_above-100+2,
                                     pos_x(1)+10, pos_above+2,
                                     300, 10,
                                     printArrow ? _eca : _ecd);
                        CF.drawText(ctx, pos_x(2.5), pos_above-90, "b", font_size,
                                    printArrow ? _eca : _ecd);

                        // q3 -b-> q1
                        printArrow = root.automatonPos === 3 && root.nextLetter === "b"
                        CF.drawArrow(ctx,
                                     pos_x(3), pos_below,
                                     pos_x(2.5), pos_below+50,
                                     pos_x(1.5)+10, pos_below+50-2,
                                     pos_x(1)+10, pos_below-2,
                                     41, 10,
                                     printArrow ? _eca : _ecd);
                        CF.drawText(ctx, pos_x(2)+1, pos_below+25, "b", font_size,
                                    printArrow ? _eca : _ecd);

                        // q1 -a-> q0
                        printArrow = root.automatonPos === 1 && root.nextLetter === "a"
                        CF.drawArrow(ctx,
                                     pos_x(1)-10, pos_below-5,
                                     pos_x(0.75)-10, pos_below+20-5,
                                     pos_x(0.25)+25, pos_below+20-8,
                                     pos_x(0)+25, pos_below-8,
                                     36, 10,
                                     printArrow ? _eca : _ecd);
                        CF.drawText(ctx, pos_x(0.5), pos_below-3, "a", font_size,
                                    printArrow ? _eca : _ecd);

                        // q2 -b-> q2
                        printArrow = root.automatonPos === 2 && root.nextLetter === "b"
                        CF.drawArrow(ctx,
                                     pos_x(2.16), pos_above+8,
                                     pos_x(2.3), pos_above-35,
                                     pos_x(1.70), pos_above-35,
                                     pos_x(1.84), pos_above+5,
                                     254, 10,
                                     printArrow ? _eca : _ecd);
                        CF.drawText(ctx, pos_x(2), pos_above-36, "b", font_size,
                                    printArrow ? _eca : _ecd);

                        // q0 -a-> q0
                        printArrow = root.automatonPos === 0 && root.nextLetter === "a"
                        CF.drawArrow(ctx,
                                     pos_x(0.16), pos_above+8,
                                     pos_x(0.3), pos_above-35,
                                     pos_x(-.3), pos_above-35,
                                     pos_x(-.16), pos_above+5,
                                     254, 10,
                                     printArrow ? _eca : _ecd);
                        CF.drawText(ctx, pos_x(0), pos_above-36, "a", font_size,
                                    printArrow ? _eca : _ecd);

                    }
                    drawLines(ctx, x, y)


                }

            }
        }

        Rectangle {
            id: endInfoTextContainer

            color: "transparent"
            // color: "red"
            anchors{
                top: canvasContainer.bottom
                left: canvasContainer.left
                right: canvasContainer.right
            }
            height: 50
            Text {
                id: endInfoText
                anchors{
                    centerIn: parent
                }
                font.pixelSize: 25

                color: {
                    if(root.endWordType === -1)
                        root.colorElementColorActive;
                    else if(root.endWordType === 4)
                        root.colorEndElementColorCorrect;
                    else
                        root.colorEndElementColorWrong;
                }

                text: {
                    if(root.endWordType === -1)
                        "";
                    else if(root.endWordType === 4)
                        "Słowo zaakceptowane";
                    else
                        "Słowo odrzucone";
                }
            }
        }
    }

}
