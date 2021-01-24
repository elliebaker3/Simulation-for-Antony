//
//  ViewController.m
//  MapKitDrawing
//
//  Created by tazi afafe on 17/05/2014.
//  Copyright (c) 2014 tazi.omar. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "CanvasView.h"
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

@interface ViewController () <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) NSMutableArray *coordinates;
@property (nonatomic, strong) NSMutableArray *polygonPoints;
@property (weak, nonatomic) IBOutlet UIButton *drawPolygonButton;
@property (weak, nonatomic) IBOutlet UIButton *AORButton;
@property (weak, nonatomic) IBOutlet UIButton *TargetButton;
@property (weak, nonatomic) IBOutlet UIButton *SendCoordinates;
@property (weak, nonatomic) IBOutlet UITextField *tx_server_response;
@property (nonatomic) BOOL isDrawingPolygon;
@property (nonatomic, strong) CanvasView *canvasView;
@end

@implementation ViewController

@synthesize coordinates = _coordinates;
@synthesize canvasView = _canvasView;

int type = 100;
int idvar = 100;
bool invalid = false;


- (NSMutableArray*)coordinates
{
    if(_coordinates == nil) _coordinates = [[NSMutableArray alloc] init];
    return _coordinates;
}


- (CanvasView*)canvasView
{
    if(_canvasView == nil) {
        _canvasView = [[CanvasView alloc] initWithFrame:self.mapView.frame];
        _canvasView.userInteractionEnabled = YES;
        _canvasView.delegate = self;
    }
    return _canvasView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MKCoordinateRegion region = [_mapView regionThatFits:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(23.6978, 120.9605), 2000000, 2000000)];
    [_mapView setRegion:region animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


-(IBAction)TargetCoordinates:(UIButton*)sender
{
    type = 1;
    if(self.isDrawingPolygon == NO || (self.coordinates.count==0)) {
        
        self.isDrawingPolygon = YES;
        [self.coordinates removeAllObjects];
        [self.view addSubview:self.canvasView];
    } else {
        
        NSInteger numberOfPoints = [self.coordinates count];
        
        //if (numberOfPoints > 2)
        //{
            CLLocationCoordinate2D points[4];
            CLLocationCoordinate2D sentpoints[2];
        //store upper left and lower right corners to sent to server
            for (NSInteger i = 0; i < numberOfPoints; i++) {
                sentpoints[i] = [self.coordinates[i] MKCoordinateValue];
            }
        points[0] = [self.coordinates[0] MKCoordinateValue];
        points[2] = [self.coordinates[1] MKCoordinateValue];
        points[1].latitude = [self.coordinates[0] MKCoordinateValue].latitude;
        points[1].longitude = [self.coordinates[1] MKCoordinateValue].longitude;
        points[3].latitude = [self.coordinates[1] MKCoordinateValue].latitude;
        points[3].longitude = [self.coordinates[0] MKCoordinateValue].longitude;
        
        [self.mapView addOverlay:[MKPolygon polygonWithCoordinates:points count:(numberOfPoints+2)]];
        //combined send
        
        
        
        int sock;        /*  listening socket */
        struct sockaddr_in servaddr;  /*  socket address structure */
        int res;
            
        uint16_t port = 9000;
        
        

        /* set up the server address */
        memset(&servaddr, 0, sizeof(servaddr));
        servaddr.sin_family = AF_INET;
        servaddr.sin_port   = htons(port);
        if(inet_aton("10.0.0.145",&(servaddr.sin_addr)) <= 0)
            printf("CLIENT: Error on inet_pton\n");
          /* send and recieve NMSGS */
            
        //had a while loop but removed
            if ((sock = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0 )
                printf("CLIENT: Error creating listening socket.\n");
                /* connect to the server */
            
        /*set timeout on receiving a response*/
        /*struct timeval tv;
        tv.tv_usec = 1;
        int timeoutset;
        //can set at the socket level, but attempt to indicate that an option is interpreted by the TCP yields an error "Protocol not available"
        if ((timeoutset = setsockopt(sock, IPPROTO_TCP, SO_RCVTIMEO, (const char*)&tv, sizeof tv)) < 0) {
            printf("timeout setting error");
        }
        */
        
        
        if((res = connect(sock,(struct sockaddr *) &servaddr, sizeof(servaddr))) < 0) {
                printf("CLIENT: Error calling connect (%s)\n",strerror(errno));
                exit(EXIT_FAILURE);
            }
        
        
        //create message
        uint8_t msg[10];
        float converter;
        msg[0] = 0x30;
        
        if (invalid == false) {
            msg[1] = (int)sentpoints[0].latitude;
            converter = sentpoints[0].latitude - (int)sentpoints[0].latitude;
            converter = 60*converter;
            msg[2] = (int)converter;
            converter = converter-(int)converter;
            converter = 60*converter;
            msg[3] = (int)converter;
            msg[4]= abs((int)sentpoints[0].longitude);
            converter = fabs(sentpoints[0].longitude) - abs((int)sentpoints[0].longitude);
            converter = 60*converter;
            if (sentpoints[0].longitude > 0) {
                msg[5] = 0x0;
            }
            else {
                msg[5] = 0xFF;
            }
            msg[6] = (int)converter; //give it 0x0 or 0x255
            converter = converter-(int)converter;
            converter = 60*converter; //store the number as an int16 have the
            //get a pointer u32*bp assign first half to one variable and the second half to the other
            //assign to 16int iterate over it twice first byte first var second byte second var
            msg[7] = (int)converter;
            msg[9] = idvar;
            printf("\n\n TARGET\nlatitude deg %d, min %d, sec %d, from %f\n", msg[1], msg[2], msg[3], sentpoints[0].latitude);
            printf("longitude deg %d, min %d, sec %d, sign %d, from %f\n", msg[4], msg[5], msg[6], msg[7], sentpoints[0].longitude);
            idvar++;
            if((idvar%2)!=0)             /* alternatve weapons based on msgid */
                    msg[8] = 1;
            else
                    msg[8] = 2;
        }
        else {
            msg[1] = (uint8_t)1000;
            converter = fabs(sentpoints[0].latitude) - abs((int)sentpoints[0].latitude);
            converter = 60*converter;
            msg[2] = (int)converter;
            converter = 60*converter;
            msg[3] = (int)converter;
            msg[4]= abs((int)sentpoints[0].longitude);
            converter = fabs(sentpoints[0].longitude) - abs((int)sentpoints[0].longitude);
            converter = 60*converter;
            if (sentpoints[0].longitude > 0) {
                msg[5] = 0x0;
            }
            else {
                msg[5] = 0xFF;
            }
            msg[6] = (int)converter;
            converter = 60*converter;
            msg[7] = (int)converter;
            printf("\n\nINVALID TARGET\nlatitude deg %d, min %d, sec %d, from %f\n", msg[1], msg[2], msg[3], sentpoints[0].latitude);
            printf("longitude deg %d, min %d, sec %d, degree %d, from %f\n", msg[4], msg[5], msg[6], msg[7], sentpoints[0].longitude);
            msg[9] = idvar;
            idvar++;
            if((idvar%2)!=0)             /* alternatve weapons based on msgid */
                    msg[8] = 1;
            else
                    msg[8] = 2;
        }
        
        //send created message
        ssize_t nsent;
        /* send */
        if((nsent = send(sock,(void*)msg,10,0))<0){
            printf("Error on send\n");
        }
        uint8_t resp[6];
        

        /* receive response */
        ssize_t nrecv;
        if((nrecv = recv(sock,(void*)resp,6,0))<0){
            printf("Error on send\n");
        }
        /*sleep(2);
        shutdown(sock, 0);
        
        if (resp[0] == 0 && resp[1] == 0) {
            printf("timeout occurred; resend message");
        }
        else*/
        
        if (resp[1] != (idvar-1)) {
            printf("response %d, id %d", resp[1], idvar);
        }
        else {
            switch(resp[0]) {
                case 64: {
                    NSString *str = [NSString stringWithFormat:@"CYBER THREAT DETECTED"];
                    _tx_server_response.text = str;
                    break;
                }
                case 80: {
                    NSString *str = [NSString stringWithFormat:@"FIRING FAULT DETECTED"];
                    _tx_server_response.text = str;
                    break;
                }
                case 96: {
                    NSString *str = [NSString stringWithFormat:@"INVALID TARGET DETECTED"];
                    _tx_server_response.text = str;
                    break;
                }
                case 112: {
                    NSString *str = [NSString stringWithFormat:@"WEAPON AWAY DETECTED"];
                    _tx_server_response.text = str;
                    break;
                }
                case 128: {
                    NSString *str = [NSString stringWithFormat:@"KERNAL FAULT DETECTED"];
                    _tx_server_response.text = str;
                    break;
                }
                case 129: {
                    NSString *str = [NSString stringWithFormat:@"MESSAGE FAULT DETECTED"];
                    _tx_server_response.text = str;
                    break;
                }
                default: {
                    NSString *str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                    _tx_server_response.text = str;
                }
            }
    
        }
        
        if (invalid == false) {
            [self.TargetButton setTitle:@"Invalid" forState:UIControlStateNormal];
        }
        else
            [self.TargetButton setTitle:@"Target" forState:UIControlStateNormal];
        invalid=!invalid;
        self.isDrawingPolygon = NO;
        //[self.drawPolygonButton setTitle:@"EZ" forState:UIControlStateNormal];
        self.canvasView.image = nil;
        [self.canvasView removeFromSuperview];
        
    }
}
- (IBAction)didTouchUpInsideDrawButton:(UIButton*)sender
{
    type = 2;
    if(self.isDrawingPolygon == NO || (self.coordinates.count == 0)) {
        
        self.isDrawingPolygon = YES;
        [self.coordinates removeAllObjects];
        [self.view addSubview:self.canvasView];
        
    } else {
        
        NSInteger numberOfPoints = [self.coordinates count];
        
        //if (numberOfPoints > 2)
        //{
            CLLocationCoordinate2D points[4];
            CLLocationCoordinate2D sentpoints[2];
        //store upper left and lower right corners to sent to server
            for (NSInteger i = 0; i < numberOfPoints; i++) {
                sentpoints[i] = [self.coordinates[i] MKCoordinateValue];
            }
        points[0] = [self.coordinates[0] MKCoordinateValue];
        points[2] = [self.coordinates[1] MKCoordinateValue];
        points[1].latitude = [self.coordinates[0] MKCoordinateValue].latitude;
        points[1].longitude = [self.coordinates[1] MKCoordinateValue].longitude;
        points[3].latitude = [self.coordinates[1] MKCoordinateValue].latitude;
        points[3].longitude = [self.coordinates[0] MKCoordinateValue].longitude;

        [self.mapView addOverlay:[MKPolygon polygonWithCoordinates:points count:(numberOfPoints+2)]];
        //combined send
        int sock;        /*  listening socket */
        struct sockaddr_in servaddr;  /*  socket address structure */
        int res;
            
        uint16_t port = 9000;

        /* set up the server address */
        memset(&servaddr, 0, sizeof(servaddr));
        servaddr.sin_family = AF_INET;
        servaddr.sin_port   = htons(port);
        if(inet_aton("10.0.0.145",&(servaddr.sin_addr)) <= 0)
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
        
        uint8_t msg[16];
        
        msg[0] = 0x20;
        NSInteger i = 1;
        float converter;
        for (NSInteger a = 0; a < 2; a++) {
            msg[i] = (int)sentpoints[a].latitude;
            i++;
            converter = sentpoints[a].latitude - (int)sentpoints[a].latitude;
            converter = 60*converter;
            msg[i] = (int)converter;
            i++;
            converter = 60*converter;
            msg[i] = (int)converter;
            i++;
            msg[i]= (int)sentpoints[a].longitude;
            i++;
            converter = sentpoints[a].longitude - (int)sentpoints[a].longitude;
            converter = 60*converter;
            if (sentpoints[a].longitude < 0)
                msg[i]=0xFF;
            else
                msg[i]=0;
            i++;
            msg[i] = (int)converter;
            i++;
            converter = 60*converter;
            msg[i] = (int)converter;
            i++;
        }
        msg[i]=idvar;
        idvar++;
        printf("\n\nEZ upper left \nlatitude deg %d, min %d, sec %d, from %f\n", msg[1], msg[2], msg[3], sentpoints[0].latitude);
        printf("longitude deg %d, min %d, sec %d, degree %d, from %f\n", msg[4], msg[5], msg[6], msg[7], sentpoints[0].longitude);
        printf("EZ lower right\nlatitude deg %d, min %d, sec %d, from %f\n", msg[8], msg[9], msg[10], sentpoints[1].latitude);
        printf("longitude deg %d, min %d, sec %d, degree %d, from %f\n", msg[11], msg[12], msg[13], msg[14], sentpoints[1].longitude);
        printf("\nid %d", msg[15]);
        ssize_t nsent;
        /* send */
        if((nsent = send(sock,(void*)msg,16,0))<0){
            printf("Error on send\n");
        }
        uint8_t resp[2];
                /* receive response */
        NSString *str; // string to hold response for text field
        NSString* str2; //second received message info
        ssize_t nrecv;
        if((nrecv = recv(sock,(void*)resp,2,0))<0){
            printf("Error on send\n");
        }
        
        if (resp[1] != (idvar-1)) {
            printf("unmatched message detected");
        }
        else {
            switch(resp[0]) {
                case 64: {
                    str = [NSString stringWithFormat:@"CYBER THREAT DETECTED"];
                    break;
                }
                case 80: {
                    str = [NSString stringWithFormat:@"FIRING FAULT DETECTED"];
                    break;
                }
                case 96: {
                    str = [NSString stringWithFormat:@"INVALID TARGET DETECTED"];
                    break;
                }
                case 112: {
                    str = [NSString stringWithFormat:@"WEAPON AWAY DTECTED"];
                    break;
                }
                case 128: {
                    str = [NSString stringWithFormat:@"KERNAL FAULT DETECTED"];
                    break;
                }
                case 129: {
                    str = [NSString stringWithFormat:@"MESSAGE FAULT DETECTED"];
                    break;
                }
                default: {
                    str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                }
            }
        }
        
        if((nrecv = recv(sock,(void*)resp,2,0))<0){
            printf("Error on send\n");
        }
        
        if (resp[1] != (idvar-1)) {
            printf("unmatched message detected");
        }
        else {
            switch(resp[0]) {
                case 64: {
                    str2 = [NSString stringWithFormat:@"CYBER THREAT DETECTED"];
                    break;
                }
                case 80: {
                    str2 = [NSString stringWithFormat:@"FIRING FAULT DETECTED"];
                    break;
                }
                case 96: {
                    str2 = [NSString stringWithFormat:@"INVALID TARGET DETECTED"];
                    break;
                }
                case 112: {
                    str2 = [NSString stringWithFormat:@"WEAPON AWAY DTECTED"];
                    break;
                }
                case 128: {
                    str2 = [NSString stringWithFormat:@"KERNAL FAULT DETECTED"];
                    break;
                }
                case 129: {
                    str2 = [NSString stringWithFormat:@"MESSAGE FAULT DETECTED"];
                    break;
                }
                default: {
                    str2 = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                }
            }
        }
        //str = [str stringByAppendingFormat:@" -- %@", str2];
        
        //only print message if both messages received back are the same, otherwise print an error
        if ([str isEqualToString:str2]) {
            _tx_server_response.text = str;
        }
        else {
            _tx_server_response.text = @"Inconsistent Response Resend Coordinates";
        }
        
        self.isDrawingPolygon = NO;
        //[self.drawPolygonButton setTitle:@"EZ" forState:UIControlStateNormal];
        self.canvasView.image = nil;
        [self.canvasView removeFromSuperview];
        
    }
}

//again eliminate eventually
- (IBAction)AORCoordinates:(UIButton*)sender
{
    type = 3;
    if(self.isDrawingPolygon == NO || (self.coordinates.count == 0)   ) {
        
        self.isDrawingPolygon = YES;
        [self.coordinates removeAllObjects];
        [self.view addSubview:self.canvasView];
        
    } else {
        
        NSInteger numberOfPoints = [self.coordinates count];
        
        //if (numberOfPoints > 2)
        //{
            CLLocationCoordinate2D points[4];
            CLLocationCoordinate2D sentpoints[2];
        //store upper left and lower right corners to sent to server
            for (NSInteger i = 0; i < numberOfPoints; i++) {
                sentpoints[i] = [self.coordinates[i] MKCoordinateValue];
            }
        points[0] = [self.coordinates[0] MKCoordinateValue];
        points[2] = [self.coordinates[1] MKCoordinateValue];
        points[1].latitude = [self.coordinates[0] MKCoordinateValue].latitude;
        points[1].longitude = [self.coordinates[1] MKCoordinateValue].longitude;
        points[3].latitude = [self.coordinates[1] MKCoordinateValue].latitude;
        points[3].longitude = [self.coordinates[0] MKCoordinateValue].longitude;
        
        [self.mapView addOverlay:[MKPolygon polygonWithCoordinates:points count:(numberOfPoints+2)]];
        //combined send
        int sock;        /*  listening socket */
        struct sockaddr_in servaddr;  /*  socket address structure */
        int res;
            
        uint16_t port = 9000;

        /* set up the server address */
        memset(&servaddr, 0, sizeof(servaddr));
        servaddr.sin_family = AF_INET;
        servaddr.sin_port   = htons(port);
        if(inet_aton("10.0.0.145",&(servaddr.sin_addr)) <= 0)
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
        
        uint8_t msg[16];
        
        msg[0] = 0x10;
        NSInteger i = 1;
        float converter;
        for (NSInteger a = 0; a < 2; a++) {
            msg[i] = (int)sentpoints[a].latitude;
            i++;
            converter = sentpoints[a].latitude - (int)sentpoints[a].latitude;
            converter = 60*converter;
            msg[i] = (int)converter;
            i++;
            converter = 60*converter;
            msg[i] = (int)converter;
            i++;
            msg[i]= (int)sentpoints[a].longitude;
            i++;
            converter = sentpoints[a].longitude - (int)sentpoints[a].longitude;
            converter = 60*converter;
            if (sentpoints[a].longitude < 0)
                msg[i]=0xFF;
            else
                msg[i]=0;
            i++;
            msg[i] = (int)converter;
            i++;
            converter = 60*converter;
            msg[i] = (int)converter;
            i++;
        }
        msg[i]=idvar;
        idvar++;
        
        printf("\n\nAOR upper left \nlatitude deg %d, min %d, sec %d, from %f\n", msg[1], msg[2], msg[3], sentpoints[0].latitude);
        printf("longitude deg %d, min %d, sec %d, degree %d, from %f\n", msg[4], msg[5], msg[6], msg[7], sentpoints[0].longitude);
        printf("AOR lower right\nlatitude deg %d, min %d, sec %d, from %f\n", msg[8], msg[9], msg[10], sentpoints[1].latitude);
        printf("longitude deg %d, min %d, sec %d, degree %d, from %f\n", msg[11], msg[12], msg[13], msg[14], sentpoints[1].longitude);
        printf("\nid %d", msg[15]);
        
        ssize_t nsent;
        /* send */
        if((nsent = send(sock,(void*)msg,16,0))<0){
            printf("Error on send\n");
        }
        uint8_t resp[2];
                /* receive response */
        NSString *str;
        NSString *str2;
        ssize_t nrecv;
        if((nrecv = recv(sock,(void*)resp,2,0))<0){
            printf("Error on send\n");
        }
        if (resp[1] != (idvar-1)) {
            printf("unmatched message detected");
        }
        else {
            switch(resp[0]) {
                case 64: {
                    str = [NSString stringWithFormat:@"CYBER THREAT DETECTED"];
                    break;
                }
                case 80: {
                    str = [NSString stringWithFormat:@"FIRING FAULT DETECTED"];
                    break;
                }
                case 96: {
                    str = [NSString stringWithFormat:@"INVALID TARGET DETECTED"];
                    break;
                }
                case 112: {
                    str = [NSString stringWithFormat:@"WEAPON AWAY DETECTED"];
                    break;
                }
                case 128: {
                    str = [NSString stringWithFormat:@"KERNAL FAULT DETECTED"];
                    break;
                }
                case 129: {
                    str = [NSString stringWithFormat:@"MESSAGE FAULT DETECTED"];
                    break;
                }
                default: {
                    str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                }
            }
        }
        
        //second message
        if((nrecv = recv(sock,(void*)resp,2,0))<0){
            printf("Error on send\n");
        }
        
        if (resp[1] != (idvar-1)) {
            printf("unmatched message detected");
        }
        else {
            switch(resp[0]) {
                case 64: {
                    str2 = [NSString stringWithFormat:@"CYBER THREAT DETECTED"];
                    break;
                }
                case 80: {
                    str2 = [NSString stringWithFormat:@"FIRING FAULT DETECTED"];
                    break;
                }
                case 96: {
                    str2 = [NSString stringWithFormat:@"INVALID TARGET DETECTED"];
                    break;
                }
                case 112: {
                    str2 = [NSString stringWithFormat:@"WEAPON AWAY DTECTED"];
                    break;
                }
                case 128: {
                    str2 = [NSString stringWithFormat:@"KERNAL FAULT DETECTED"];
                    break;
                }
                case 129: {
                    str2 = [NSString stringWithFormat:@"MESSAGE FAULT DETECTED"];
                    break;
                }
                default: {
                    str2 = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
                }
            }
        }
        //str = [str stringByAppendingFormat:@" -- %@", str2];
        
        //only print message if both messages received back are the same, otherwise print an error
        if ([str isEqualToString:str2]) {
            _tx_server_response.text = str;
        }
        else {
            _tx_server_response.text = @"Invalid Response Resend Coordinates";
        }
        
        self.isDrawingPolygon = NO;
        //[self.drawPolygonButton setTitle:@"EZ" forState:UIControlStateNormal];
        self.canvasView.image = nil;
        [self.canvasView removeFromSuperview];
        
    }
}

- (IBAction)SendCoordinates:(UIButton*)sender{
    int sock;        /*  listening socket */
    struct sockaddr_in servaddr;  /*  socket address structure */
    int res;
        
    uint16_t port = 9000;

    /* set up the server address */
    memset(&servaddr, 0, sizeof(servaddr));
    servaddr.sin_family = AF_INET;
    servaddr.sin_port   = htons(port);
    if(inet_aton("10.0.0.145",&(servaddr.sin_addr)) <= 0)
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
        uint8_t msg[16];
            // type
            msg[0] = 0x20;

            /* coord1 */
            msg[1] = -64;
            msg[2] = 0x10;
            msg[3] = 0x20;
            msg[4] = 180;
            msg[5] = 0x00;
            msg[6] = 0x30;
            msg[7] = 0x40;
            msg[8] = -64;
            msg[9] = 0x10;
            msg[10] = 0x20;
            msg[11] = 180;
            msg[12] = 0x00;
            msg[13] = 0x30;
            msg[14] = 0x40;
            msg[15] = 0x15;

            printf("Type %d\n",msg[0]);
            printf("Coord 1 ");
            printf("Lat : %d %d %d ",msg[1],msg[2],msg[3]);
            printf("Long : %d %d %d %d\n",msg[4],msg[5],msg[6],msg[7]);

            printf("Weapon type :%d \n",msg[8]);
            ssize_t nsent;
            /* send */
            if((nsent = send(sock,(void*)msg,16,0))<0){
                printf("Error on send\n");
            }
        uint8_t resp[2];
                /* receive response */
        ssize_t nrecv;
        if((nrecv = recv(sock,(void*)resp,2,0))<0){
            printf("Error on send\n");
        }
        printf("response is %d MsgId %d\n",resp[0],resp[1]);
    
    NSString *str;
    
    if (resp[0]==64) {
            str = [NSString stringWithFormat:@"CYBER THREAT DETECTED"];
    }
    else {
            str = [NSString stringWithFormat:@"code %d MsgID %d",resp[0],resp[1]];
    }
        _tx_server_response.text = str;
}

#pragma mark - Touch handling

- (void)touchesBegan:(UITouch*)touch
{
    CGPoint location = [touch locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
    [self.coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
}

- (void)touchesMoved:(UITouch*)touch
{
    /*CGPoint location = [touch locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
    [self.coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];*/
}

- (void)touchesEnded:(UITouch*)touch
{
    CGPoint location = [touch locationInView:self.mapView];
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:location toCoordinateFromView:self.mapView];
    [self.coordinates addObject:[NSValue valueWithMKCoordinate:coordinate]];
    if (type == 1)
        [self TargetCoordinates:nil];
    else if (type ==2)
        [self didTouchUpInsideDrawButton:nil];
    else if (type ==3)
        [self AORCoordinates:nil];
    else
        printf("error");
}

#pragma mark - MKMapViewDelegate


- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
    MKOverlayPathView *overlayPathView;
    
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        overlayPathView = [[MKPolygonView alloc] initWithPolygon:(MKPolygon*)overlay];
        
        if (type == 1) {
            overlayPathView.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
            overlayPathView.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
            overlayPathView.lineWidth = 20;
        }
        else if (type == 2){
            overlayPathView.fillColor = [[UIColor redColor] colorWithAlphaComponent:0.2];
            overlayPathView.strokeColor = [[UIColor redColor] colorWithAlphaComponent:0.7];
            overlayPathView.lineWidth = 3;
        }
        else if (type ==3){
            overlayPathView.fillColor = [[UIColor greenColor] colorWithAlphaComponent:0.2];
            overlayPathView.strokeColor = [[UIColor greenColor] colorWithAlphaComponent:0.7];
            overlayPathView.lineWidth = 3;
        }
        else
            printf("error");
        
        return overlayPathView;
    }
    
    else if ([overlay isKindOfClass:[MKPolyline class]])
    {
        overlayPathView = [[MKPolylineView alloc] initWithPolyline:(MKPolyline *)overlay];
        
        overlayPathView.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        overlayPathView.lineWidth = 20;
        
        return overlayPathView;
    }
    
    return nil;
}


@end
