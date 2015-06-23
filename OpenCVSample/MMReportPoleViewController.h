//
//  MMReportPoleViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import <CoreLocation/CoreLocation.h>
@interface MMReportPoleViewController : UIViewController<CLLocationManagerDelegate>{
    
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *outagebtn,*svccallbtn;
    UIButton *downpolebtn,*polefirebtn,*debrisbtn,*Backbtn;
    UILabel *downpolelbl,*polefirelbl,*debrislbl;
    UIImageView *meterlogo;
    NSMutableArray *ReportPole_Array;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
}
@property(nonatomic,retain)NSString *Pole_Id;
@property(nonatomic,retain)NSString *Pole_Name;

@end
