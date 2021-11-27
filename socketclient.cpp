#include "socketclient.h"
#include <QtDebug>

#define MAX_BUFFER_SIZE 4096

SOCKET_STATE SocketClient::initialize(){
#if defined(_WIN32) || defined(_WIN64)
    WORD DLLVersion;
    DLLVersion = MAKEWORD(2, 2);
    int r = WSAStartup(DLLVersion, &this->m_wasData);

    if (r != NO_ERROR) {
        qDebug() << "Winsocket2 initialize failed";
        return FAIL_INITIALIZATION;
    }
#endif

    this->m_sConnect = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
#if defined(_WIN32) || defined(_WIN64)
    if (this->m_sConnect == INVALID_SOCKET) {
        qDebug() << "Socket function failed";
        this->disconnect();
        return FAIL_SOCKET_PROTO;
    }
#elif __linux__
    if (this->m_sConnect < 0) {
        qDebug() << "Socket function failed";
        this->disconnect();
        return FAIL_SOCKET_PROTO;
    }
#endif

    this->m_addr.sin_family = AF_INET;
    this->m_addr.sin_port = htons(static_cast<u_short>(this->m_port));
    if(inet_pton(AF_INET, this->m_ip.c_str(), &this->m_addr.sin_addr) != 1) {
        qDebug() << "Socket pton error";
        this->disconnect();
        return FAIL_INITIALIZATION;
    }

    return SUCCESS;
}

SOCKET_STATE SocketClient::connectToRemote() {
    int res;

    qDebug() << "Connect to remote";
#if (defined(_WIN32) || defined(_WIN64))

    res = connect(this->m_sConnect, (SOCKADDR*)&this->m_addr, sizeof(this->m_addr));
    if(res == SOCKET_ERROR) {
        int error = WSAGetLastError();
        qDebug() << "Error to reach remote: " << error;
        WSACleanup();
        return FAIL_CONNECTION;
    }
#elif __linux__
    res = connect(this->m_sConnect, (struct sockaddr*)&this->m_addr, sizeof(this->m_addr));
    if (res < 0) {
        qDebug() << "Error to reach remote: " << error;
        return FAIL_CONNECTION;
    }

#endif

    return SUCCESS;
}

SOCKET_STATE SocketClient::recvData(char *return_value) {
    int check;
    char msg[1024] = {0};

    check = recv(this->m_sConnect, msg, 1024, 0);
    if (check == 0) {
        qDebug() << "No input";
        return FAIL_RECV;
    } else if (check < 0) {
        qDebug() << "RecvFailed: ";
        return FAIL_RECV;
    }
    memcpy(return_value, &msg, std::strlen(msg));

    return SUCCESS;
}

SOCKET_STATE SocketClient::sendData(const char *msg) {
    int res;
    res = send(this->m_sConnect, msg, std::strlen(msg), 0);
    return SUCCESS;
}

SOCKET_STATE SocketClient::disconnect() {
#if defined(_WIN32) || defined(_WIN64)
    closesocket(this->m_sConnect);
    WSACleanup();
#elif __linux__
    close(this->m_sConnect);
#endif
    return SUCCESS;
}
