//
//  MMUsagePayViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMUsagePayViewController : UIViewController<UITextFieldDelegate>{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn,*Backbtn,*Savebtn;
    UIButton *paymethod,*Sharebillbtn,*cancelbtn,*paybillbutton;
    UILabel *UserName,*UserVisa,*UserAcct;
}

@end
