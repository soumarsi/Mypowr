//
//  MMUsageBudgetauditViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 08/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import "MMUsageTreeViewController.h"
#import "V8HorizontalPickerView.h"

@interface MMUsageBudgetauditViewController : UIViewController<V8HorizontalPickerViewDataSource,V8HorizontalPickerViewDelegate,V8HorizontalPickerElementState>{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn;
    UIButton *footerbudgtbtn,*footerauditbtn;
    UIButton *startbutton;
    UIScrollView *MainScroll;
    UIImageView *plasmatvimg,*heaterimg;
    NSMutableArray *addarray;
    UIButton *profilebtn, *morebtn, *footerBackbtn;
}
@property (nonatomic,retain ) NSString *DollarIntLblStr;
@property (nonatomic,retain ) NSString *DollarFractionLblStr;
@property (nonatomic, strong) IBOutlet V8HorizontalPickerView *pickerView;
@property (nonatomic)BOOL networkStatus;

@end
