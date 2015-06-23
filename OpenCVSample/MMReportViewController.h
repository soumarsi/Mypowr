//
//  MMReportViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMReportViewController : UIViewController{
    
    
    UIView *MainView,*EmergencyView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *outagebtn,*svccallbtn;
    UIButton *insidebtn,*polebtn,*wirebtn,*partsbtn,*Backbtn;
    UILabel *insidelbl,*polelbl,*wirelbl,*partslbl,*Emergencylbl,*CallLbl;
    UIImageView *meterlogo;
    NSDictionary *dict;
    NSMutableArray *Report_Array;
}

@end
