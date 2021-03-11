//
//  ReceiveViewController.m
//  MapKitDrawingEllie
//
//  Created by Ellie Baker on 2/8/21.
//  Copyright © 2021 tazi.hosni.omar. All rights reserved.
//

#import "ReceiveViewController.h"

#import <MapKit/MapKit.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>



@interface ReceiveViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *tx_server_response_exploit;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit1;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit2;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit3;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit4;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit5;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit6;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit7;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit8;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit9;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit10;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit11;
@property (weak, nonatomic) IBOutlet UIButton *SendExploit12;
@end




@implementation ReceiveViewController

int idvar2 = 100;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)SendExploit1:(UIButton*)SendExploit1
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = (uint8_t)1000;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"1 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"1 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"1 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"1 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"1 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"1 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }
        
        
    }


-(IBAction)SendExploit2:(UIButton*)SendExploit2
{
        
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;
    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        NSString *str = [NSString stringWithFormat:@"2 - CYBER THREAT DETECTED"];
        _tx_server_response_exploit.text = str;
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"2 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"2 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"2 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"2 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"2 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"2 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"2 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
            }
        }

    }
        
    }



-(IBAction)SendExploit3:(UIButton*)SendExploit3
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = (uint8_t)1000;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"3 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"3 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"3 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"3 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"3 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"3 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}


-(IBAction)SendExploit4:(UIButton*)SendExploit4
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    //create message
    uint8_t msg[9];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;
    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,9,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        NSString *str = [NSString stringWithFormat:@"4 - CYBER THREAT DETECTED"];
        _tx_server_response_exploit.text = str;
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"4 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"4 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"4 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"4 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"4 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"4 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}

-(IBAction)SendExploit5:(UIButton*)SendExploit5
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"5 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"5 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"5 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"5 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"5 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"5 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}

-(IBAction)SendExploit6:(UIButton*)SendExploit6
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"6 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"6 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"6 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"6 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"6 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"6 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}

-(IBAction)SendExploit7:(UIButton*)SendExploit7
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"7 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"7 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"7 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"7 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"7 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"7 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}

-(IBAction)SendExploit8:(UIButton*)SendExploit8
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"8 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"8 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"8 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"8 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"8 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"8 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}


-(IBAction)SendExploit9:(UIButton*)SendExploit9
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"9 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"9 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"9 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"9 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"9 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"9 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}

-(IBAction)SendExploit10:(UIButton*)SendExploit10
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"10 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"10 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"10 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"10 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"10 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"10 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}

-(IBAction)SendExploit11:(UIButton*)SendExploit11
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"11 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"11 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"11 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"11 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"11 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"11 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}

-(IBAction)SendExploit12:(UIButton*)SendExploit12
{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;
    
    printf("\n\n errno is %s\n", strerror(errno));

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("127.01",&(servaddr.sin_addr)) <= 0)
        printf("CLIENT: Error on inet_pton\n");
      /* send and recieve NMSGS */
        
    //had a while loop but removed
        if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
            printf("CLIENT: Error creating listening socket.\n");
            /* connect to the server */
    
    
    
    if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
            printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
            exit(EXIT_FAILURE);
        }
    
    
    //create message
    uint8_t msg[10];
    msg[0] = 0x30;
    

        msg[1] = 0x30;
        msg[2] = 0x30;
        msg[3] = 0x30;
        msg[4]= 0x30;
        msg[5] = 0x0;
        msg[6] = 0x30;
        msg[7] = 0x30;
        msg[9] = idvar2;
        idvar2++;
        if((idvar2%2)!=0)             /* alternatve weapons based on msgid */
                msg[8] = 1;
        else
                msg[8] = 2;

    
    //send created message
    ssize_t nsent;
    /* send */
    if((nsent = send(sock,(void*)msg,10,0))<0){
        printf("Error on send\n");
    }
    uint8_t resp[6];
    printf("passes here");

    /* receive response */
    struct timeval tv2;
    tv2.tv_sec = 1;
    tv2.tv_usec = 1;
    int timeoutset2;
    //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
    if ((timeoutset2 = setsockopt(sock, SOL_SOCKET, SO_RCVTIMEO, (const char*)&tv2, sizeof tv2)) < 0) {
        printf("timeout setting error (%s)", strerror(errno));
    }
    else {
        printf("%d (%s)", timeoutset2, strerror(errno));
    }
    
    
    
    ssize_t nrecv;
    if((nrecv = recv(sock,(void*)resp,6,0))<0){
        printf("Error on receive\n");
    }
    printf("hi");
    printf("errno %s", strerror(errno));
    
    
    if (errno == EAGAIN || errno == EWOULDBLOCK) {
        printf("TIMEOUT YAY!!");
        NSString *str = [NSString stringWithFormat:@" TIMEOUT: SEND AGAIN"];
        _tx_server_response_exploit.text = str;
    }
    /*sleep(2);
    shutdown(sock, 0);
    
    if (resp[0] == 0 && resp[1] == 0) {
        printf("timeout occurred; resend message");
    }
    else*/

    
    
    if (resp[1] != (idvar2-1)) {
        printf("response %d, id %d", resp[1], idvar2);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"12 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 80: {
                NSString *str = [NSString stringWithFormat:@"12 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 96: {
                NSString *str = [NSString stringWithFormat:@"12 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 112: {
                NSString *str = [NSString stringWithFormat:@"12 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 128: {
                NSString *str = [NSString stringWithFormat:@"12 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            case 129: {
                NSString *str = [NSString stringWithFormat:@"12 - CYBER THREAT DETECTED"];
                _tx_server_response_exploit.text = str;
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_exploit.text = str;
            }
        }

    }

}

@end
