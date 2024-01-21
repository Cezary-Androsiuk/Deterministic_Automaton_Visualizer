import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow {
    id: root
    // width: 720
    // width: 1920
    minimumWidth: 650
    maximumWidth: 650

    // height: 720
    // height: 1080
    minimumHeight: 640
    maximumHeight: 640

    visible: true
    title: qsTr("etaijf - wizualizacja automatu deterministycznego")

    Material.theme: Material.Dark
    Material.accent: Material.Purple
    property string backendWordLeft: backend.word_left
    property string backendWordMiddle: backend.word_middle
    property string backendWordRight: backend.word_right
    property int automatonPos: backend.automaton_pos
    property int endWordType: backend.end_word_pos
    property string nextLetter: backend.next_letter

    function rgb(r, g, b, a=255){
        return Qt.rgba(r/255, g/255, b/255, a/255);
    }


    property color colorElementColorActive:         rgb(230, 230, 230);
    property color colorElementColorDeactive:       rgb( 53,  53,  53);
    property color colorFillColorActive:            rgb(110, 110, 110);
    property color colorFillColorDeactive:          rgb( 38,  38,  38);

    property color colorEndElementColorCorrect:     rgb( 55, 235,  55);
    property color colorEndElementColorWrong:       rgb(235,  55,  55);
    property color colorEndFillColorCorrect:        rgb( 50, 120,  50);
    property color colorEndFillColorWrong:          rgb(120,  50,  50);

    property int degree: 0


    Loader{
        id: mainLoader
        focus: true
        anchors{
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: footer.top
        }

        source: "SetWordPage.qml"
        // source: "AutomatPage.qml"
        Keys.onUpPressed: {
            degree+=10
        }
        Keys.onDownPressed: {
            degree-=10
        }
    }

    Rectangle {
        id:footer
        anchors{
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 30
        color: "transparent"
        // color: "green"
        // border.color: "white"

        Text {
            id: footerText
            anchors.centerIn: parent
            text: qsTr("Cezary Androsiuk (2024) etaijf")
            color: "lightgray"
        }
    }
}
