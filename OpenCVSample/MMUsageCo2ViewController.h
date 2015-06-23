//
//  MMUsageCo2ViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 11/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMUsageCo2ViewController : UIViewController{
    
    UIView *MainView;
    UILabel *HeaderLbl,*PercentLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn,*graphBtn;
    UIButton *footertreebutton,*footerco2btn,*footercheckbtn,*footerBackbtn;
    UILabel *co2lbl,*monthkwhlbl,*monthkwhlbl2;
    UIView *monthkwhview;
    UIView *BlackView,*GraphView;
    UIButton *CrossButton;
    UIView *WhiteView;
}

@end
