//
//  MMusagesharebillViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import <MessageUI/MessageUI.h>

@interface MMusagesharebillViewController : UIViewController<UITextFieldDelegate,MFMessageComposeViewControllerDelegate>{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn,*Backbtn,*Savebtn;
    UITextField *mobileno;
    
}

@end
