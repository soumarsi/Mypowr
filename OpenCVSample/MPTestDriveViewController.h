//
//  MPTestDriveViewController.h
//  MyPower
//
//  Created by Admin on 08/09/14.
//  Copyright (c) 2014 esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MPTestDriveViewController : UIViewController<UITextFieldDelegate>
{
    UIView *MainView;
    UIButton *usagebtn,*reportbtn,*mapbtn,*settingbtn;
    UIButton *Signupbtn,*Signinbtn,*facebookbtn;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
}

@end
