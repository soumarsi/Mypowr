//
//  MMSYNCViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 13/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMSYNCViewController : UIViewController{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *Backbtn;
    UILabel *Fullnamelbl,*UserEmail,*synclbl;
    UIButton *Edit_btn;

}

@end
