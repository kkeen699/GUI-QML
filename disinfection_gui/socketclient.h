#ifndef SOCKETCLIENT_H
#define SOCKETCLIENT_H
#include <string>

#if (defined(_WIN32) || defined(_WIN64))
#include <WinSock2.h>
#include <WS2tcpip.h>

#elif __linux__
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include <arpa/inet.h>
#endif

using namespace std;

typedef enum SOCKET_STATE {
    SUCCESS = 0,
    FAIL_CONNECTION ,
    FAIL_INITIALIZATION,
    FAIL_SOCKET_PROTO,
    FAIL_SEND_DATA,
    FAIL_RECV
} SOCKET_STATE;


class SocketClient {

public:
    SocketClient(string ipAddr, const int port_num): m_ip(ipAddr), m_port(port_num) {
    }
    SOCKET_STATE initialize();
    SOCKET_STATE connectToRemote();
    SOCKET_STATE recvData(char *return_value);
    SOCKET_STATE sendData(const char *msg);
    SOCKET_STATE disconnect();

private:
    string m_ip;
    int m_port;

#if (defined(_WIN32) || defined(_WIN64))
    WSAData m_wasData;
    SOCKADDR_IN m_addr;
    SOCKET m_sConnect;
#elif __linux__
    struct sockaddr_in m_addr;
    int m_sConnect; // file descriptor
#endif

};



#endif // SOCKETCLIENT_H
