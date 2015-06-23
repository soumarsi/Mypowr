//
//  MMProfileViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 13/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMProfileViewController : UIViewController<UITextFieldDelegate>{
    
    UIView *MainView;
    UIScrollView *MainScroll;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UITextField *FullName,*lastname,*Email,*appartmentno,*address,*state,*zipcode,*country,*password;
    UIButton *Backbtn,*Savebtn;
    NSDictionary *json;
    NSUserDefaults *login_Defaults;
}
@property(nonatomic,retain)NSString *addresscoming;
@property(nonatomic,retain)NSString *defaultaddress;
@property(nonatomic,retain)NSString *checking;
@end
