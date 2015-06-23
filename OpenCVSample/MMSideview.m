//
//  MMSideview.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 10/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMSideview.h"
#import "MMmapViewController.h"
#import "MMSettingsViewController.h"
#import "MMReportViewController.h"
#import "MMAppDelegate.h"
#import "MMUsageBudgetViewController.h"

@implementation MMSideview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        

        
        //sidebackground image...............
        
        SideView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 280.0f, 568.0f)];
        [SideView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Sidebackimg"]]];
        [self addSubview:SideView];
        
        //Upper logo and text...........
        
        Upperlogo = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 17.0f, 320.0f, 78/2)];
        [Upperlogo setImage:[UIImage imageNamed:@"sidelogo"]];
        [SideView addSubview:Upperlogo];
        
        upperlogotext = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 6.0f, 180.0f, 25.0f)];
        [upperlogotext setText:@"Lubbock Power & Light"];
        [upperlogotext setTextAlignment:NSTextAlignmentLeft];
        [upperlogotext setTextColor:[UIColor whiteColor]];
        [upperlogotext setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:15.0f]];
        [Upperlogo addSubview:upperlogotext];
  
        
        ///////..................////////////////.............../////////////////////
        
        
        //sideview button...................
        
        usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [usagebtn setFrame:CGRectMake(7.0f, 83.0f, 45.0f, 28.0f)];
        [usagebtn setBackgroundImage:[UIImage imageNamed:@"usagebtn_side"] forState:UIControlStateNormal];
        [usagebtn setBackgroundImage:[UIImage imageNamed:@"usagebtn_side"] forState:UIControlStateHighlighted];
        [usagebtn addTarget:self action:@selector(usage_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:usagebtn];
        
        
        meterbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [meterbtn setFrame:CGRectMake(0.0f, 145.0f, 93/2, 69/2)];
        [meterbtn setBackgroundImage:[UIImage imageNamed:@"Meterimg_side"] forState:UIControlStateNormal];
        [meterbtn setBackgroundImage:[UIImage imageNamed:@"Meterimg_side"] forState:UIControlStateHighlighted];
        //[meterbtn addTarget:self action:@selector(Meter_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:meterbtn];
        
        
        budgetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [budgetbtn setFrame:CGRectMake(0.0f, 210.0f, 94/2, 69/2)];
        [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetbtn_side"] forState:UIControlStateNormal];
        [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetbtn_side"] forState:UIControlStateHighlighted];
        //[budgetbtn addTarget:self action:@selector(budget_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:budgetbtn];
        
        
        Callbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Callbtn setFrame:CGRectMake(15.0f, 280.0f, 51/2, 69/2)];
        [Callbtn setBackgroundImage:[UIImage imageNamed:@"Callbtn_side"] forState:UIControlStateNormal];
        [Callbtn setBackgroundImage:[UIImage imageNamed:@"Callbtn_side"] forState:UIControlStateHighlighted];
        [Callbtn addTarget:self action:@selector(Call_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Callbtn];
        
        
        
        mapbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mapbtn setFrame:CGRectMake(15.0f, 345.0f, 58/2, 63/2)];
        [mapbtn setBackgroundImage:[UIImage imageNamed:@"Mapbtn_side"] forState:UIControlStateNormal];
        [mapbtn setBackgroundImage:[UIImage imageNamed:@"Mapbtn_side"] forState:UIControlStateHighlighted];
        [mapbtn addTarget:self action:@selector(Map_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mapbtn];
        
        
        outagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [outagebtn setFrame:CGRectMake(0.0f, 410.0f, 96/2, 69/2)];
        [outagebtn setBackgroundImage:[UIImage imageNamed:@"Outagebtn_side"] forState:UIControlStateNormal];
        [outagebtn setBackgroundImage:[UIImage imageNamed:@"Outagebtn_side"] forState:UIControlStateHighlighted];
        //[outagebtn addTarget:self action:@selector(Outage_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:outagebtn];
        
        
        settingsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [settingsbtn setFrame:CGRectMake(15.0f, 480.0f, 68/2, 55/2)];
        [settingsbtn setBackgroundImage:[UIImage imageNamed:@"Settingsbtn_side"] forState:UIControlStateNormal];
        [settingsbtn setBackgroundImage:[UIImage imageNamed:@"Settingsbtn_side"] forState:UIControlStateHighlighted];
        [settingsbtn addTarget:self action:@selector(Settings_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:settingsbtn];
        
    
        ///////////.............................///////////////////////.........................//////////
        
        //sideview text........
        
        Usagelabl = [[UILabel alloc]initWithFrame:CGRectMake(60.0f, 80.0f, 200.0f, 34.0f)];
        [Usagelabl setText:@"USAGE"];
        [Usagelabl setTextAlignment:NSTextAlignmentLeft];
        [Usagelabl setTextColor:[UIColor whiteColor]];
        [Usagelabl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:26]];
        [self addSubview:Usagelabl];
        
        UITapGestureRecognizer *usagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usage_sidebtn:)];
       [Usagelabl addGestureRecognizer:usagetap];
        Usagelabl.userInteractionEnabled = YES;
        
        
        meterlbl = [[UILabel alloc]initWithFrame:CGRectMake(55.0f, 145.0f, 220.0f, 34.0f)];
        [meterlbl setText:@"It's time to update your meter reading. Last read . moments ago"];
        [meterlbl setTextAlignment:NSTextAlignmentLeft];
        [meterlbl setTextColor:[UIColor whiteColor]];
        [meterlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:11.2f]];
        meterlbl.numberOfLines = 2;
        [self addSubview:meterlbl];
        
        //        UITapGestureRecognizer *metertap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Meter_sidebtn:)];
        //        [meterlbl addGestureRecognizer:metertap];
        //        meterlbl.userInteractionEnabled = YES;
        
        
        budgetlbl = [[UILabel alloc]initWithFrame:CGRectMake(55.0f, 210.0f, 220.0f, 34.0f)];
        [budgetlbl setText:@"You are 12% over budget.\n Last read . moments ago"];
        [budgetlbl setTextAlignment:NSTextAlignmentLeft];
        [budgetlbl setTextColor:[UIColor whiteColor]];
        [budgetlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:13.2f]];
        budgetlbl.numberOfLines = 2;
        [self addSubview:budgetlbl];
        
        //        UITapGestureRecognizer *budgetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(budget_sidebtn:)];
        //        [budgetlbl addGestureRecognizer:budgetap];
        //        budgetlbl.userInteractionEnabled = YES;
        
        
        Reportlbl = [[UILabel alloc]initWithFrame:CGRectMake(55.0f, 280.0f, 200.0f, 34.0f)];
        [Reportlbl setText:@"REPORT"];
        [Reportlbl setTextAlignment:NSTextAlignmentLeft];
        [Reportlbl setTextColor:[UIColor whiteColor]];
        [Reportlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:24.0f]];
        [self addSubview:Reportlbl];
        
        UITapGestureRecognizer *reporttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Call_sidebtn:)];
        [Reportlbl addGestureRecognizer:reporttap];
        Reportlbl.userInteractionEnabled = YES;
        
        
        maplbl = [[UILabel alloc]initWithFrame:CGRectMake(55.0f, 345.0f, 200.0f, 34.0f)];
        [maplbl setText:@"MAP"];
        [maplbl setTextAlignment:NSTextAlignmentLeft];
        [maplbl setTextColor:[UIColor whiteColor]];
        [maplbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:24.0f]];
        [self addSubview:maplbl];
        
        UITapGestureRecognizer *maptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Map_sidebtn:)];
        [maplbl addGestureRecognizer:maptap];
        maplbl.userInteractionEnabled = YES;
        
        
        
        
        outagelbl = [[UILabel alloc]initWithFrame:CGRectMake(55.0f, 410.0f, 220.0f, 34.0f)];
        [outagelbl setText:@"An outage has been detected near you.\n Today . 12:35PM"];
        [outagelbl setTextAlignment:NSTextAlignmentLeft];
        [outagelbl setTextColor:[UIColor whiteColor]];
        [outagelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:11.2f]];
        outagelbl.numberOfLines = 2;
        [self addSubview:outagelbl];
        
        //        UITapGestureRecognizer *outagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Outage_sidebtn:)];
        //        [outagelbl addGestureRecognizer:outagetap];
        //        outagelbl.userInteractionEnabled = YES;
        
        settingslbl = [[UILabel alloc]initWithFrame:CGRectMake(55.0f, 476.0f, 200.0f, 34.0f)];
        [settingslbl setText:@"SETTINGS"];
        [settingslbl setTextAlignment:NSTextAlignmentLeft];
        [settingslbl setTextColor:[UIColor whiteColor]];
        [settingslbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:24.0f]];
        [self addSubview:settingslbl];
        
        UITapGestureRecognizer *settingstap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Settings_sidebtn:)];
        [settingslbl addGestureRecognizer:settingstap];
        settingslbl.userInteractionEnabled = YES;
        
        // Initialization code
    }
    return self;
}

//map button function.....................

-(void)Map_sidebtn:(UIButton *)sender{
    
    
    MMmapViewController *myview = [[MMmapViewController alloc]init];
    
    MMAppDelegate *mydel=(MMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [mydel.navigationController pushViewController:myview animated:NO];
}

//settings button function....................

-(void)Settings_sidebtn:(UIButton *)sender{
    
    MMSettingsViewController *myview = [[MMSettingsViewController alloc]init];
    
    MMAppDelegate *mydel=(MMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [mydel.navigationController pushViewController:myview animated:NO];
}

//report buttonfunction..................

-(void)Call_sidebtn:(UIButton *)sender{
    
    MMReportViewController *myview = [[MMReportViewController alloc]init];
    
    MMAppDelegate *mydel=(MMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [mydel.navigationController pushViewController:myview animated:NO];
}

//usage button function.......

-(void)usage_sidebtn:(UIButton *)sender{
    
    MMUsageBudgetViewController *myview = [[MMUsageBudgetViewController alloc]init];
    
    MMAppDelegate *mydel=(MMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [mydel.navigationController pushViewController:myview animated:NO];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
