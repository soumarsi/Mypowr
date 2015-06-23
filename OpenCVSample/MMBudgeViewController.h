//
//  MMBudgeViewController.h
//  MeterMaid
//
//  Created by Iphone_1 on 09/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMBudgeViewController : UIViewController
@property(nonatomic,retain) NSString *DollarIntLblStr;
@property(nonatomic,retain) NSString *DollarFractionLblStr;

@property(nonatomic) int SelectedProductTag;
@property (nonatomic ,retain) NSString *WattString;
@property (nonatomic ,retain) NSString *DeviceTitle;
@property(nonatomic,retain) NSString *SelectedImageUrlStrFromPreviousPage;

@end
