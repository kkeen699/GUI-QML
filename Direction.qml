import QtQuick 2.0
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.0

Item {
    id: element
    property int img_size: 48
    property string direction_button: ""

    ColumnLayout {
        id: columnLayout
        x: -18
        y: -127
        width: img_size
        height: img_size
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        Image {
            id: image3
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            sourceSize.width: img_size
            sourceSize.height: img_size
            source: "qrc:/img/up.svg"
            opacity: 0.5
        }

        RowLayout {
            id: rowLayout
            spacing: 10

            Image {
                id: image
                sourceSize.width: img_size
                sourceSize.height: img_size
                source: "qrc:/img/left.svg"
                opacity: 0.5
            }

            Image {
                id: image1
                sourceSize.width: img_size
                sourceSize.height: img_size
                source: "qrc:/img/down.svg"
                opacity: 0.5
            }

            Image {
                id: image2
                sourceSize.width: img_size
                sourceSize.height: img_size
                source: "qrc:/img/right.svg"
                opacity: 0.5
            }
        }
    }

    Behavior on opacity {
        NumberAnimation {
            target: [image, image1, image2, image3]
            duration: 500
            easing.type: Easing.InOutQuad
        }
    }

//    onDirection_buttonChanged: {
//        switch(direction_button) {
//        case "UP":
//            image3.opacity = 1.0;
//            image.opacity = 0.5
//            image1.opacity = 0.5;
//            image2.opacity = 0.5;
//            break;
//        case "DOWN":
//            image1.opacity = 1.0;
//            image.opacity = 0.5
//            image2.opacity = 0.5;
//            image3.opacity = 0.5;
//            break;
//        case "RIGHT":
//            image2.opacity = 1.0;
//            image.opacity = 0.5
//            image1.opacity = 0.5;
//            image3.opacity = 0.5;
//            break;
//        case "LEFT":
//            image.opacity = 1.0;
//            image1.opacity = 0.5
//            image2.opacity = 0.5;
//            image3.opacity = 0.5;
//            break;
//        }
//    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
