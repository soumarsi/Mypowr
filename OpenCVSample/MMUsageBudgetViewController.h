//
//  MMUsageBudgetViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"

@interface MMUsageBudgetViewController : UIViewController<UITextFieldDelegate>{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn;
    UIButton *footerbudgtbtn,*footerauditbtn,*footersetbudgt,*footerupdtebtn;
    UIView *BlackView;
    UIView *UsBackView8;
    UIView *backview;
    UITextField *budget,*metertxt;
    NSDictionary *newdict;
    float budgtstr;
    NSString *budgettime;
    NSMutableArray *Reading_Listarray;
    NSDictionary *Reading_json;
}
////////////---for reading


@property(nonatomic,strong) UIImage *cominimg;
@property(nonatomic,strong) NSMutableDictionary *dataary;
@property(nonatomic) BOOL yesfrm;
@property (nonatomic, strong) UIView *setViewFooter;
@property (nonatomic,retain) UIButton *setBudgetSave;
@property (nonatomic,retain) UIButton *setBudgetBack;
@property (nonatomic, retain) UIVisualEffectView *bluredView;
@property(nonatomic,strong) NSMutableArray *readingVal;
///////-------- for reading

@end
