//
//  MMUsageTreeViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 10/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMUsageTreeViewController : UIViewController{
    
    UIView *MainView,*GraphView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn,*graphBtn;
    UIButton *footertreebutton,*footerco2btn,*footercheckbtn,*footerBackbtn;
    UILabel *co2lbl,*monthkwhlbl,*monthkwhlbl2,*PercentLbl;
    UIView *monthkwhview;
}

@end
