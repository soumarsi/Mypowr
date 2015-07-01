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
#import "MMusagebillViewController.h"
#import "MMSvcViewController.h"
#import "MMUsageTreeViewController.h"

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
        
        Upperlogo = [[UIImageView alloc]initWithFrame:CGRectMake(6.0f, 25.0f, 44.0f, 60/2)];
        [Upperlogo setImage:[UIImage imageNamed:@"sideviewlogoimg"]];
        [SideView addSubview:Upperlogo];
        
        upperlogotext = [[UILabel alloc]initWithFrame:CGRectMake(50.0f, 6.0f, 180.0f, 20.0f)];
        [upperlogotext setBackgroundColor:[UIColor clearColor]];
        [upperlogotext setText:@"Lubbock Power & Light"];
        [upperlogotext setTextAlignment:NSTextAlignmentLeft];
        [upperlogotext setTextColor:[UIColor whiteColor]];
        [upperlogotext setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:12.0f]];
        [Upperlogo addSubview:upperlogotext];
        
        
        ///////..................////////////////.............../////////////////////
        
        
        //sideview button...................
        
        usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [usagebtn setFrame:CGRectMake(7.0f,75.0f, 30.0f, 18.0f)];
        [usagebtn setBackgroundImage:[UIImage imageNamed:@"usagebtn_side"] forState:UIControlStateNormal];
        [usagebtn setBackgroundImage:[UIImage imageNamed:@"usagebtn_side"] forState:UIControlStateHighlighted];
        //[usagebtn addTarget:self action:@selector(usage_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:usagebtn];
        
        
        
        budgetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [budgetbtn setFrame:CGRectMake(0.0f, 118.0f, 76/2, 59/2)];
        [budgetbtn setBackgroundImage:[UIImage imageNamed:@"sideviewBudgetimg"] forState:UIControlStateNormal];
        [budgetbtn setBackgroundImage:[UIImage imageNamed:@"sideviewBudgetimg"] forState:UIControlStateHighlighted];
        [budgetbtn addTarget:self action:@selector(budget_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:budgetbtn];
        
        
        billbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [billbtn setFrame:CGRectMake(0.0f, 178.0f, 76/2, 59/2)];
        [billbtn setBackgroundImage:[UIImage imageNamed:@"sideviewBillimg"] forState:UIControlStateNormal];
        [billbtn setBackgroundImage:[UIImage imageNamed:@"sideviewBillimg"] forState:UIControlStateHighlighted];
        [billbtn addTarget:self action:@selector(bill_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:billbtn];
        
        
        printbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [printbtn setFrame:CGRectMake(0.0f, 238.0f, 76/2, 59/2)];
        [printbtn setBackgroundImage:[UIImage imageNamed:@"sideviewPrintimg"] forState:UIControlStateNormal];
        [printbtn setBackgroundImage:[UIImage imageNamed:@"sideviewPrintimg"] forState:UIControlStateHighlighted];
        [printbtn addTarget:self action:@selector(print_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:printbtn];
        
        
        Callbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [Callbtn setFrame:CGRectMake(10.0f, 293.0f, 41/2, 48/2)];
        [Callbtn setBackgroundImage:[UIImage imageNamed:@"Callbtn_side"] forState:UIControlStateNormal];
        [Callbtn setBackgroundImage:[UIImage imageNamed:@"Callbtn_side"] forState:UIControlStateHighlighted];
        //[Callbtn addTarget:self action:@selector(Call_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:Callbtn];
        
        outagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [outagebtn setFrame:CGRectMake(0.0f, 353.0f, 76/2, 59/2)];
        [outagebtn setBackgroundImage:[UIImage imageNamed:@"sideviewOutageimg"] forState:UIControlStateNormal];
        [outagebtn setBackgroundImage:[UIImage imageNamed:@"sideviewOutageimg"] forState:UIControlStateHighlighted];
        [outagebtn addTarget:self action:@selector(Call_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:outagebtn];
        
        
        servicecallbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [servicecallbtn setFrame:CGRectMake(0.0f, 413.0f, 76/2, 59/2)];
        [servicecallbtn setBackgroundImage:[UIImage imageNamed:@"sideviewServicecallimg"] forState:UIControlStateNormal];
        [servicecallbtn setBackgroundImage:[UIImage imageNamed:@"sideviewServicecallimg"] forState:UIControlStateHighlighted];
        [servicecallbtn addTarget:self action:@selector(servicecall_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:servicecallbtn];
        
        
        mapbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [mapbtn setFrame:CGRectMake(10.0f, 473.0f, 44/2, 48/2)];
        [mapbtn setBackgroundImage:[UIImage imageNamed:@"Mapbtn_side"] forState:UIControlStateNormal];
        [mapbtn setBackgroundImage:[UIImage imageNamed:@"Mapbtn_side"] forState:UIControlStateHighlighted];
        [mapbtn addTarget:self action:@selector(Map_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:mapbtn];
        
        
        
        
        
        settingsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [settingsbtn setFrame:CGRectMake(10.0f, 523.0f, 51/2, 59/2)];
        [settingsbtn setBackgroundImage:[UIImage imageNamed:@"settingsbtn"] forState:UIControlStateNormal];
        [settingsbtn setBackgroundImage:[UIImage imageNamed:@"settingsbtn"] forState:UIControlStateHighlighted];
        [settingsbtn addTarget:self action:@selector(Settings_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:settingsbtn];
        
        
        ///////////.............................///////////////////////.........................//////////
        
        //sideview text........
        
        Usagelabl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 68.0f, 220.0f, 34.0f)];
        [Usagelabl setText:@"USAGE"];
        [Usagelabl setTextAlignment:NSTextAlignmentLeft];
        [Usagelabl setTextColor:[UIColor whiteColor]];
        [Usagelabl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
        [self addSubview:Usagelabl];
        
        //        UITapGestureRecognizer *usagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usage_sidebtn:)];
        //       [Usagelabl addGestureRecognizer:usagetap];
        //        Usagelabl.userInteractionEnabled = YES;
        
        
        
        budgetlbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 115.0f, 220.0f, 34.0f)];
        [budgetlbl setText:@"Budget"];
        [budgetlbl setTextAlignment:NSTextAlignmentLeft];
        [budgetlbl setTextColor:[UIColor whiteColor]];
        [budgetlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
        budgetlbl.numberOfLines = 2;
        [self addSubview:budgetlbl];
        
        UITapGestureRecognizer *budgetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(budget_sidebtn:)];
        [budgetlbl addGestureRecognizer:budgetap];
        budgetlbl.userInteractionEnabled = YES;
        
        
        billlbl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 176.0f, 220.0f, 34.0f)];
        [billlbl setText:@"Bill"];
        [billlbl setTextAlignment:NSTextAlignmentLeft];
        [billlbl setTextColor:[UIColor whiteColor]];
        [billlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
        [self addSubview:billlbl];
        
        UITapGestureRecognizer *billtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bill_sidebtn:)];
        [billlbl addGestureRecognizer:billtap];
        billlbl.userInteractionEnabled = YES;
        
        
        printlbl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 236.0f, 220.0f, 34.0f)];
        [printlbl setText:@"Print"];
        [printlbl setTextAlignment:NSTextAlignmentLeft];
        [printlbl setTextColor:[UIColor whiteColor]];
        [printlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
        [self addSubview:printlbl];
        
        UITapGestureRecognizer *printtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(print_sidebtn:)];
        [printlbl addGestureRecognizer:printtap];
        printlbl.userInteractionEnabled = YES;
        
        
        
        Reportlbl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 287.0f, 200.0f, 34.0f)];
        [Reportlbl setText:@"REPORT"];
        [Reportlbl setTextAlignment:NSTextAlignmentLeft];
        [Reportlbl setTextColor:[UIColor whiteColor]];
        [Reportlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
        [self addSubview:Reportlbl];
        
        //        UITapGestureRecognizer *reporttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Call_sidebtn:)];
        //        [Reportlbl addGestureRecognizer:reporttap];
        //        Reportlbl.userInteractionEnabled = YES;
        
        outagelbl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 350.0f, 220.0f, 34.0f)];
        [outagelbl setText:@"Outage"];
        [outagelbl setTextAlignment:NSTextAlignmentLeft];
        [outagelbl setTextColor:[UIColor whiteColor]];
        [outagelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
        outagelbl.numberOfLines = 2;
        [self addSubview:outagelbl];
        
        UITapGestureRecognizer *outagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Call_sidebtn:)];
        [outagelbl addGestureRecognizer:outagetap];
        outagelbl.userInteractionEnabled = YES;
        
        
        servicecallbl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 410.0f, 220.0f, 34.0f)];
        [servicecallbl setText:@"Service Call"];
        [servicecallbl setTextAlignment:NSTextAlignmentLeft];
        [servicecallbl setTextColor:[UIColor whiteColor]];
        [servicecallbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
        servicecallbl.numberOfLines = 2;
        [self addSubview:servicecallbl];
        
        UITapGestureRecognizer *servicecalltap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(servicecall_sidebtn:)];
        [servicecallbl addGestureRecognizer:servicecalltap];
        servicecallbl.userInteractionEnabled = YES;
        
        
        maplbl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 470.0f, 200.0f, 34.0f)];
        [maplbl setText:@"MAP"];
        [maplbl setTextAlignment:NSTextAlignmentLeft];
        [maplbl setTextColor:[UIColor whiteColor]];
        [maplbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16.0f]];
        [self addSubview:maplbl];
        
        UITapGestureRecognizer *maptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Map_sidebtn:)];
        [maplbl addGestureRecognizer:maptap];
        maplbl.userInteractionEnabled = YES;
        
        
        
        
        
        
        //        UITapGestureRecognizer *outagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Outage_sidebtn:)];
        //        [outagelbl addGestureRecognizer:outagetap];
        //        outagelbl.userInteractionEnabled = YES;
        
        settingslbl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 520.0f, 200.0f, 34.0f)];
        [settingslbl setText:@"SETTINGS"];
        [settingslbl setTextAlignment:NSTextAlignmentLeft];
        [settingslbl setTextColor:[UIColor whiteColor]];
        [settingslbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
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

//outage buttonfunction..................

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

//budget button function......

-(void)budget_sidebtn:(UIButton *)sender{
    
    MMUsageBudgetViewController *myview = [[MMUsageBudgetViewController alloc]init];
    
    MMAppDelegate *mydel=(MMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [mydel.navigationController pushViewController:myview animated:NO];
    
}

//bill button function.....

-(void)bill_sidebtn:(UIButton *)sender{
    
    MMusagebillViewController *myview = [[MMusagebillViewController alloc]init];
    
    MMAppDelegate *mydel=(MMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [mydel.navigationController pushViewController:myview animated:NO];
    
}

//servicecall button function.....

-(void)servicecall_sidebtn:(UIButton *)sender{
    
    MMSvcViewController *myview = [[MMSvcViewController alloc]init];
    
    MMAppDelegate *mydel=(MMAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [mydel.navigationController pushViewController:myview animated:NO];
    
}

//print button function....

-(void)print_sidebtn:(UIButton *)sender{
    
    MMUsageTreeViewController *myview = [[MMUsageTreeViewController alloc]init];
    
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
