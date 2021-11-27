#include "disinfectionmanager.h"

#include <QtConcurrent>
#include <QtDebug>
#include <sstream>
#include <vector>

DisinfectionManager::DisinfectionManager(QObject *parent) : QObject(parent){
    this->m_sensor.resize(13);
    this->m_rodup = false;
    this->m_roddown = false;
    this->m_rodheight = 0.0;
}

void DisinfectionManager::initialize(){
    SOCKET_STATE res;
    qDebug() << "init";
    this->time = new QTime();
    this->m_sock = new SocketClient(this->m_ip.toStdString(), this->m_port);

    res = this->m_sock->initialize();
    if (res != SUCCESS){
        qDebug() << "Failed Initialized";
        return;
    }
}

void DisinfectionManager::connect(){
    qDebug() << "connect";
    SOCKET_STATE res;
    qDebug() << "ip: " + this->m_ip;
    qDebug() << "port: " + QString::number(this->m_port);
    res = this->m_sock->connectToRemote();
    if (res != SUCCESS) {
        qDebug() << "FAILED Connection";
        return;
    }
    auto thread = QtConcurrent::run(this, &DisinfectionManager::start);
}

void DisinfectionManager::disconnect(){
    this->m_sock->disconnect();
    delete this->m_sock;
}

void DisinfectionManager::start(){
    SOCKET_STATE res;
    char return_value[1024] = {0};

    while(true) {
        if(this->m_request != ""){
            QByteArray temp = this->m_request.toLocal8Bit();
            char* command = temp.data();
            res = this->m_sock->sendData(command);
            if(res != SUCCESS){
                qDebug() << "FAILED Send";
                break;
            }
            if(this->m_request.left(3) == "rod"){
                this->time->start();
            }
            this->m_request = "";
        }
        if(this->m_rodup){
            if(this->m_rodheight + (this->time->elapsed()/100) < 250){
                this->set_rodheight(this->m_rodheight + (this->time->elapsed()/100));
                this->time->start();
            }
            else{
                this->set_rodheight(250.0);
                this->set_rodup(false);
                char stop[] = "rodup0";
                res = this->m_sock->sendData(stop);
                if(res != SUCCESS){
                    qDebug() << "FAILED Send";
                    break;
                }
            }
        }

        if(this->m_roddown){
            if(this->m_rodheight - (this->time->elapsed()/1000) > 0){
                this->set_rodheight(this->m_rodheight - (this->time->elapsed()/100));
                this->time->start();
            }
            else{
                this->set_rodheight(0.0);
                this->set_roddown(false);
                char stop[] = "roddown0";
                res = this->m_sock->sendData(stop);
                if(res != SUCCESS){
                    qDebug() << "FAILED Send";
                    break;
                }
            }
        }

        memset(&return_value, 0, 1024);
        res = this->m_sock->recvData(return_value);
        if (res != SUCCESS) {
            qDebug() << "FAILED Recv";
            break;
        }
        string msg = return_value;
        this->update_sensor(msg);
    }
}

void DisinfectionManager::update_sensor(string &msg){
    QVector<QString> result;
    if(msg != ""){
        stringstream ss(msg);
        while(ss.good()){
            string substr;
            getline(ss, substr, ',');
            result << QString::fromStdString(substr);
        }
    }
    else{
        result.resize(13);
    }

    this->set_sensor(result);
}


