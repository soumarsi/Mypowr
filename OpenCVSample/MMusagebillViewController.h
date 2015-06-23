//
//  MMusagebillViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import "MMUsageTreeViewController.h"

@interface MMusagebillViewController : UIViewController{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn;
    UIButton *Emailbtn,*Sharebillbtn,*paybtn;
}

@end
