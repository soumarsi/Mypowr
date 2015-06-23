//
//  MMSigninViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMSigninViewController : UIViewController<UITextFieldDelegate>{
    
    UIView *MainView;
    UITextField *Email,*passcode;
    UIButton *signinbtn,*Backbtn;
    NSDictionary *jsondict;
    NSUserDefaults *login_Defaults;
}

@end
