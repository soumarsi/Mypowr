//
//  MMSvcscheduleViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 21/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import "V8HorizontalPickerView.h"
#import "V8HorizontalPickerViewProtocol.h"
@class V8HorizontalPickerView;
@interface MMSvcscheduleViewController : UIViewController<UITextViewDelegate,V8HorizontalPickerViewDelegate, V8HorizontalPickerViewDataSource>{
    
    UIView *MainView;
    UILabel *HeaderLbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *outagebtn,*svccallbtn,*Backbtn,*schedulebtn;
    UITextView *CoemtText;
    UIImageView *selectedView;
    UIScrollView *timescroll,*datescroll;
    NSMutableArray *timearray;
    NSMutableArray *timeformatarray;
    UIButton *Timebutton;
    UIButton *CalendarButton;
    UILabel *Timeformatlbl, *CalendarLbl;
    UIButton *targetBtn;
    NSMutableArray *btnArrayNew;
    NSMutableArray *CalendarButtonArray;
    UILabel *Monthlbl;
    NSString*month1;
    int z;
    NSMutableArray *Datearray;
    NSString *datestring;
    NSString *Str;
    NSString *year1;
    NSString *timestring;
    
}

@property(nonatomic,retain)NSString *Cat_id;
@property(nonatomic,retain)NSString *SubCat_id;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property(nonatomic,strong)NSMutableArray *timeformatarray;
@property (nonatomic, strong) IBOutlet V8HorizontalPickerView *pickerView;
@property (nonatomic, strong) IBOutlet V8HorizontalPickerView *pickerView1;
@property(nonatomic,retain) NSMutableArray *ArrayOfMonthDates;
@property(nonatomic,retain)NSString *svcstring;

@end

/*
 


 */


