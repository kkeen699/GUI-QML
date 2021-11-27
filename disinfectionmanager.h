#ifndef DISINFECTIONMANAGER_H
#define DISINFECTIONMANAGER_H

#include <QObject>
#include <QVector>
#include <QTime>

#include "controlmanager.h"
#include "socketclient.h"

class DisinfectionManager : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString m_ip WRITE set_ip);
    Q_PROPERTY(int m_port WRITE set_port);
    Q_PROPERTY(QVector<QString> m_sensor READ get_sensor WRITE set_sensor NOTIFY sensorchanged);
    Q_PROPERTY(QString m_request WRITE set_request);
    Q_PROPERTY(bool m_rodup READ get_rodup WRITE set_rodup NOTIFY rodupchanged);
    Q_PROPERTY(bool m_roddown READ get_roddown WRITE set_roddown NOTIFY roddownchanged);
    Q_PROPERTY(float m_rodheight READ get_rodheight WRITE set_rodheight NOTIFY rodheightchanged);

public:
    explicit DisinfectionManager(QObject *parent = nullptr);
    Q_INVOKABLE void initialize();
    Q_INVOKABLE void connect();
    Q_INVOKABLE void disconnect();
    Q_INVOKABLE void start();
    Q_INVOKABLE void update_sensor(string &msg);

    void set_ip(const QString &ip){this->m_ip = ip;}
    void set_port(const int &port){this->m_port = port;}
    void set_sensor(const QVector<QString> &sensor){
        this->m_sensor = sensor;
        emit this->sensorchanged();
    }
    void set_request(const QString &request){this->m_request = request;}

    void set_rodup(const bool &rodup){
        this->m_rodup = rodup;
        emit this->rodupchanged();
    }
    void set_roddown(const bool &roddown){
        this->m_roddown = roddown;
        emit this->roddownchanged();
    }
    void set_rodheight(const float &rodheight){
        this->m_rodheight = rodheight;
        emit this->rodheightchanged();
    }

    QVector<QString> get_sensor(){return m_sensor;}
    bool get_rodup(){return m_rodup;}
    bool get_roddown(){return m_roddown;}
    float get_rodheight(){return m_rodheight;}

signals:
    void sensorchanged();
    void rodupchanged();
    void roddownchanged();
    void rodheightchanged();

private:
    QString m_ip;
    int m_port;
    QString m_request;
    SocketClient *m_sock;
    QVector<QString> m_sensor;
    QTime *time;
    bool m_rodup;
    bool m_roddown;
    float m_rodheight;

};

#endif // DISINFECTIONMANAGER_H
