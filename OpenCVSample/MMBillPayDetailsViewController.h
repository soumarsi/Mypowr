//
//  MMBillPayDetailsViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 20/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMBillPayDetailsViewController : UIViewController{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn;
    UIButton *Emailbtn,*Sharebillbtn,*paybtn;
    UIScrollView *DetailsScroll;
    
    NSMutableArray *DescriptionArray,*UsageArray,*RateArray,*ChargeArray,*DescriptionArray2,*RateArray2,*ChargeArray2;
    UILabel *DescriptionLbl,*UsageLbl,*RateLbl,*ChargeLbl;
    UILabel *DescriptionDetailsLbl,*UsageDetailsLbl,*RateDetailsLbl,*ChargeDetailsLbl,*DescriptionDeatlslbl2,*RateDetailsLbl2,*ChargeDetailsLbl2;
    
}


@end
