//
//  MMUsageEmailViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import "MMUsageTreeViewController.h"

@interface MMUsageEmailViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn,*Backbtn,*Savebtn;
    UIButton *paymethod,*Sharebillbtn,*cancelbtn;
    UITextField *email;
    UITextView *textviw;
    UIButton *emailbtn,*textbtn,*crossbtn;
    UIView *BlackView,*backview;
    NSString *emailstring,*textstring;
    UILabel *placelabl;
}

@end
