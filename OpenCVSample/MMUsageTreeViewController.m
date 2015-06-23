//
//  MMUsageTreeViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 10/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMUsageTreeViewController.h"
#import "MMusagebillViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMUsageCo2ViewController.h"


@interface MMUsageTreeViewController ()<UITextFieldDelegate>
{
    
    NSDictionary *usagetree;
    UIView *BlackView,*Goaolbackview;
    UITextField *Goaltextfield;
    UIButton *CrossButton;
}

@end

@implementation MMUsageTreeViewController


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"MMUsageTreeViewController");
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];
    
    //backgroundView...................
    
    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [self.view addSubview:MainView];
    
    
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
    usagetree=[NSJSONSerialization JSONObjectWithData:Reading_Data options:kNilOptions error:&error];
    
    NSLog(@"userco2//// :%@",usagetree);
    
    
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
    //   [HeaderLbl setText:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"curr_month"]]];
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
    
    //priyanka
    
    
    co2lbl = [[UILabel alloc]initWithFrame:CGRectMake(25.0f, 138.0f, self.view.frame.size.width-50, 30.0f)];
    [co2lbl setBackgroundColor:[UIColor clearColor]];
    [co2lbl setTextColor:[UIColor whiteColor]];
    [co2lbl setText:@"How Many Trees Do You Need?"];
    [co2lbl setTextAlignment:NSTextAlignmentCenter];
    [co2lbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
    [MainView addSubview:co2lbl];
    
    
    
    graphBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [graphBtn setFrame:CGRectMake(0.0f, 190.0f, 114/3, 30)];
    [graphBtn setBackgroundImage:[UIImage imageNamed:@"GraphIcon"] forState:UIControlStateNormal];
    graphBtn.selected=NO;
    [graphBtn setBackgroundImage:[UIImage imageNamed:@"GraphIcon"] forState:UIControlStateHighlighted];
    [graphBtn addTarget:self action:@selector(GraphBtnClk:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:graphBtn];
    
    /*
     monthkwhview = [[UIView alloc]initWithFrame:CGRectMake(130.0f, 190.0f, 60.0f, 50.0f)];
     [monthkwhview setBackgroundColor:[UIColor clearColor]];
     monthkwhview.layer.borderWidth = 0.8f;
     monthkwhview.layer.cornerRadius = 1.0f;
     monthkwhview.layer.borderColor = [[UIColor colorWithRed:(167.0f/255.0f) green:(190.0f/255.0f) blue:(207.0f/255.0f) alpha:1.0f]CGColor];
     [MainView addSubview:monthkwhview];
     */
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
    [monthkwhlbl2 setText:[@"Below Last " stringByAppendingString:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"curr_month"]]]];
    [monthkwhlbl2 setTextAlignment:NSTextAlignmentCenter];
    [monthkwhlbl2 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
    [MainView addSubview:monthkwhlbl2];
    
    
    
    //user tree count  label..............***********************//////////////////////////////
    
    UILabel *youlb = [[UILabel alloc]initWithFrame:CGRectMake(25, 240.0f, 70, 30.0f)];
    [youlb setBackgroundColor:[UIColor clearColor]];
    [youlb setTextColor:[UIColor whiteColor]];
    [youlb setText:@"2015"];
    //  [youlb setText:@"You"];
    [youlb setTextAlignment:NSTextAlignmentLeft];
    [youlb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
    [MainView addSubview:youlb];
    
    UILabel *younum_lb = [[UILabel alloc]initWithFrame:CGRectMake(35, 335, 70, 30.0f)];
    [younum_lb setBackgroundColor:[UIColor clearColor]];
    [younum_lb setTextColor:[UIColor whiteColor]];
    [younum_lb setText:[[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"user_trees_count"]] stringByAppendingString:@"*"]];
    [younum_lb setTextAlignment:NSTextAlignmentLeft];
    [younum_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
    [MainView addSubview:younum_lb];
    
    
    //    UILabel *youtym_lb = [[UILabel alloc]initWithFrame:CGRectMake(20, 295.0f, 100.0f, 15)];
    //    [youtym_lb setBackgroundColor:[UIColor clearColor]];
    //    [youtym_lb setTextColor:[UIColor whiteColor]];
    //    [youtym_lb setText:@"Just now"];
    //    [youtym_lb setTextAlignment:NSTextAlignmentCenter];
    //    [youtym_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12]];
    //    [MainView addSubview:youtym_lb];
    
    
    int usertreecount = [[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"user_trees_count"]] intValue]/10;
    
    // int usertreecount = 20/10;
    
    NSLog(@"usertreecount   :%d",usertreecount);
    
    
    
    int j = 327;
    
    for (int i = 0; i <usertreecount; i++) {
        int a = 16;
        
        for (int k = 0; k<10; k++) {
            
            UIImageView *treeimage = [[UIImageView alloc]initWithFrame:CGRectMake(a, j, 7, 10)];
            [treeimage setImage:[UIImage imageNamed:@"user-tree"]];
            [MainView addSubview:treeimage];
            
            a = a+9;
            
            
        }
        
        j = j-13;
    }
    
    int usertreecount1 = [[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"user_trees_count"]] intValue]%10;
    
    NSLog(@"usertreecount rem  :%d",usertreecount1);
    
    if (usertreecount1 == 0)
    {
        
    }
    else
    {
        int g = 16;
        int d = 327-(13*usertreecount);
        for (int f = 0; f<usertreecount1; f++) {
            
            UIImageView *treeimage = [[UIImageView alloc]initWithFrame:CGRectMake(g, d, 7, 10)];
            [treeimage setImage:[UIImage imageNamed:@"user-tree"]];
            [MainView addSubview:treeimage];
            
            g = g+9;
        }
        
    }
    
    /////////////////================================
    
    
    UILabel *alexlb = [[UILabel alloc]initWithFrame:CGRectMake(135, 240.0f, 100.0f, 30.0f)];
    [alexlb setBackgroundColor:[UIColor clearColor]];
    [alexlb setTextColor:[UIColor colorWithRed:(221.0/255.0) green:(228.0/255.0) blue:(92.0/255.0) alpha:1.0]];
    [alexlb setTextAlignment:NSTextAlignmentLeft];
    [alexlb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:16]];
    [MainView addSubview:alexlb];
    [alexlb setText:@"2014"];
    /*    if ([[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"name"]] isEqualToString:@"<null>"])
     {
     }
     else
     {
     [alexlb setText:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"name"]]];
     }
     */
    UILabel *alexnum_lb = [[UILabel alloc]initWithFrame:CGRectMake(146, 335, 100.0f, 30.0f)];
    [alexnum_lb setBackgroundColor:[UIColor clearColor]];
    [alexnum_lb setTextColor:[UIColor colorWithRed:(221.0/255.0) green:(228.0/255.0) blue:(92.0/255.0) alpha:1.0]];
    [alexnum_lb setText:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"nabour_trees_count"]]];
    [alexnum_lb setTextAlignment:NSTextAlignmentLeft];
    [alexnum_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20]];
    [MainView addSubview:alexnum_lb];
    
    
    //    UILabel *alextym_lb = [[UILabel alloc]initWithFrame:CGRectMake(120, 300.0f, 100.0f, 15)];
    //    [alextym_lb setBackgroundColor:[UIColor clearColor]];
    //    [alextym_lb setTextColor:[UIColor whiteColor]];
    //    [alextym_lb setText:@"30hrs old"];
    //    [alextym_lb setTextAlignment:NSTextAlignmentCenter];
    //    [alextym_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12]];
    //    [MainView addSubview:alextym_lb];
    
    
    
    
    int usertreecountnbour = [[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"nabour_trees_count"]] intValue]/10;
    
    //int usertreecount = 20/10;
    
    NSLog(@"usertreecount   :%d",usertreecountnbour);
    
    
    
    
    
    int l = 327;
    
    for (int i = 0; i <usertreecountnbour; i++) {
        int a = 130;
        
        for (int k = 0; k<10; k++) {
            
            UIImageView *treeimage = [[UIImageView alloc]initWithFrame:CGRectMake(a, l, 7, 10)];
            [treeimage setImage:[UIImage imageNamed:@"user-tree"]];
            [MainView addSubview:treeimage];
            
            a = a+9;
            
            
        }
        
        l = l-13;
    }
    
    int usertreecountnbour1 = [[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"nabour_trees_count"]] intValue]%10;
    
    NSLog(@"usertreecount rem  :%d",usertreecountnbour1);
    
    if (usertreecount1 == 0)
    {
        
    }
    else
    {
        int g = 130;
        int d = 327-(13*usertreecountnbour);
        for (int f = 0; f<usertreecountnbour1; f++) {
            
            UIImageView *treeimage = [[UIImageView alloc]initWithFrame:CGRectMake(g, d, 7, 10)];
            [treeimage setImage:[UIImage imageNamed:@"user-tree"]];
            [MainView addSubview:treeimage];
            
            g = g+9;
        }
        
    }
    
    UILabel *goallb = [[UILabel alloc]initWithFrame:CGRectMake(225, 240.0f, 100.0f, 30.0f)];
    [goallb setBackgroundColor:[UIColor clearColor]];
    [goallb setTextColor:[UIColor colorWithRed:(137.0/255.0) green:(224.0/255.0) blue:(152.0/255.0) alpha:1.0]];
    //   [goallb setText:@"Goal"];
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
    
    UILabel *goalnum_lb = [[UILabel alloc]initWithFrame:CGRectMake(227, 335, 100.0f, 30.0f)];
    [goalnum_lb setBackgroundColor:[UIColor clearColor]];
    [goalnum_lb setTextColor:[UIColor colorWithRed:(137.0/255.0) green:(224.0/255.0) blue:(152.0/255.0) alpha:1.0]];
    [goalnum_lb setText:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"goal"]]];
    [goalnum_lb setTextAlignment:NSTextAlignmentCenter];
    [goalnum_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:22]];
    [MainView addSubview:goalnum_lb];
    
    
    
    int goalcount = [[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"goal"]] intValue]/8;
    
    //int usertreecount = 20/10;
    
    NSLog(@"usertreecount   :%d",goalcount);
    
    
    
    
    
    int s = 327;
    
    for (int i = 0; i <goalcount; i++) {
        int a = 240;
        
        for (int k = 0; k<8; k++) {
            
            UIImageView *treeimage = [[UIImageView alloc]initWithFrame:CGRectMake(a, s, 7, 10)];
            [treeimage setImage:[UIImage imageNamed:@"user-tree"]];
            [MainView addSubview:treeimage];
            
            a = a+9;
            
            
        }
        
        s = s-13;
    }
    
    int goalcount1 = [[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"goal"]] intValue]%8;
    
    NSLog(@"usertreecount rem  :%d",goalcount1);
    
    if (goalcount1 == 0)
    {
        
    }
    else
    {
        int g = 240;
        int d = 327-(13*goalcount);
        for (int f = 0; f<goalcount1; f++) {
            
            UIImageView *treeimage = [[UIImageView alloc]initWithFrame:CGRectMake(g, d, 7, 10)];
            [treeimage setImage:[UIImage imageNamed:@"user-tree"]];
            [MainView addSubview:treeimage];
            
            g = g+9;
        }
        
    }
    
    GraphView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 170.0f,self.view.frame.size.width, 355.0f)];
    [GraphView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [MainView addSubview:GraphView];
    GraphView.hidden=YES;
    
    UIImageView *Monthlygraph=[[UIImageView alloc]initWithFrame:CGRectMake(0,25, self.view.frame.size.width, 165)];
    
    Monthlygraph.image=[UIImage imageNamed:@"graph1"];
    
    [GraphView addSubview:Monthlygraph];
    
    //divider line.....
    
    UIView *divider_view = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 360.0f, 320.0f, 1.5f)];
    [divider_view setBackgroundColor:[UIColor colorWithRed:(167.0f/255.0f) green:(190.0f/255.0f) blue:(207.0f/255.0f) alpha:1.0f]];
    [MainView addSubview:divider_view];
    
    //==================//////////////=========////////////========
    
    UIImageView *YTDgraph=[[UIImageView alloc]initWithFrame:CGRectMake(0, 362, self.view.frame.size.width, 538/3-16)];
    
    YTDgraph.image=[UIImage imageNamed:@"graph2"];
    
    [MainView addSubview:YTDgraph];
    
    /*
     UIView *monthkwhview2 = [[UIView alloc]initWithFrame:CGRectMake(130.0f, 370, 60.0f, 50.0f)];
     [monthkwhview2 setBackgroundColor:[UIColor clearColor]];
     monthkwhview2.layer.borderWidth = 0.8f;
     monthkwhview2.layer.cornerRadius = 1.0f;
     monthkwhview2.layer.borderColor = [[UIColor colorWithRed:(167.0f/255.0f) green:(190.0f/255.0f) blue:(207.0f/255.0f) alpha:1.0f]CGColor];
     [MainView addSubview:monthkwhview2];
     
     
     UILabel *ytdlbl = [[UILabel alloc]initWithFrame:CGRectMake(132.0f, 372.0f, 56.0f, 30.0f)];
     [ytdlbl setBackgroundColor:[UIColor clearColor]];
     [ytdlbl setTextColor:[UIColor whiteColor]];
     [ytdlbl setText:@"YTD"];
     [ytdlbl setTextAlignment:NSTextAlignmentCenter];
     [ytdlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20]];
     [MainView addSubview:ytdlbl];
     
     UILabel *ytd_dist = [[UILabel alloc]initWithFrame:CGRectMake(132.0f, 400.0f, 56.0f, 19.0f)];
     [ytd_dist setBackgroundColor:[UIColor clearColor]];
     [ytd_dist setTextColor:[UIColor whiteColor]];
     //    [ytd_dist setText:@"7655KWh"];
     [ytd_dist setText:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"user_reading_in_year_kwh"]]];
     [ytd_dist setTextAlignment:NSTextAlignmentCenter];
     [ytd_dist setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12]];
     [MainView addSubview:ytd_dist];
     
     
     UILabel *youbl_lb = [[UILabel alloc]initWithFrame:CGRectMake(25, 380, 100.0f, 30.0f)];
     [youbl_lb setBackgroundColor:[UIColor clearColor]];
     [youbl_lb setTextColor:[UIColor whiteColor]];
     [youbl_lb setText:@"You"];
     [youbl_lb setTextAlignment:NSTextAlignmentCenter];
     [youbl_lb setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
     [MainView addSubview:youbl_lb];
     
     UILabel *younumbl= [[UILabel alloc]initWithFrame:CGRectMake(27, 404, 100.0f, 30.0f)];
     [younumbl setBackgroundColor:[UIColor clearColor]];
     [younumbl setTextColor:[UIColor whiteColor]];
     [younumbl setText:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"user_yearly_trees_count"]]];
     [younumbl setTextAlignment:NSTextAlignmentCenter];
     [younumbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
     [MainView addSubview:younumbl];
     
     
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
     [goal_bl setText:[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"goal"]]];
     [goal_bl setTextAlignment:NSTextAlignmentCenter];
     [goal_bl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
     [MainView addSubview:goal_bl];
     
     
     
     
     // UIImageView *biggray_circle=[[UIImageView alloc]initWithFrame:CGRectMake(50, 443, 101/2, 165/2)];
     UIImageView *bigwhite_tree=[[UIImageView alloc]init];
     bigwhite_tree.image=[UIImage imageNamed:@"usage-big-tree"];
     bigwhite_tree.backgroundColor=[UIColor clearColor];
     [MainView addSubview:bigwhite_tree];
     
     //UIImageView *bigblue_tree=[[UIImageView alloc]initWithFrame:CGRectMake(247, 483, 54/2, 84/2)];
     UIImageView *bigblue_tree=[[UIImageView alloc]init];
     bigblue_tree.image=[UIImage imageNamed:@"usage-small-tree"];
     bigblue_tree.backgroundColor=[UIColor clearColor];
     [MainView addSubview:bigblue_tree];
     
     
     if ([[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"user_yearly_trees_count"]] intValue] >[[NSString stringWithFormat:@"%@",[usagetree objectForKey:@"goal"]]intValue]) {
     
     bigwhite_tree.frame = CGRectMake(50, 443, 101/2, 165/2);
     bigblue_tree.frame = CGRectMake(247, 483, 54/2, 84/2);
     }
     else
     {
     bigwhite_tree.frame = CGRectMake(236, 443, 101/2, 165/2);
     bigblue_tree.frame = CGRectMake(62, 483, 54/2, 84/2);
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
    [footertreebutton setBackgroundImage:[UIImage imageNamed:@"footertreeselectedbtn"] forState:UIControlStateNormal];
    [footertreebutton setBackgroundImage:[UIImage imageNamed:@"footertreeselectedbtn"] forState:UIControlStateHighlighted];
    [footertreebutton addTarget:self action:@selector(footertree:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footertreebutton];
    
    
    footerco2btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerco2btn setFrame:CGRectMake(170.0f, 5.0f, 67/2, 68/2)];
    [footerco2btn setBackgroundImage:[UIImage imageNamed:@"footerco2btn"] forState:UIControlStateNormal];
    [footerco2btn setBackgroundImage:[UIImage imageNamed:@"footerco2btn"] forState:UIControlStateHighlighted];
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

-(void)budget:(UIButton *)sender{
    
    MMUsageBudgetViewController *model = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
    
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
-(void)footerco2:(UIButton *)sender{
    
    MMUsageCo2ViewController *model = [[MMUsageCo2ViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
}
-(void)footertree:(UIButton *)sender
{
    
    GraphView.hidden=YES;
}
-(void)BackClk:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
-(void)crossbutton:(UIButton *)sender{
    
    
    [BlackView removeFromSuperview];
    [CrossButton removeFromSuperview];
    [Goaolbackview removeFromSuperview];
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
