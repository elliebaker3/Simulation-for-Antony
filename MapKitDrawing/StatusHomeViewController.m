//
//  StatusHomeViewController.m
//  MapKitDrawingEllie
//
//  Created by Ellie Baker on 2/26/21.
//  Copyright © 2021 tazi.hosni.omar. All rights reserved.
//

#import "StatusHomeViewController.h"
#import <MapKit/MapKit.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>


@interface StatusHomeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *SystemUpdate;
@property (weak, nonatomic) IBOutlet UITextView *tx_server_response_status;
@property (weak, nonatomic) IBOutlet UITextView *weapon1string;
@property (weak, nonatomic) IBOutlet UITextView *weapon1color;
@property (weak, nonatomic) IBOutlet UITextView *weapon2string;
@property (weak, nonatomic) IBOutlet UITextView *weapon2color;
@property (weak, nonatomic) IBOutlet UITextView *weapon3string;
@property (weak, nonatomic) IBOutlet UITextView *weapon3color;
@property (weak, nonatomic) IBOutlet UITextView *weapon4string;
@property (weak, nonatomic) IBOutlet UITextView *weapon4color;
@end

@implementation StatusHomeViewController
int idvar3 = 100;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)SystemUpdate:(UIButton*)SystemUpdate
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
        msg[9] = idvar3;
        idvar3++;
        if((idvar3%2)!=0)             /* alternatve weapons based on msgid */
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
        _weapon1string.text = str;
    }

    
    if (resp[1] != (idvar3-1)) {
        printf("response %d, id %d", resp[1], idvar3);
    }
    else {
        switch(resp[0]) {
            case 64: {
                NSString *str = [NSString stringWithFormat:@"  - Cyber Threat Detected"];
                NSString *strall = [NSString stringWithFormat:@"  Weapon 1: Cyber Threat Detected\n  Weapon 2: Invalid Target Detected\n  Weapon 3: Cyber Threat Detected\n  Weapon 4: Weapon Away Detected"];
                _tx_server_response_status.text = strall;
                _weapon1string.text = str;
                [_weapon1color setBackgroundColor: [UIColor redColor]];
                break;
            }
            case 80: {
                NSString *strall = [NSString stringWithFormat:@"  Weapon 1: Firing Fault Detected\n  Weapon 2: Invalid Target Detected\n  Weapon 3: Cyber Threat Detected\n  Weapon 4: Weapon Away Detected"];
                NSString *str = [NSString stringWithFormat:@"  - Firing Fault Detected"];
                _tx_server_response_status.text = strall;
                _weapon1string.text = str;
                [_weapon1color setBackgroundColor: [UIColor redColor]];
                break;
            }
            case 96: {
                NSString *strall = [NSString stringWithFormat:@"  Weapon 1: Invalid Target Detected\n  Weapon 2: Invalid Target Detected\n  Weapon 3: Cyber Threat Detected\n  Weapon 4: Weapon Away Detected"];
                NSString *str = [NSString stringWithFormat:@"  - Invalid Target Detected"];
                _tx_server_response_status.text = strall;
                _weapon1string.text = str;
                [_weapon1color setBackgroundColor: [UIColor yellowColor]];
                break;
            }
            case 112: {
                NSString *strall = [NSString stringWithFormat:@"  Weapon 1: Weapon Away Detected\n  Weapon 2: Invalid Target Detected\n  Weapon 3: Cyber Threat Detected\n  Weapon 4: Weapon Away Detected"];
                NSString *str = [NSString stringWithFormat:@"  - Weapon Away Detected"];
                _tx_server_response_status.text = strall;
                _weapon1string.text = str;
                [_weapon1color setBackgroundColor: [UIColor greenColor]];
                break;
            }
            case 128: {
                NSString *strall = [NSString stringWithFormat:@"  Weapon 1: Kernal Fault Detected\n  Weapon 2: Invalid Target Detected\n  Weapon 3: Cyber Threat Detected\n  Weapon 4: Weapon Away Detected"];
                NSString *str = [NSString stringWithFormat:@"  - Kernal Fault Detected"];
                _tx_server_response_status.text = strall;
                _weapon1string.text = str;
                [_weapon1color setBackgroundColor: [UIColor redColor]];
                break;
            }
            case 129: {
                NSString *strall = [NSString stringWithFormat:@"  Weapon 1: Message Fault Detected\n  Weapon 2: Invalid Target Detected\n  Weapon 3: Cyber Threat Detected\n  Weapon 4: Weapon Away Detected"];
                NSString *str = [NSString stringWithFormat:@"  - Message Fault Detected"];
                _tx_server_response_status.text = strall;
                _weapon1string.text = str;
                [_weapon1color setBackgroundColor: [UIColor yellowColor]];
                break;
            }
            default: {
                NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                _tx_server_response_status.text = str;
                _weapon1string.text = str;
                [_weapon1color setBackgroundColor: [UIColor yellowColor]];
            }
                
        }

    }
        
}


@end
