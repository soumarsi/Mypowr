//
//  MMEditSyncViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 13/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMEditSyncViewController : UIViewController<UITextFieldDelegate>{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *Backbtn,*resendbtn;
    UILabel *Fullnamelbl,*UserEmail,*synclbl,*phonelbl;
    UIButton *Edit_btn;
    UITextField *FullName,*lastname,*Email,*phone;
}

@end
