//
//  MMUsageCo2ViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 11/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMUsageCo2ViewController.h"
#import "MMusagebillViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMUsageTreeViewController.h"

@interface MMUsageCo2ViewController ()<UITextFieldDelegate>{
    
    NSDictionary *usageco2;
    UIView *Goaolbackview;
    UITextField *Goaltextfield;
}

@end

@implementation MMUsageCo2ViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"MMUsageCo2ViewController");
    
    
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
    
    
    NSDate *currentdate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *currenttime = [dateFormatter stringFromDate:currentdate];
    
    
    
    NSString *Reading_Str = [[NSString alloc]init];
    
    Reading_Str = [NSString stringWithFormat:@"%@tree_calculation.php?date=%@&user_id=%@&lat=%@&long=%@",DOMAIN_APP_URL,currenttime,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],[[NSUserDefaults standardUserDefaults]objectForKey:@"latitude"],[[NSUserDefaults standardUserDefaults]objectForKey:@"longitude"]];
    
    NSLog(@"string...... :%@",Reading_Str);
    
    NSError *error=nil;
    
    
    NSData *Reading_Data=[NSData dataWithContentsOfURL:[NSURL URLWithString:Reading_Str]options:NSDataReadingUncached error:&error];
    usageco2=[NSJSONSerialization JSONObjectWithData:Reading_Data options:kNilOptions error:&error];
    
    // NSLog(@"usageco2.... :%@",usageco2);
    
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
    [billbtn setFrame:CGRectMake(149, 82.0f, 70/2, 84/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"Billselectedbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"Billselectedbtn"] forState:UIControlStateHighlighted];
    [billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(251, 89.0f, 74/2, 65/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageselectedbtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageselectedbtn"] forState:UIControlStateHighlighted];
    //[usagebtn addTarget:self action:@selector(usage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    /////======================/////////////////===============
    
    
    co2lbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 140.0f, 240.0f, 30.0f)];
    [co2lbl setBackgroundColor:[UIColor clearColor]];
    [co2lbl setTextColor:[UIColor whiteColor]];
    [co2lbl setText:@"Co2 Emissions Balloon"];
    [co2lbl setTextAlignment:NSTextAlignmentCenter];
    [co2lbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
    [MainView addSubview:co2lbl];
    
    /*
     monthkwhview = [[UIView alloc]initWithFrame:CGRectMake(130.0f, 190.0f, 60.0f, 50.0f)];
     [monthkwhview setBackgroundColor:[UIColor clearColor]];
     monthkwhview.layer.borderWidth = 0.8f;
     monthkwhview.layer.cornerRadius = 1.0f;
     monthkwhview.layer.borderColor = [[UIColor colorWithRed:(167.0f/255.0f) green:(190.0f/255.0f) blue:(207.0f/255.0f) alpha:1.0f]CGColor];
     [MainView addSubview:monthkwhview];
     */
    
    //priyanka
    
    graphBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [graphBtn setFrame:CGRectMake(0.0f, 190.0f, 114/3, 30)];
    [graphBtn setBackgroundImage:[UIImage imageNamed:@"GraphIcon"] forState:UIControlStateNormal];
    graphBtn.selected=NO;
    [graphBtn setBackgroundImage:[UIImage imageNamed:@"GraphIcon"] forState:UIControlStateHighlighted];
    [graphBtn addTarget:self action:@selector(GraphBtnClk:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:graphBtn];
    
    PercentLbl = [[UILabel alloc]initWithFrame:CGRectMake(122.0f, 180.0f, 75.0f, 36.0f)];
    [PercentLbl setBackgroundColor:[UIColor clearColor]];
    [PercentLbl setTextColor:[UIColor whiteColor]];
    [PercentLbl setText:@"11"];
    //  [monthkwhlbl setText:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"curr_month"]]];
    [PercentLbl setTextAlignment:NSTextAlignmentCenter];
    [PercentLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:34]];
    [MainView addSubview:PercentLbl];
    
    monthkwhlbl = [[UILabel alloc]initWithFrame:CGRectMake(158.0f, 180.0f, 56.0f, 30.0f)];
    [monthkwhlbl setBackgroundColor:[UIColor clearColor]];
    [monthkwhlbl setTextColor:[UIColor whiteColor]];
    [monthkwhlbl setText:@"%"];
    //  [monthkwhlbl setText:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"curr_month"]]];
    [monthkwhlbl setTextAlignment:NSTextAlignmentCenter];
    [monthkwhlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20]];
    [MainView addSubview:monthkwhlbl];
    
    monthkwhlbl2 = [[UILabel alloc]initWithFrame:CGRectMake(86.0f, 210.0f, 160.0f, 22.0f)];
    [monthkwhlbl2 setBackgroundColor:[UIColor clearColor]];
    [monthkwhlbl2 setTextColor:[UIColor whiteColor]];
    //[monthkwhlbl2 setText:@"210KWh*"];
    //   [monthkwhlbl2 setText:[NSString stringWithFormat:@"%@*",[usagetree objectForKey:@"user_reading_in_month"]]];
    [monthkwhlbl2 setText:[@"Below Last " stringByAppendingString:[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"curr_month"]]]];
    [monthkwhlbl2 setTextAlignment:NSTextAlignmentCenter];
    [monthkwhlbl2 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
    [MainView addSubview:monthkwhlbl2];
    
    
    UIImageView *scale_img=[[UIImageView alloc]initWithFrame:CGRectMake(5, 240, 20, 245/2)];
    scale_img.image=[UIImage imageNamed:@"scale_img.png"];
    scale_img.backgroundColor=[UIColor clearColor];
    [MainView addSubview:scale_img];
    
    
    UILabel *youlb = [[UILabel alloc]initWithFrame:CGRectMake(20, 240.0f, 100.0f, 30.0f)];
    [youlb setBackgroundColor:[UIColor clearColor]];
    [youlb setTextColor:[UIColor whiteColor]];
    //   [youlb setText:@"You"];
    [youlb setText:@"2015"];
    [youlb setTextAlignment:NSTextAlignmentCenter];
    [youlb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
    [MainView addSubview:youlb];
    
    UIImageView *gray_circle=[[UIImageView alloc]initWithFrame:CGRectMake(40,276, 141/3, 248/3)];
    gray_circle.image=[UIImage imageNamed:@"Untitled-14"];
    gray_circle.backgroundColor=[UIColor clearColor];
    [MainView addSubview:gray_circle];
    /*
     UILabel *younum_lb = [[UILabel alloc]initWithFrame:CGRectMake(22, 335, 100.0f, 30.0f)];
     [younum_lb setBackgroundColor:[UIColor clearColor]];
     [younum_lb setTextColor:[UIColor whiteColor]];
     [younum_lb setText:@"*8.2'"];
     //  [younum_lb setText:[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"user_trees_count"]]];
     [younum_lb setTextAlignment:NSTextAlignmentCenter];
     [younum_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
     [MainView addSubview:younum_lb];
     
     
     
     
     UIImageView *gray_circle=[[UIImageView alloc]initWithFrame:CGRectMake(62,334, 24, 24)];
     gray_circle.image=[UIImage imageNamed:@"small_gray.png"];
     gray_circle.backgroundColor=[UIColor clearColor];
     [MainView addSubview:gray_circle];
     */
    
    UILabel *alexlb = [[UILabel alloc]initWithFrame:CGRectMake(120, 240.0f, 100.0f, 30.0f)];
    [alexlb setBackgroundColor:[UIColor clearColor]];
    [alexlb setTextColor:[UIColor colorWithRed:(221.0/255.0) green:(228.0/255.0) blue:(92.0/255.0) alpha:1.0]];
    [alexlb setTextAlignment:NSTextAlignmentCenter];
    [alexlb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
    [MainView addSubview:alexlb];
    [alexlb setText:@"2014"];
    /*   if ([[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"name"]] isEqualToString:@"<null>"])
     {
     }
     else
     {
     [alexlb setText:[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"name"]]];
     }
     */
    
    
    /*
     UILabel *alexnum_lb = [[UILabel alloc]initWithFrame:CGRectMake(122, 290, 100.0f, 30.0f)];
     [alexnum_lb setBackgroundColor:[UIColor clearColor]];
     [alexnum_lb setTextColor:[UIColor whiteColor]];
     [alexnum_lb setText:[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"nabour_trees_count"]]];
     [alexnum_lb setTextAlignment:NSTextAlignmentCenter];
     [alexnum_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
     [MainView addSubview:alexnum_lb];
     */
    
    UIImageView *yel_circle=[[UIImageView alloc]initWithFrame:CGRectMake(147, 268, 141/3, 271/3)];
    yel_circle.image=[UIImage imageNamed:@"Untitled-13"];
    yel_circle.backgroundColor=[UIColor clearColor];
    [MainView addSubview:yel_circle];
    
    UILabel *goallb = [[UILabel alloc]initWithFrame:CGRectMake(220, 240.0f, 100.0f, 30.0f)];
    [goallb setBackgroundColor:[UIColor clearColor]];
    [goallb setTextColor:[UIColor colorWithRed:(137.0/255.0) green:(224.0/255.0) blue:(92.0/255.0) alpha:1.0]];
    [goallb setText:@"Go Green"];
    [goallb setTextAlignment:NSTextAlignmentCenter];
    [goallb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
    [MainView addSubview:goallb];
    
    UIButton *LearnMorebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [LearnMorebtn setFrame:CGRectMake(223.0f, 263.0f, 290/3, 68/3)];
    //   [LearnMorebtn setTitle:@"Learn More" forState:UIControlStateNormal];
    [LearnMorebtn setBackgroundImage:[UIImage imageNamed:@"Learn More"] forState:UIControlStateNormal];
    [LearnMorebtn setBackgroundImage:[UIImage imageNamed:@"Learn More"] forState:UIControlStateHighlighted];
    //  [LearnMorebtn addTarget:self action:@selector(LearnMoreClk:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:LearnMorebtn];
    
    /*
     UILabel *goalnum_lb = [[UILabel alloc]initWithFrame:CGRectMake(222, 290, 100.0f, 30.0f)];
     [goalnum_lb setBackgroundColor:[UIColor clearColor]];
     [goalnum_lb setTextColor:[UIColor whiteColor]];
     [goalnum_lb setText:[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"goal"]]];
     [goalnum_lb setTextAlignment:NSTextAlignmentCenter];
     [goalnum_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:22]];
     [MainView addSubview:goalnum_lb];
     */
    
    UIImageView *blue_circle=[[UIImageView alloc]initWithFrame:CGRectMake(255, 315, 96/3, 125/3)];
    blue_circle.image=[UIImage imageNamed:@"Untitled-2"];
    blue_circle.backgroundColor=[UIColor clearColor];
    [MainView addSubview:blue_circle];
    
    GraphView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 170.0f,self.view.frame.size.width, 355.0f)];
    [GraphView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [MainView addSubview:GraphView];
    GraphView.hidden=YES;
    
    UIImageView *Monthlygraph=[[UIImageView alloc]initWithFrame:CGRectMake(0,25, self.view.frame.size.width, 165)];
    
    Monthlygraph.image=[UIImage imageNamed:@"graph1"];
    
    [GraphView addSubview:Monthlygraph];
    /////================================/////=========================////=================================///===================
    
    ///divider view......=======.......====
    
    UIView *divider_view = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 360.0f, 320.0f, 1.5f)];
    [divider_view setBackgroundColor:[UIColor colorWithRed:(167.0f/255.0f) green:(190.0f/255.0f) blue:(207.0f/255.0f) alpha:1.0f]];
    [MainView addSubview:divider_view];
    
    UIImageView *YTDgraph=[[UIImageView alloc]initWithFrame:CGRectMake(0, 362, self.view.frame.size.width, 538/3-16)];
    
    YTDgraph.image=[UIImage imageNamed:@"YTDCO2Graph"];
    
    [MainView addSubview:YTDgraph];
    /*
     UIView *monthkwhview2 = [[UIView alloc]initWithFrame:CGRectMake(140.0f, 370, 60.0f, 50.0f)];
     [monthkwhview2 setBackgroundColor:[UIColor clearColor]];
     monthkwhview2.layer.borderWidth = 0.8f;
     monthkwhview2.layer.cornerRadius = 1.0f;
     monthkwhview2.layer.borderColor = [[UIColor colorWithRed:(167.0f/255.0f) green:(190.0f/255.0f) blue:(207.0f/255.0f) alpha:1.0f]CGColor];
     [MainView addSubview:monthkwhview2];
     
     
     UILabel *ytdlbl = [[UILabel alloc]initWithFrame:CGRectMake(142.0f, 372.0f, 56.0f, 30.0f)];
     [ytdlbl setBackgroundColor:[UIColor clearColor]];
     [ytdlbl setTextColor:[UIColor whiteColor]];
     [ytdlbl setText:@"YTD"];
     [ytdlbl setTextAlignment:NSTextAlignmentCenter];
     [ytdlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20]];
     [MainView addSubview:ytdlbl];
     
     UILabel *ytd_dist = [[UILabel alloc]initWithFrame:CGRectMake(142.0f, 400.0f, 56.0f, 19.0f)];
     [ytd_dist setBackgroundColor:[UIColor clearColor]];
     [ytd_dist setTextColor:[UIColor whiteColor]];
     [ytd_dist setText:[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"user_reading_in_year_kwh"]]];
     [ytd_dist setTextAlignment:NSTextAlignmentCenter];
     [ytd_dist setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12]];
     [MainView addSubview:ytd_dist];
     
     
     UIImageView *scale_img2=[[UIImageView alloc]initWithFrame:CGRectMake(5, 405, 20, 245/2)];
     scale_img2.image=[UIImage imageNamed:@"scale_img.png"];
     scale_img2.backgroundColor=[UIColor clearColor];
     [MainView addSubview:scale_img2];
     
     
     UILabel *youbl_lb = [[UILabel alloc]initWithFrame:CGRectMake(25, 380, 100.0f, 30.0f)];
     [youbl_lb setBackgroundColor:[UIColor clearColor]];
     [youbl_lb setTextColor:[UIColor whiteColor]];
     [youbl_lb setText:@"You"];
     [youbl_lb setTextAlignment:NSTextAlignmentCenter];
     [youbl_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
     [MainView addSubview:youbl_lb];
     
     UILabel *younumbl= [[UILabel alloc]initWithFrame:CGRectMake(27, 400, 100.0f, 30.0f)];
     [younumbl setBackgroundColor:[UIColor clearColor]];
     [younumbl setTextColor:[UIColor whiteColor]];
     [younumbl setText:[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"user_yearly_trees_count"]]];
     [younumbl setTextAlignment:NSTextAlignmentCenter];
     [younumbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
     [MainView addSubview:younumbl];
     
     
     
     
     UIImageView *biggray_circle=[[UIImageView alloc]init];
     biggray_circle.image=[UIImage imageNamed:@"big_gray.png"];
     biggray_circle.backgroundColor=[UIColor clearColor];
     [MainView addSubview:biggray_circle];
     
     
     UILabel *goalbl_lb = [[UILabel alloc]initWithFrame:CGRectMake(210, 380, 100.0f, 30.0f)];
     [goalbl_lb setBackgroundColor:[UIColor clearColor]];
     [goalbl_lb setTextColor:[UIColor whiteColor]];
     [goalbl_lb setText:@"Goal"];
     [goalbl_lb setTextAlignment:NSTextAlignmentCenter];
     [goalbl_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
     [MainView addSubview:goalbl_lb];
     
     UILabel *goal_bl = [[UILabel alloc]initWithFrame:CGRectMake(210, 400, 100.0f, 30.0f)];
     [goal_bl setBackgroundColor:[UIColor clearColor]];
     [goal_bl setTextColor:[UIColor whiteColor]];
     [goal_bl setText:[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"goal"]]];
     [goal_bl setTextAlignment:NSTextAlignmentCenter];
     [goal_bl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
     [MainView addSubview:goal_bl];
     
     UIImageView *bigblue_circle=[[UIImageView alloc]init];
     bigblue_circle.image=[UIImage imageNamed:@"big_blue.png"];
     bigblue_circle.backgroundColor=[UIColor clearColor];
     [MainView addSubview:bigblue_circle];
     
     
     if ([[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"user_yearly_trees_count"]] intValue] >[[NSString stringWithFormat:@"%@",[usageco2 objectForKey:@"goal"]]intValue])
     {
     biggray_circle.frame = CGRectMake(40, 425, 195/2, 195/2);
     bigblue_circle.frame = CGRectMake(220, 437, 169/2, 170/2);
     
     }
     else
     {
     biggray_circle.frame = CGRectMake(215, 425, 195/2, 195/2);
     bigblue_circle.frame = CGRectMake(40, 437, 169/2, 170/2);
     }
     */
    
    //footerview.............................
    
    /////================//////////=============
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    footerBackbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerBackbtn setFrame:CGRectMake(20.0f, 3.0f, 54/2.0f, 35.0f)];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateNormal];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateHighlighted];
    [footerBackbtn addTarget:self action:@selector(BackClk:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerBackbtn];
    
    
    footertreebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [footertreebutton setFrame:CGRectMake(95.0f, 3.0f, 24.5f, 35.0f)];
    [footertreebutton setBackgroundImage:[UIImage imageNamed:@"footertreebtn"] forState:UIControlStateNormal];
    [footertreebutton setBackgroundImage:[UIImage imageNamed:@"footertreebtn"] forState:UIControlStateHighlighted];
    [footertreebutton addTarget:self action:@selector(footertree:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footertreebutton];
    
    
    footerco2btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerco2btn setFrame:CGRectMake(170.0f, 5.0f, 67/2, 68/2)];
    [footerco2btn setBackgroundImage:[UIImage imageNamed:@"footerco2selectedbtn"] forState:UIControlStateNormal];
    [footerco2btn setBackgroundImage:[UIImage imageNamed:@"footerco2selectedbtn"] forState:UIControlStateHighlighted];
    [footerco2btn addTarget:self action:@selector(footerco2:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerco2btn];
    
    footercheckbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footercheckbtn setFrame:CGRectMake(270.0f, 3.0f, 28.0f, 36.0f)];
    [footercheckbtn setBackgroundImage:[UIImage imageNamed:@"footercheckbtn"] forState:UIControlStateNormal];
    [footercheckbtn setBackgroundImage:[UIImage imageNamed:@"footercheckbtn"] forState:UIControlStateHighlighted];
    //[footercheckbtn addTarget:self action:@selector(footerupdate:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footercheckbtn];
    
    ///===================//////////================
    
    
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
-(void)bill:(UIButton *)sender{
    
    MMusagebillViewController *model = [[MMusagebillViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
}
-(void)footerco2:(UIButton *)sender{
    
    GraphView.hidden=YES;
}
-(void)budget:(UIButton *)sender{
    
    MMUsageBudgetViewController *model = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
    
}

-(void)footertree:(UIButton *)sender{
    
    MMUsageTreeViewController *model = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)footerupdate:(UIButton *)sender{
    
    BlackView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [BlackView setBackgroundColor:[UIColor blackColor]];
    [BlackView setAlpha:0.5f];
    [MainView addSubview:BlackView];
    
    if ([[UIScreen mainScreen]bounds].size.width ==320)
    {
        
        CrossButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [CrossButton setFrame:CGRectMake(260, 120, 45, 45)];
        [CrossButton setBackgroundImage:[UIImage imageNamed:@"crossBtn"] forState:UIControlStateNormal];
        [CrossButton setBackgroundImage:[UIImage imageNamed:@"crossBtn"] forState:UIControlStateHighlighted];
        [CrossButton addTarget:self action:@selector(crossbutton:) forControlEvents:UIControlEventTouchUpInside];
        [MainView addSubview:CrossButton];
    }
    else
    {
        CrossButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [CrossButton setFrame:CGRectMake(290, 120, 45, 45)];
        [CrossButton setBackgroundImage:[UIImage imageNamed:@"crossBtn"] forState:UIControlStateNormal];
        [CrossButton setBackgroundImage:[UIImage imageNamed:@"crossBtn"] forState:UIControlStateHighlighted];
        [CrossButton addTarget:self action:@selector(crossbutton:) forControlEvents:UIControlEventTouchUpInside];
        [MainView addSubview:CrossButton];
        
    }
    
    Goaolbackview = [[UIView alloc]initWithFrame:CGRectMake(20.0f, 190.0f, 280.0f, 120.0f)];
    [Goaolbackview setBackgroundColor:[UIColor whiteColor]];
    Goaolbackview.layer.cornerRadius = 5.0f;
    [MainView addSubview:Goaolbackview];
    
    Goaltextfield = [[UITextField alloc] initWithFrame:CGRectMake(10,20.0f, 260.0f, 40)];
    Goaltextfield.backgroundColor = [UIColor clearColor];
    Goaltextfield.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    Goaltextfield.placeholder = @"Set your goal";
    Goaltextfield.text=@"";
    Goaltextfield.textColor = [UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f];
    Goaltextfield.layer.borderWidth = 1.0f;
    Goaltextfield.layer.borderColor = [[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f]CGColor];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 3)];
    [Goaltextfield setLeftView:leftView3];
    [Goaltextfield setLeftViewMode:UITextFieldViewModeAlways];
    [Goaltextfield setValue:[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [Goaltextfield setValue:[UIFont fontWithName:GLOBALTEXTFONT size:15]  forKeyPath:@"_placeholderLabel.font"];
    [Goaltextfield setDelegate:self];
    [Goaolbackview addSubview:Goaltextfield];
    
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [savebtn setFrame:CGRectMake(50.0f, 70.0f, 180.0f, 35.0f)];
    [savebtn setTitle:@"Save" forState:UIControlStateNormal];
    [savebtn setTitle:@"Save" forState:UIControlStateHighlighted];
    [savebtn setTitle:@"Save" forState:UIControlStateSelected];
    [savebtn setBackgroundColor:[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f]];
    savebtn.titleLabel.textColor = [UIColor whiteColor];
    savebtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    savebtn.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:20];
    [savebtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [Goaolbackview addSubview:savebtn];
    
}
-(void)GraphBtnClk:(UIButton *)sender
{
    if (graphBtn.selected==NO)
    {
        GraphView.hidden=NO;
    }
    else if (graphBtn.selected==YES)
    {
        GraphView.hidden=YES;
    }
    
}

-(void)crossbutton:(UIButton *)sender{
    
    
    [BlackView removeFromSuperview];
    [CrossButton removeFromSuperview];
    [Goaolbackview removeFromSuperview];
}
-(void)BackClk:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
