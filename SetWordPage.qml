import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

Rectangle {
    anchors{
        fill: parent
    }

    color: "transparent"
    // color: "red"

    property string alphabet: "ab"
    property bool wrongAlphabet: false
    property int textAreaStartedWidth: 300

    function confirmForm(){
        if( setWordWordInput.text !== "" && !wrongAlphabet){
            backend.setWord(setWordWordInput.text)
            // mainLoader.visible = false
            mainLoader.source = "AutomatPage.qml"
        }
    }

    Rectangle {
        id: setWordContentContainer

        anchors{
            left: parent.left
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
        height: 250

        color: "transparent"
        // color: "red"

        Rectangle {
            id: setWordLabelContainer
            anchors{
                left: parent.left
                right: parent.right
                top: parent.top
            }
            height: parent.height / 3
            color: "transparent"
            // color: "red"

            Label{
                id: textInfo
                text: "Wprowadź słowo: "
                anchors.centerIn: parent

                font.pixelSize: 25
            }
            Label{
                id: textDesc
                text: "automat akceptuje słowa nad alfabetem '" + alphabet + "', kończące się na 'bbaa'"
                anchors{
                    topMargin: 10
                    top: textInfo.bottom
                    horizontalCenter: textInfo.horizontalCenter
                }

                font.pixelSize: 12
            }
        }
        Rectangle {
            id: setWordTextInputContainer
            anchors{
                left: parent.left
                right: parent.right
                top: setWordLabelContainer.bottom
            }
            width: parent.width * 4/5
            height: parent.height * 1/3
            color: "transparent"
            // color: "red"
            TextField{
                id: setWordWordInput
                focus: true
                anchors.centerIn: parent

                width: textAreaStartedWidth
                implicitHeight: 56
                font.pixelSize: 25

                onTextChanged: {
                    if(width > textAreaStartedWidth || contentWidth + 32 > width)
                        width = contentWidth + 32
                    if(width >= setWordTextInputContainer.width * 4/5)
                        width = setWordTextInputContainer.width * 4/5

                    wrongAlphabet = false
                    for(var i=0; i<text.length; i++){
                        if(!alphabet.includes(text[i])){
                            wrongAlphabet = true
                            break
                        }
                    }
                }
                Keys.onReturnPressed: confirmForm()
                Keys.onEscapePressed: Qt.exit(0)
            }

            Label{
                id: textWarning
                text: "słowo nie należy do alfabetu"
                visible: wrongAlphabet
                color: "red"
                anchors{
                    topMargin: 10
                    top: setWordWordInput.bottom
                    horizontalCenter: setWordWordInput.horizontalCenter
                }

                font.pixelSize: 12
            }
        }
        Rectangle {
            id: setWordButtonContainer
            anchors{
                left: parent.left
                right: parent.right
                top: setWordTextInputContainer.bottom
            }
            height: parent.height / 3
            color: "transparent"
            // color: "red"

            Button{
                id: setWordConfirmWordInput
                text: "Potwierdź słowo"
                anchors.centerIn: parent
                font.pixelSize: 25
                onClicked: confirmForm()
            }
        }

    }
}
