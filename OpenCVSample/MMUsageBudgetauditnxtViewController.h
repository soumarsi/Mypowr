//
//  MMUsageBudgetauditnxtViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 09/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import "V8HorizontalPickerView.h"
#import "V8HorizontalPickerViewProtocol.h"
#import "MMUsageTreeViewController.h"
@class V8HorizontalPickerView;
@interface MMUsageBudgetauditnxtViewController : UIViewController<V8HorizontalPickerViewDelegate, V8HorizontalPickerViewDataSource>
{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *budgetbtn,*billbtn,*usagebtn,*phillbtn;
    UIButton *footerbudgtbtn,*footerauditbtn,*footercontinuebtn;
    NSMutableArray *watarray,*watarraylbl,*btnArrayNew;
    int z;
    UIButton *watvaluebtn;
    UIScrollView *MainScroll;
    UILabel *watvaluelbl;
}

@property (nonatomic,retain ) NSString *DollarIntLblStr;
@property (nonatomic,retain ) NSString *DollarFractionLblStr;
@property (nonatomic,retain) NSString *ImageUrlFromPreviuosPage;
@property (nonatomic) int SelectedDeviceID;
@property (nonatomic,retain) NSString *DeviceTitle;
@property (nonatomic, strong) IBOutlet V8HorizontalPickerView *pickerView;
@end
