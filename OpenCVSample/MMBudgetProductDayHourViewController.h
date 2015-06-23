//
//  MMBudgetProductDayHourViewController.h
//  MeterMaid
//
//  Created by Iphone_1 on 09/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MMBudgetProductDayHourViewController : UIViewController
{
    UIImageView *RightImageView;
    CGRect PreFrame;
}
@property(nonatomic,retain) NSString *DollarIntLblStr;
@property(nonatomic,retain) NSString *DollarFractionLblStr;
@property(nonatomic,retain) NSString *DollarBracketStr;
@property(nonatomic,retain) NSString *CurrDollarIntLblStr;
@property(nonatomic,retain) NSString *CurrDollarFractionLblStr;
@property(nonatomic,retain) NSString *NewDollarIntLblStr;
@property(nonatomic,retain) NSString *NewDollarFractionLblStr;
// to accept data from previous page
@property(nonatomic,retain) NSString *NewUsageStrByDay;
@property(nonatomic,retain) NSString *CurrUsageStrByDay;
@property (nonatomic,retain ) NSString * SelectedImageUrl;
@property (nonatomic,retain ) NSString *DeviceTitle;
@property (nonatomic,retain ) NSString *WattString;

@end
