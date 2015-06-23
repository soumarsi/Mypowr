//
//  MMHomeViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import "MMUsageTreeViewController.h"
@interface MMHomeViewController : UIViewController{
    
    UIView *MainView;
    UIButton *usagebtn,*reportbtn,*mapbtn,*settingbtn;
    UIButton *signoutbtn;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UILabel *fullnamelbl;
}

@end
