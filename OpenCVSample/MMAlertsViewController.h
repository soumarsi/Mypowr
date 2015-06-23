//
//  MMAlertsViewController.h
//  MeterMaid
//
//  Created by Admin on 16/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMAlertsViewController : UIViewController<UIScrollViewDelegate>
{
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn,*Backbtn,*Savebtn;
    UIScrollView *MainScroll;
    UISwitch *Notification_Switch,*Personalization_Switch,*Paymentmethods_Switch,*Sync_Switch,*Dealy_Switch;
}

@end
