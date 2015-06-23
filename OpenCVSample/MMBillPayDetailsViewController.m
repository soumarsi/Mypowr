//
//  MMBillPayDetailsViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 20/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMBillPayDetailsViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMUsageEmailViewController.h"
#import "MMUsagePayViewController.h"
#import "MMusagebillViewController.h"
#import "MMUsageTreeViewController.h"

@interface MMBillPayDetailsViewController ()

@end

@implementation MMBillPayDetailsViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"MMBillPayDetailsViewController");
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];
    
    //backgroundView...................
    
    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [self.view addSubview:MainView];
    
    //menu button............
    
    Menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Menubtn setFrame:CGRectMake(0.0f, 30.0f, 66/2,40/2)];
    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateNormal];
    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateHighlighted];
    [Menubtn addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Menubtn];
    
    UIView *menuview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, 43.0f, 40.0f)];
    [menuview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:menuview];
    
    UITapGestureRecognizer *menutap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(menu:)];
    [menuview addGestureRecognizer:menutap];
    menuview.userInteractionEnabled = YES;
    
    //HeaderLabel.......................
    
    HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(85.0f, 20.0f,150.0f, 40.0f)];
    [HeaderLbl setBackgroundColor:[UIColor clearColor]];
    [HeaderLbl setText:@"U S A G E"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [MainView addSubview:HeaderLbl];
    
    //budget button ..........
    
    budgetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [budgetbtn setFrame:CGRectMake(37.0f, 80.0f, 90/2, 83/2)];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateNormal];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateHighlighted];
    [budgetbtn addTarget:self action:@selector(budget:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:budgetbtn];
    
    
    //bill button ..........
    
    billbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billbtn setFrame:CGRectMake(153.0f, 82.0f, 50/2, 79/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateHighlighted];
    //[billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(251, 89.0f, 74/2, 65/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    //phill button ..........
    
//    phillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [phillbtn setFrame:CGRectMake(255, 82.0f, 56/2, 78/2)];
//    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateNormal];
//    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateHighlighted];
//    //[phillbtn addTarget:self action:@selector(phill:) forControlEvents:UIControlEventTouchUpInside];
//    [MainView addSubview:phillbtn];
    
    
    UIImageView *divideimg = [[UIImageView alloc]initWithFrame:CGRectMake(75.0f, 200.0f, 341/2, 0.5f)];
    [divideimg setImage:[UIImage imageNamed:@"divideimg"]];
    [MainView addSubview:divideimg];
    
    //============////////================
    
    UILabel *dollerimg = [[UILabel alloc]initWithFrame:CGRectMake(75.0f, 160.0f, 30.0f, 30.0f)];
    [dollerimg setText:@"$"];
    [dollerimg setTextAlignment:NSTextAlignmentLeft];
    [dollerimg setTextColor:[UIColor whiteColor]];
    [dollerimg setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20.0f]];
    [MainView addSubview:dollerimg];
    
    UILabel *amoutlbl = [[UILabel alloc]initWithFrame:CGRectMake(87.0f, 150.0f, 100.0f, 60.0f)];
    [amoutlbl setText:@"92.01"];
    [amoutlbl setTextAlignment:NSTextAlignmentLeft];
    [amoutlbl setTextColor:[UIColor whiteColor]];
    [amoutlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:40]];
    [MainView addSubview:amoutlbl];
    
    UILabel *datelbl = [[UILabel alloc]initWithFrame:CGRectMake(195.0f, 150.0f, 80.0f, 60.0f)];
    [datelbl setText:@"J u l y Total"];
    datelbl.numberOfLines = 2;
    [datelbl setTextAlignment:NSTextAlignmentLeft];
    [datelbl setTextColor:[UIColor whiteColor]];
    [datelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [MainView addSubview:datelbl];
    
    //===========////=======//========
    
    
    UILabel *dollerimg1 = [[UILabel alloc]initWithFrame:CGRectMake(65.0f, 205.0f, 30.0f, 40.0f)];
    [dollerimg1 setText:@"$"];
    [dollerimg1 setTextAlignment:NSTextAlignmentLeft];
    [dollerimg1 setTextColor:[UIColor whiteColor]];
    [dollerimg1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20.0f]];
    [MainView addSubview:dollerimg1];
    
    UILabel *amoutlbl1 = [[UILabel alloc]initWithFrame:CGRectMake(77.0f, 200.0f, 120.0f, 60.0f)];
    [amoutlbl1 setText:@"178.73"];
    [amoutlbl1 setTextAlignment:NSTextAlignmentLeft];
    [amoutlbl1 setTextColor:[UIColor whiteColor]];
    [amoutlbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:38.0f]];
    [MainView addSubview:amoutlbl1];
    
    UILabel *datelbl1 = [[UILabel alloc]initWithFrame:CGRectMake(205.0f, 200.0f, 80.0f, 60.0f)];
    [datelbl1 setText:@"Grand Total"];
    datelbl1.numberOfLines = 2;
    [datelbl1 setTextAlignment:NSTextAlignmentLeft];
    [datelbl1 setTextColor:[UIColor whiteColor]];
    [datelbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [MainView addSubview:datelbl1];
    
    ///-=========/////////========
    
    //details view..........
    
    UIView *detailsView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 260.0f, 320.0f, 265.0f)];
    [detailsView setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:detailsView];
    
    
    //scrollview................
    DetailsScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 265.0f)];
    DetailsScroll.userInteractionEnabled=YES;
    DetailsScroll.scrollEnabled=YES;
    DetailsScroll.showsVerticalScrollIndicator=YES;
    DetailsScroll.contentSize=CGSizeMake(300.0f, 320.0f);
    [detailsView addSubview:DetailsScroll];
    
    
    DescriptionLbl = [[UILabel alloc]initWithFrame:CGRectMake(3.0f, 0.0f, 100.0f, 20.0f)];
    [DescriptionLbl setText:@"DESCRIPTION"];
    [DescriptionLbl setTextAlignment:NSTextAlignmentLeft];
    [DescriptionLbl setTextColor:[UIColor whiteColor]];
    [DescriptionLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
    [DetailsScroll addSubview:DescriptionLbl];
    
    UsageLbl = [[UILabel alloc]initWithFrame:CGRectMake(160.0f, 0.0f, 80.0f, 20.0f)];
    [UsageLbl setText:@"USAGE"];
    [UsageLbl setTextAlignment:NSTextAlignmentLeft];
    [UsageLbl setTextColor:[UIColor whiteColor]];
    [UsageLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
    [DetailsScroll addSubview:UsageLbl];
    
    
    RateLbl = [[UILabel alloc]initWithFrame:CGRectMake(218.0f, 0.0f, 70.0f, 20.0f)];
    [RateLbl setText:@"RATE"];
    [RateLbl setTextAlignment:NSTextAlignmentLeft];
    [RateLbl setTextColor:[UIColor whiteColor]];
    [RateLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
    [DetailsScroll addSubview:RateLbl];
    
    ChargeLbl = [[UILabel alloc]initWithFrame:CGRectMake(260.0f, 0.0f, 80.0f, 20.0f)];
    [ChargeLbl setText:@"CHARGE"];
    [ChargeLbl setTextAlignment:NSTextAlignmentLeft];
    [ChargeLbl setTextColor:[UIColor whiteColor]];
    [ChargeLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
    [DetailsScroll addSubview:ChargeLbl];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, 320.0f, 0.5f)];
    [line setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"lineimg"]]];
    [DetailsScroll addSubview:line];
    
    DescriptionArray = [[NSMutableArray alloc]init];
    UsageArray = [[NSMutableArray alloc]init];
    RateArray = [[NSMutableArray alloc]init];
    ChargeArray = [[NSMutableArray alloc]init];
    DescriptionArray2 = [[NSMutableArray alloc]init];
    RateArray2 = [[NSMutableArray alloc]init];
    ChargeArray2 = [[NSMutableArray alloc]init];
    
    
    
    DescriptionArray = [NSMutableArray arrayWithObjects:@"Service & Facility",@"Non-Summer",@"Trans Cst Adj",@"Elec Commodity Adj",@"Demand Side Mgmt Cst",@"Purch Cap Cst Adj",@"Renew Energy Std Adj",@"GRSA", nil];
    
    UsageArray = [NSMutableArray arrayWithObjects:@"808kWh",@"808kWh",@"808kWh",@"808kWh",@"808kWh", nil];
    
    RateArray = [NSMutableArray arrayWithObjects:@"4.604c",@"0.106c",@"3.806c",@"0.28c",@"0.638c", nil];
    
    ChargeArray = [NSMutableArray arrayWithObjects:@"$6.75",@"$37.20",@"$0.86",@"$30.75",@"$2.26",@"$5.16",@"$0.57",@"$2.68", nil];
    
    DescriptionArray2 = [NSMutableArray arrayWithObjects:@"Franchise",@"Sales Tax",@"June Past Due",@"Late Fee Penalty", nil];
    
    RateArray2 = [NSMutableArray arrayWithObjects:@"3.00%",@"3.17%", nil];
    
    ChargeArray2 = [NSMutableArray arrayWithObjects:@"$2.59",@"$3.19",@"$81.72",@"$5.00", nil];
    
    int y = 23.0f;
    
    for (int j = 0; j<[DescriptionArray count]; j++) {
    
        DescriptionDetailsLbl = [[UILabel alloc]initWithFrame:CGRectMake(3.0f, y, 140.0f, 15.0f)];
        [DescriptionDetailsLbl setTextAlignment:NSTextAlignmentLeft];
        [DescriptionDetailsLbl setText:[DescriptionArray objectAtIndex:j]];
        
        if (j % 2) {
            
            [DescriptionDetailsLbl setTextColor:[UIColor colorWithRed:(202.0f/255.0f) green:(216.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0f]];
            
        }
        else{
            
            [DescriptionDetailsLbl setTextColor:[UIColor whiteColor]];
        }
        [DescriptionDetailsLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:12.0f]];
        [DescriptionDetailsLbl setBackgroundColor:[UIColor clearColor]];
        [DetailsScroll addSubview:DescriptionDetailsLbl];
        
        y = y+18;
    }
    
 //================///////////========///////=======
    int x= 41.0f;
    for (int k = 0; k<[UsageArray count]; k++) {
        
        UsageDetailsLbl = [[UILabel alloc]initWithFrame:CGRectMake(162.0f, x, 80.0f, 15.0f)];
        [UsageDetailsLbl setTextAlignment:NSTextAlignmentLeft];
        [UsageDetailsLbl setText:[UsageArray objectAtIndex:k]];
        
        if (k % 2) {
            
            [UsageDetailsLbl setTextColor:[UIColor colorWithRed:(202.0f/255.0f) green:(216.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0f]];
            
        }
        else{
            
            [UsageDetailsLbl setTextColor:[UIColor whiteColor]];
        }
        [UsageDetailsLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:12.0f]];
        [UsageDetailsLbl setBackgroundColor:[UIColor clearColor]];
        [DetailsScroll addSubview:UsageDetailsLbl];
        
        x = x+18;
    }
   
    //================///////////========///////=======
    int z= 41.0f;
    for (int l = 0; l<[RateArray count]; l++) {
        
        RateDetailsLbl = [[UILabel alloc]initWithFrame:CGRectMake(220.0f, z, 80.0f, 15.0f)];
        [RateDetailsLbl setTextAlignment:NSTextAlignmentLeft];
        [RateDetailsLbl setText:[RateArray objectAtIndex:l]];
        
        if (l % 2) {
            
            [RateDetailsLbl setTextColor:[UIColor colorWithRed:(202.0f/255.0f) green:(216.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0f]];
            
        }
        else{
            
            [RateDetailsLbl setTextColor:[UIColor whiteColor]];
        }
        [RateDetailsLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:12.0f]];
        [RateDetailsLbl setBackgroundColor:[UIColor clearColor]];
        [DetailsScroll addSubview:RateDetailsLbl];
        
        z = z+18;
    }
    //================///////////========///////=======
    int w= 23.0f;
    for (int m = 0; m<[ChargeArray count]; m++) {
        
        ChargeDetailsLbl = [[UILabel alloc]initWithFrame:CGRectMake(275.0f, w, 80.0f, 15.0f)];
        [ChargeDetailsLbl setTextAlignment:NSTextAlignmentLeft];
        [ChargeDetailsLbl setText:[ChargeArray objectAtIndex:m]];
        
        if (m % 2) {
            
            [ChargeDetailsLbl setTextColor:[UIColor colorWithRed:(202.0f/255.0f) green:(216.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0f]];
            
        }
        else{
            
            [ChargeDetailsLbl setTextColor:[UIColor whiteColor]];
        }
        [ChargeDetailsLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:12.0f]];
        [ChargeDetailsLbl setBackgroundColor:[UIColor clearColor]];
        [DetailsScroll addSubview:ChargeDetailsLbl];
        
        w = w+18;
    }
    
    ///========================////===========================
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 168.0f, 320.0f, 0.5f)];
    [line1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"lineimg"]]];
    [DetailsScroll addSubview:line1];

    
    UILabel *subtotallbl = [[UILabel alloc]initWithFrame:CGRectMake(3.0f, 171.0f, 100.0f, 15.0f)];
    [subtotallbl setText:@"SUBTOTAL"];
    [subtotallbl setTextAlignment:NSTextAlignmentLeft];
    [subtotallbl setTextColor:[UIColor whiteColor]];
    [subtotallbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
    [DetailsScroll addSubview:subtotallbl];
    
    
    UILabel *totalvaluelbl = [[UILabel alloc]initWithFrame:CGRectMake(267.0f, 171.0f, 100.0f, 15.0f)];
    [totalvaluelbl setText:@"$86.23"];
    [totalvaluelbl setTextAlignment:NSTextAlignmentLeft];
    [totalvaluelbl setTextColor:[UIColor whiteColor]];
    [totalvaluelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
    [DetailsScroll addSubview:totalvaluelbl];
    
////=========================///////////==================
    
    int h = 190.0f;
    
    for (int n = 0; n<[DescriptionArray2 count]; n++) {
        
        DescriptionDeatlslbl2 = [[UILabel alloc]initWithFrame:CGRectMake(3.0f, h, 120.0f, 15.0f)];
        [DescriptionDeatlslbl2 setTextAlignment:NSTextAlignmentLeft];
        [DescriptionDeatlslbl2 setText:[DescriptionArray2 objectAtIndex:n]];
        
        if (n % 2) {
            
            [DescriptionDeatlslbl2 setTextColor:[UIColor colorWithRed:(202.0f/255.0f) green:(216.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0f]];
            
        }
        else{
            
            [DescriptionDeatlslbl2 setTextColor:[UIColor whiteColor]];
        }
        [DescriptionDeatlslbl2 setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
        [DescriptionDeatlslbl2 setBackgroundColor:[UIColor clearColor]];
        [DetailsScroll addSubview:DescriptionDeatlslbl2];
        
        h = h+18;
    }
    
    
    int s = 190.0f;
    
    for (int nk = 0; nk<[RateArray2 count]; nk++) {
        
        RateDetailsLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(220.0f, s, 120.0f, 15.0f)];
        [RateDetailsLbl2 setTextAlignment:NSTextAlignmentLeft];
        [RateDetailsLbl2 setText:[RateArray2 objectAtIndex:nk]];
        
        if (nk % 2) {
            
            [RateDetailsLbl2 setTextColor:[UIColor colorWithRed:(202.0f/255.0f) green:(216.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0f]];
            
        }
        else{
            
            [RateDetailsLbl2 setTextColor:[UIColor whiteColor]];
        }
        [RateDetailsLbl2 setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
        [RateDetailsLbl2 setBackgroundColor:[UIColor clearColor]];
        [DetailsScroll addSubview:RateDetailsLbl2];
        
        s = s+18;
    }

    
    
    int q = 190.0f;
    
    for (int nkq = 0; nkq<[ChargeArray2 count]; nkq++) {
        
        ChargeDetailsLbl2 = [[UILabel alloc]initWithFrame:CGRectMake(275.0f, q, 120.0f, 15.0f)];
        [ChargeDetailsLbl2 setTextAlignment:NSTextAlignmentLeft];
        [ChargeDetailsLbl2 setText:[ChargeArray2 objectAtIndex:nkq]];
        
        if (nkq % 2) {
            
            [ChargeDetailsLbl2 setTextColor:[UIColor colorWithRed:(202.0f/255.0f) green:(216.0f/255.0f) blue:(227.0f/255.0f) alpha:1.0f]];
            
        }
        else{
            
            [ChargeDetailsLbl2 setTextColor:[UIColor whiteColor]];
        }
        [ChargeDetailsLbl2 setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
        [ChargeDetailsLbl2 setBackgroundColor:[UIColor clearColor]];
        [DetailsScroll addSubview:ChargeDetailsLbl2];
        
        q = q+18;
    }
    ///=====///=======
    
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 260.0f, 305.0f, 0.5f)];
    [line2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"lineimg"]]];
    [DetailsScroll addSubview:line2];
    
    
    UILabel *totallbl = [[UILabel alloc]initWithFrame:CGRectMake(3.0f, 265.0f, 100.0f, 15.0f)];
    [totallbl setText:@"TOTAL"];
    [totallbl setTextAlignment:NSTextAlignmentLeft];
    [totallbl setTextColor:[UIColor whiteColor]];
    [totallbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
    [DetailsScroll addSubview:totallbl];
    
    
    UILabel *totalvalue = [[UILabel alloc]initWithFrame:CGRectMake(267.0f, 265.0f, 100.0f, 15.0f)];
    [totalvalue setText:@"$186.23"];
    [totalvalue setTextAlignment:NSTextAlignmentLeft];
    [totalvalue setTextColor:[UIColor whiteColor]];
    [totalvalue setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13]];
    [DetailsScroll addSubview:totalvalue];
    
    
    UIImageView *detailsdivideimg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 280.0f, 320.0f, 32.0f)];
    [detailsdivideimg setImage:[UIImage imageNamed:@"detailsdivideimg"]];
    [DetailsScroll addSubview:detailsdivideimg];
    
    UIView *detailsview = [[UIView alloc]initWithFrame:CGRectMake(210.0f, 274.0f, 70.0f, 50.0f)];
    [detailsview setBackgroundColor:[UIColor clearColor]];
    [DetailsScroll addSubview:detailsview];
    
    UITapGestureRecognizer *detailstap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailstap:)];
    [detailsview addGestureRecognizer:detailstap];
    detailsview.userInteractionEnabled = YES;
    
    ///===========//////////===================/////////==========
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    //email button ..........
    
    
    Emailbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Emailbtn setFrame:CGRectMake(15.0f, 530.0f, 27.0f, 32.0f)];
    [Emailbtn setBackgroundImage:[UIImage imageNamed:@"emailbtnimg"] forState:UIControlStateNormal];
    [Emailbtn setBackgroundImage:[UIImage imageNamed:@"emailbtnimg"] forState:UIControlStateHighlighted];
    [Emailbtn addTarget:self action:@selector(email:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Emailbtn];
    

    //pay button......
    
    
    paybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [paybtn setFrame:CGRectMake(285.0f, 530.0f, 19.5f, 34.5f)];
    [paybtn setBackgroundImage:[UIImage imageNamed:@"paybtnimg"] forState:UIControlStateNormal];
    [paybtn setBackgroundImage:[UIImage imageNamed:@"paybtnimg"] forState:UIControlStateHighlighted];
    [paybtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:paybtn];


    // Do any additional setup after loading the view.
}
//menu function........
-(void)menu:(UIButton *)sender{
    
    if(MainView.frame.origin.x > 100.0f) {
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             [MainView setFrame:[[UIScreen mainScreen] bounds]];
                         }
                         completion:^(BOOL finished){
                             menuOpened = NO;
                             [self.view bringSubviewToFront:MainView];
                         }];
        
    } else {
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             [MainView setFrame:CGRectMake(280.0f, 0, MainView.frame.size.width, MainView.frame.size.height)];
                         }
                         completion:^(BOOL finished){
                             menuOpened = YES;
                             [self.view bringSubviewToFront:MainView];
                         }];
        
    }
    
}
-(void)budget:(UIButton *)sender{
    
    MMUsageBudgetViewController *model = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
    
}

//Email function.........

-(void)email:(UIButton *)sender{
    
    MMUsageEmailViewController *share = [[MMUsageEmailViewController alloc]init];
    [self.navigationController pushViewController:share animated:NO];
    
}

//pay button function................
-(void)pay:(UIButton *)sender{
    
    MMUsagePayViewController *pay = [[MMUsagePayViewController alloc]init];
    [self.navigationController pushViewController:pay animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)detailstap:(UITapGestureRecognizer *)sender{
    
//    MMusagebillViewController *model = [[MMusagebillViewController alloc]init];
//    [self.navigationController pushViewController:model animated:NO];

    [self.navigationController popViewControllerAnimated:NO];
}

-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *view = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
