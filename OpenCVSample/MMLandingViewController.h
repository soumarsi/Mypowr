//
//  MMLandingViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 09/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface MMLandingViewController : UIViewController<CLLocationManagerDelegate>{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UILabel *HeaderTextlbl;
    UIButton *Qrbtn,*Testdrivebtn,*Syncbtn,*Aboutbtn;
    UILabel *Qrlbl,*Testdrivelbl,*Synclbl,*Aboutlbl;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

@end
