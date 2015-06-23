//
//  MMSettingsViewController.h
//  MeterMaid
//
//  Created by Admin on 10/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
@interface MMSettingsViewController : UIViewController
{
    UIView *MainView;
    UILabel *SettingsheaderLbl1;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    
}


@end
