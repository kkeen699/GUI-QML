import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

import disinfectionmanager 1.0

//import Qt.labs.animation 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 1280
    height: 720
    color: "#2e2f30"
    title: qsTr("Disinfection Robot")
    property bool compressor_state: false
    property bool valve_state: false
    property bool servo_state: false
    property bool rodup_state: false
    property bool roddown_state: false
    property int rod_high: 0

    DisinfectionManager{
        id: disinfecion
        m_ip: "140.112.14.209"
        m_port: 8080
        Component.onCompleted: {
            disinfecion.initialize()
            disinfecion.connect()
        }
    }

    Item {
        id: slam_wrapper
        width: 616
        height: 246
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.top: parent.top
        anchors.topMargin: 25

        Rectangle {
            id: rectangle_slam
            color: "#00000000"
            radius: 3
            anchors.fill: parent
            border.color: "#ffffff"
            border.width: 3

            Text {  //整個大rectangle的標題內容
                id: slam
                x: 10
                y: 10
                color: "#ffffff"
                text: qsTr("SLAM")
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                font.bold: true
                font.pixelSize: 24
                font.family: "Open Sans"
            }

            Column {
                id: column
                x: 146
                y: 52
                width: 324
                height: 194

                Button {
                    id: buttone
                    anchors.horizontalCenter: parent.horizontalCenter
//                    Image {
//                        id: image0
//                        source: "img/up.svg"
//                        anchors.horizontalCenter: parent.horizontalCenter
//                        anchors.verticalCenter: parent.verticalCenter
//                        sourceSize.width: 40
//                        sourceSize.height: 40
//                    }
                }

                RowLayout {
                    id: rowLayout
                    anchors.fill: parent

                    Button {
                        id: button1
                        text: qsTr("Button")
                    }

                    Button {
                        id: button2
                        text: qsTr("Button")
                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    }

                    Button {
                        id: button3
                        text: qsTr("Button")
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    }
                }
            }
        }
    } // SLAM

    Item {
        id: sensor_test
        width: 1234
        height: 402
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.top: parent.top
        anchors.topMargin: 293

        Rectangle {
            id: rectangle_sensor
            color: "#00000000"
            radius: 3
            anchors.fill: parent
            border.width: 3
            border.color: "#ffffff"
            Text {
                id: sensor
                height: 31
                color: "#ffffff"
                text: qsTr("Sensor")
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 10
                scale: 1
                font.family: "Open Sans"
                font.bold: true
                font.pixelSize: 24
            }

            Item {
                id: temp_humid_sensor
                x: 18
                y: 37
                width: 365
                height: 344

                Rectangle {
                    id: temp_box_cels
                    x: 8
                    y: 49
                    width: 350
                    height: 59
                    color: "#E5EEC1"
                    radius: 4
                    border.color: "#00000000"
                    border.width: 5

                    Text {
                        id: temp_data_cels
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("Temperature (Celsius) : " + disinfecion.m_sensor[10])
                        verticalAlignment: Text.AlignTop
                        horizontalAlignment: Text.AlignLeft
                        font.bold: true
                        font.family: "Open Sans"
                        styleColor: "#fbfbfb"
                        font.pixelSize: 20
                    }
                }

                Rectangle {
                    id: temp_box_fahr
                    x: 12
                    y: 89
                    width: 350
                    height: 59
                    color: "#E5EEC1"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 148
                    anchors.left: parent.left
                    border.color: "#00000000"
                    border.width: 5
                    Text {
                        id: temp_data_fahr
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("Temperature (Fahrenheit) : " + disinfecion.m_sensor[11])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    anchors.leftMargin: 8
                }

                Rectangle {
                    id: humidity_box
                    x: 10
                    y: 179
                    width: 350
                    height: 59
                    color: "#E5EEC1"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 250
                    anchors.left: parent.left
                    anchors.leftMargin: 8
                    border.color: "#00000000"
                    border.width: 5
                    Text {
                        id: humidity_data
                        color: "#000000"
                        text: qsTr("Relative Humidity : " + disinfecion.m_sensor[12])
                        anchors.left: parent.left
                        anchors.leftMargin: 15
                        anchors.top: parent.top
                        anchors.topMargin: 18
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                }
            }

            Item {
                id: pm_sensor
                x: 389
                y: 27
                width: 471
                height: 363

                Rectangle {
                    id: typical_particle_box
                    x: 17
                    y: 275
                    width: 435
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 286
                    anchors.left: parent.left
                    Text {
                        id: typical_particle_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("typical partical size: " + disinfecion.m_sensor[9])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    anchors.leftMargin: 19
                    border.width: 5
                }

                Rectangle {
                    id: nc10_box
                    x: 306
                    y: 189
                    width: 125
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 204
                    anchors.left: parent.left
                    Text {
                        id: nc10_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("nc10.0: " + disinfecion.m_sensor[8])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    anchors.leftMargin: 329
                    border.width: 5
                }

                Rectangle {
                    id: nc4_box
                    x: 306
                    y: 104
                    width: 125
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 122
                    anchors.left: parent.left
                    Text {
                        id: nc4_5_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("nc4.0: " + disinfecion.m_sensor[7])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    border.width: 5
                    anchors.leftMargin: 329
                }

                Rectangle {
                    id: nc2_5_box
                    x: 306
                    y: 21
                    width: 125
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 44
                    anchors.left: parent.left
                    Text {
                        id: nc2_5_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("nc2.5 : " + disinfecion.m_sensor[6])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    border.width: 5
                    anchors.leftMargin: 329
                }

                Rectangle {
                    id: nc1_box
                    x: 163
                    y: 189
                    width: 125
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 122
                    anchors.left: parent.left
                    Text {
                        id: nc1_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("nc1.0 : " + disinfecion.m_sensor[5])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    anchors.leftMargin: 173
                    border.width: 5
                }

                Rectangle {
                    id: nc0_5_box
                    x: 163
                    y: 104
                    width: 125
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 204
                    anchors.left: parent.left
                    Text {
                        id: nc0_5_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("nc0.5 : " + disinfecion.m_sensor[4])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    border.width: 5
                    anchors.leftMargin: 173
                }

                Rectangle {
                    id: pm10_box
                    x: 163
                    y: 21
                    width: 125
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 44
                    anchors.left: parent.left
                    Text {
                        id: pm10_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("pm10.0 : " + disinfecion.m_sensor[3])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    border.width: 5
                    anchors.leftMargin: 173
                }

                Rectangle {
                    id: pm4_box
                    x: 17
                    y: 189
                    width: 125
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 204
                    anchors.left: parent.left
                    Text {
                        id: pm4_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("pm4.0 : " + disinfecion.m_sensor[2])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    border.width: 5
                    anchors.leftMargin: 19
                }

                Rectangle {
                    id: pm2_5_box
                    x: 23
                    y: 12
                    width: 125
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 44
                    anchors.left: parent.left
                    Text {
                        id: pm2_5_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("pm2.5 : " + disinfecion.m_sensor[1])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    anchors.leftMargin: 19
                    border.width: 5
                }

                Rectangle {
                    id: pm1_box
                    x: 22
                    y: 95
                    width: 125
                    height: 59
                    color: "#A2D5AC"
                    radius: 4
                    anchors.top: parent.top
                    anchors.topMargin: 122
                    anchors.left: parent.left
                    Text {
                        id: pm1_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("pm1.0 : " + disinfecion.m_sensor[0])
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    border.width: 5
                    anchors.leftMargin: 19
                }









            }

            Item {
                id: clo2_sensor
                x: 859
                y: 78
                width: 358
                height: 180
                anchors.right: parent.right
                anchors.rightMargin: 17

                Text {
                    id: clo2_state_normal
                    x: 47
                    y: 4
                    height: 34
                    color: "#ffffff"
                    text: qsTr("Normal concentration")
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignLeft
                    font.family: "Open Sans"
                }

                StatusIndicator {
                    id: clo2_normal_Indictator
                    x: 17
                    y: 9
                    active: true
                    color: "Green"

                }

                Text {
                    id: clo2_state_excess
                    x: 47
                    y: 51
                    height: 34
                    color: "#ffffff"
                    text: qsTr("Excessive consentration")
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignLeft
                    font.family: "Open Sans"
                }

                StatusIndicator {
                    id: clo2_excess_Indictator
                    x: 17
                    y: 56
                    active: true
                    color: "Red"
                }

                Rectangle {
                    id: temp_box_cels11
                    y: 99
                    width: 320
                    height: 59
                    color: "#3AADA8"
                    radius: 4
                    anchors.left: parent.left
                    anchors.leftMargin: 19
                    Text {
                        id: temp_data_cels11
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("ClO2 Consentration : ")
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    border.width: 5
                }




            }

            Item {
                id: water_level_sensor
                x: 859
                y: 202
                width: 358
                height: 191
                anchors.right: parent.right
                anchors.rightMargin: 17
                Text {
                    id: clo2_low_amount
                    x: 47
                    y: 48
                    height: 34
                    color: "#ffffff"
                    text: qsTr("low  amount")
                    font.bold: true
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 18
                    horizontalAlignment: Text.AlignLeft
                    font.family: "Open Sans"
                }

                StatusIndicator {
                    id: clo2_amount_Indicator
                    x: 17
                    y: 53
                    active: true
                    color: "Red"
                }

                Rectangle {
                    id: water_level_box
                    y: 88
                    width: 320
                    height: 59
                    color: "#3AADA8"
                    radius: 4
                    anchors.left: parent.left
                    anchors.leftMargin: 19
                    Text {
                        id: water_level_data
                        x: 15
                        y: 18
                        color: "#000000"
                        text: qsTr("Water Level : ")
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        styleColor: "#fbfbfb"
                        font.pixelSize: 18
                        horizontalAlignment: Text.AlignLeft
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                    border.width: 5
                }
            }

        }

    } // Sensor

    Item {
        id: spray_system
        width: 586
        height: 246
        anchors.left: parent.left
        anchors.leftMargin: 673
        anchors.top: parent.top
        anchors.topMargin: 25

        Rectangle {
            id: rectangle_spray
            x: 146
            y: 13
            width: 200
            height: 200
            color: "#00000000"
            radius: 3
            anchors.fill: parent
            border.width: 3
            border.color: "#ffffff"

            Text {
                id: spray
                x: 10
                y: 10
                color: "#ffffff"
                text: qsTr("Spray System")
                font.bold: true
                anchors.top: parent.top
                anchors.topMargin: 10
                anchors.left: parent.left
                font.pixelSize: 24
                anchors.leftMargin: 10
                font.family: "Open Sans"
            }

            Item {
                id: item_spray
                width: 566
                height: 200
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.top: parent.top
                anchors.topMargin: 40

                StatusIndicator {
                    id: compressor_check
                    x: 43
                    color: "green"
                    anchors.top: parent.top
                    anchors.topMargin: 26
                    active: false
                }

                Button {
                    id: compressor_bt
                    x: 97
                    y: 8
                    width: 125
                    height: 60
                    text: qsTr("Compressor")
//                    contentItem: Text {
//                        text: "aaa"
//                        font: "Open Sans"
//                        opacity: enabled ? 1.0 : 0.3
//                        color: control.down ? "#17a81a" : "#21be2b"
//                        horizontalAlignment: Text.AlignHCenter
//                        verticalAlignment: Text.AlignVCenter
//                        elide: Text.ElideRight
//                    }
                    enabled: true
                    font.pixelSize: 18
                    font.bold: true
                    font.family: "Open Sans"
                    highlighted: true
                    Material.accent: "#547B81"
                    onClicked: {
                        if(compressor_state){
                            compressor_state = false;
                            compressor_check.active = false;
                            disinfecion.m_request = "compr0"
                        }
                        else{
                            compressor_state = true;
                            compressor_check.active = true;
                            disinfecion.m_request = "compr1"
                        }
                    }
                }

                StatusIndicator {
                    id: valve_check
                    x: 43
                    color: "green"
                    anchors.topMargin: 88
                    anchors.top: parent.top
                    active: false
                }

                Button {
                    id: valve_bt
                    x: 97
                    y: 74
                    width: 125
                    height: 60
                    text: qsTr("Valve")
                    font.pixelSize: 18
                    font.bold: true
                    font.family: "Open Sans"
                    highlighted: true
                    Material.accent: "#547B81"
                    onClicked: {
                        if(valve_state){
                            valve_state = false;
                            valve_check.active = false;
                            disinfecion.m_request = "valve0"
                        }
                        else{
                            valve_state = true;
                            valve_check.active = true;
                            disinfecion.m_request = "valve1"
                        }
                    }
                }

                StatusIndicator {
                    id: servo_check
                    x: 43
                    color: "green"
                    anchors.topMargin: 150
                    anchors.top: parent.top
                    active: false
                }

                Button {
                    id: servo_bt
                    x: 97
                    y: 132
                    width: 125
                    height: 60
                    text: qsTr("Swing")
                    font.pixelSize: 18
                    font.bold: true
                    font.family: "Open Sans"
                    highlighted: true
                    Material.accent: "#547B81"
                    onClicked: {
                        if(servo_state){
                            servo_state = false;
                            servo_check.active = false;
                            disinfecion.m_request = "servo0"
                        }
                        else{
                            servo_state = true;
                            servo_check.active = true;
                            disinfecion.m_request = "servo1"
                        }
                    }
                }

                StatusIndicator {
                    id: rodup_check
                    x: 285
                    color: "#008000"
                    anchors.topMargin: 26
                    anchors.top: parent.top
                    active: disinfecion.m_rodup
                }

                Button {
                    id: rodup_bt
                    x: 336
                    y: 8
                    width: 125
                    height: 60
                    text: qsTr("Rod up")
                    font.pixelSize: 18
                    font.bold: true
                    font.family: "Open Sans"
                    highlighted: true
                    Material.accent: "#547B81"
                    enabled: !(disinfecion.m_roddown)
                    onClicked: {
                        if(disinfecion.m_rodup){
                            disinfecion.m_rodup = false
                            disinfecion.m_request = "rodup0"

                        }
                        else{
                            disinfecion.m_rodup = true
                            disinfecion.m_request = "rodup1"
                        }
                    }
                }

                StatusIndicator {
                    id: roddown_check
                    x: 285
                    color: "#008000"
                    anchors.topMargin: 88
                    anchors.top: parent.top
                    active: disinfecion.m_roddown
                }

                Button {
                    id: roddown_bt
                    x: 336
                    y: 70
                    width: 125
                    height: 60
                    text: qsTr("Rod down")
                    font.pixelSize: 18
                    font.bold: true
                    font.family: "Open Sans"
                    highlighted: true
                    Material.accent: "#547B81"
                    enabled: !(disinfecion.m_rodup)
                    onClicked: {
                        if(disinfecion.m_roddown){
                            disinfecion.m_roddown = false
                            disinfecion.m_request = "roddown0"
                        }
                        else{
                            disinfecion.m_roddown = true
                            disinfecion.m_request = "roddown1"
                        }
                    }
                }

                Rectangle {
                    id: rod_height_box
                    y: 132
                    width: 220
                    height: 60
                    color: "#547B81"
                    radius: 4
                    border.width: 5
                    anchors.left: parent.left
                    anchors.leftMargin: 289
                    Text {
                        id: rod_height_data
                        x: 15
                        y: 20
                        color: "#ffffff"
                        text: "The heiget of rod: " + disinfecion.m_rodheight + "/250"
                        anchors.verticalCenter: parent.verticalCenter
                        font.bold: true
                        verticalAlignment: Text.AlignTop
                        horizontalAlignment: Text.AlignLeft
                        font.pixelSize: 18
                        font.family: "Open Sans"
                    }
                    border.color: "#00000000"
                }
            }
        }
    } // Spray System
}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.6600000262260437}D{i:7;anchors_height:100;anchors_width:100}
D{i:56;anchors_height:195;anchors_x:8;anchors_y:42}D{i:58;anchors_y:31}D{i:59;anchors_y:31}
D{i:60;anchors_y:31}D{i:61;anchors_y:31}D{i:62;anchors_y:31}D{i:63;anchors_y:31}D{i:64;anchors_y:31}
D{i:65;anchors_y:31}D{i:66;anchors_y:31}D{i:67;anchors_y:31}D{i:57;anchors_height:195;anchors_x:8;anchors_y:42}
D{i:55;anchors_height:195;anchors_x:8;anchors_y:42}D{i:54;anchors_height:195;anchors_x:8;anchors_y:42}
}
##^##*/

