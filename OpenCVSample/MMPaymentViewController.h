//
//  MMPaymentViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 06/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMPaymentViewController : UIViewController<UITextFieldDelegate>{
    
    UIView *MainView;
    UIScrollView *MainScroll;
    UILabel *HeaderLbl,*HeaderTextlbl;
    UIButton *Menubtn,*Backbtn,*Savebtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIImageView *paymentimg,*lockimg;
    UITextField *FullName,*lastname,*cardnumber,*expiratindate,*cvv,*address,*city,*state,*zipcode,*country;
}

@end
