//
//  MMUsagePayViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMUsagePayViewController.h"
#import "MMusagesharebillViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMUsageTreeViewController.h"
#import "MMBillPayDetailsViewController.h"
#import "MMUsageEmailViewController.h"
#import "MMusagebillViewController.h"

@interface MMUsagePayViewController ()

@end

@implementation MMUsagePayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"MMUsagePayViewController");
    
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
    [budgetbtn setFrame:CGRectMake(30.0f, 80.0f, 90/2, 83/2)];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateNormal];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateHighlighted];
    [budgetbtn addTarget:self action:@selector(budget:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:budgetbtn];
    
    
    //bill button ..........
    
    billbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billbtn setFrame:CGRectMake(budgetbtn.frame.origin.x+budgetbtn.frame.size.width+35.0f,83.0f,50/2, 79/2)];//148.0f, 82.0f, 70/2, 84/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateHighlighted];
    //    [billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(billbtn.frame.origin.x+billbtn.frame.size.width+40.0f,90.0f, 74/2, 65/2)];//251, 83.0f, 74/2, 65/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    //phill button ..........
    
    phillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phillbtn setFrame:CGRectMake(usagebtn.frame.origin.x+usagebtn.frame.size.width+40.0f,83.0f, 56/2, 78/2)];//255, 83.0f, 56/2, 78/2)];
    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateNormal];
    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateHighlighted];
    //[phillbtn addTarget:self action:@selector(phill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:phillbtn];
    
    
    
    UIImageView *divideimg = [[UIImageView alloc]initWithFrame:CGRectMake(100.0f, 200.0f, 341/2, 0.5f)];
    [divideimg setImage:[UIImage imageNamed:@"divideimg"]];
    [MainView addSubview:divideimg];
    
    //============////////================
    
    UILabel *dollerimg = [[UILabel alloc]initWithFrame:CGRectMake(105.0f, 160.0f, 30.0f, 30.0f)];
    [dollerimg setText:@"$"];
    [dollerimg setTextAlignment:NSTextAlignmentLeft];
    [dollerimg setTextColor:[UIColor whiteColor]];
    [dollerimg setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20.0f]];
    [MainView addSubview:dollerimg];
    
    UILabel *amoutlbl = [[UILabel alloc]initWithFrame:CGRectMake(117.0f, 150.0f, 100.0f, 60.0f)];
    [amoutlbl setText:@"92.01"];
    [amoutlbl setTextAlignment:NSTextAlignmentLeft];
    [amoutlbl setTextColor:[UIColor whiteColor]];
    [amoutlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:38]];
    [MainView addSubview:amoutlbl];
    
    UILabel *datelbl = [[UILabel alloc]initWithFrame:CGRectMake(205.0f, 150.0f, 70.0f, 60.0f)];
    [datelbl setText:@"July Total"];
    datelbl.numberOfLines = 2;
    [datelbl setTextAlignment:NSTextAlignmentCenter];
    [datelbl setTextColor:[UIColor whiteColor]];
    [datelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [MainView addSubview:datelbl];
    
    
    UILabel *duelbl = [[UILabel alloc]initWithFrame:CGRectMake(18.0f, 167.0f, 40.0f, 10.0f)];
    [duelbl setText:@"DUE"];
    [duelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12.0f]];
    [duelbl setBackgroundColor:[UIColor clearColor]];
    [duelbl setTextAlignment:NSTextAlignmentCenter];
    [duelbl setTextColor:[UIColor whiteColor]];
    [MainView addSubview:duelbl];
    
    UIView *dateview = [[UIView alloc]initWithFrame:CGRectMake(15.0f, 182.0f, 45.0f, 35.0f)];
    [dateview setBackgroundColor:[UIColor lightTextColor]];
    [MainView addSubview:dateview];
    
    
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    
    NSString *string = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)day, (long)month, (long)year];
    NSLog(@"####### %@",string);
    
    
    UILabel *monthlbl = [[UILabel alloc]initWithFrame:CGRectMake(5.0f, 5.0f, 40.0f, 10.0f)];
    [monthlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12.0f]];
    //[monthlbl setText:strday];
    monthlbl.text = [NSString stringWithFormat:@"%ld%@", (long)month, @"/23"];
    [monthlbl setBackgroundColor:[UIColor clearColor]];
    [monthlbl setTextColor:[UIColor whiteColor]];
    [monthlbl setTextAlignment:NSTextAlignmentCenter];
    [dateview addSubview:monthlbl];
    
    
    NSDateFormatter *dateformate = [[NSDateFormatter alloc] init] ;
    [dateformate setDateFormat:@"EEEE"];
    NSLog(@"%@", [dateformate stringFromDate:[NSDate date]]);
    UILabel *daylbl=[[UILabel alloc]initWithFrame:CGRectMake(2.0f, 17.0f, 45.0f, 15.0f)];
    NSString *cutday=[dateformate stringFromDate:[NSDate date]];
    cutday = [cutday substringWithRange:NSMakeRange(0,3)];
    daylbl.text=cutday;
    daylbl.font = [UIFont fontWithName:GLOBALTEXTFONT size:12];
    [daylbl setBackgroundColor:[UIColor clearColor]];
    [daylbl setTextColor:[UIColor whiteColor]];
    [daylbl setTextAlignment:NSTextAlignmentCenter];
    [dateview addSubview:daylbl];
    
    
    
    
    //=======///=====////=====
    
    
    //    UIImageView *questionmark = [[UIImageView alloc]initWithFrame:CGRectMake(20.0f, 190.0f, 19.0f, 19.0f)];
    //    [questionmark setImage:[UIImage imageNamed:@"Questionmarkimg"]];
    //    [MainView addSubview:questionmark];
    
    
    
    
    //===========////=======//========
    
    
    UILabel *dollerimg1 = [[UILabel alloc]initWithFrame:CGRectMake(75.0f, 198.0f, 30.0f, 40.0f)];
    [dollerimg1 setText:@"$"];
    [dollerimg1 setTextAlignment:NSTextAlignmentCenter];
    [dollerimg1 setTextColor:[UIColor whiteColor]];
    [dollerimg1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20.0f]];
    [MainView addSubview:dollerimg1];
    
    UILabel *amoutlbl1 = [[UILabel alloc]initWithFrame:CGRectMake(97.0f, 195.0f, 120.0f, 60.0f)];
    [amoutlbl1 setText:@"178.73"];
    [amoutlbl1 setTextAlignment:NSTextAlignmentLeft];
    [amoutlbl1 setTextColor:[UIColor whiteColor]];
    [amoutlbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:38.0f]];
    [MainView addSubview:amoutlbl1];
    
    UILabel *datelbl1 = [[UILabel alloc]initWithFrame:CGRectMake(225.0f, 195.0f, 80.0f, 60.0f)];
    [datelbl1 setText:@"Grand Total"];
    datelbl1.numberOfLines = 2;
    [datelbl1 setTextAlignment:NSTextAlignmentLeft];
    [datelbl1 setTextColor:[UIColor whiteColor]];
    [datelbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [MainView addSubview:datelbl1];
    
    ///=============/////////==============//////
    
    UIImageView *detailsdivideimg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 280.0f, 320.0f, 1.0f)];
    [detailsdivideimg setImage:[UIImage imageNamed:@"divideimg"]];
    [MainView addSubview:detailsdivideimg];
    
    
    UIImageView *fractionimg1 = [[UIImageView alloc]initWithFrame:CGRectMake(220.0f, 305.0f, 45.0f, 35.0f)];
    [fractionimg1 setImage:[UIImage imageNamed:@"valuepercentageimg1"]];
    [MainView addSubview:fractionimg1];
    
    
    UIImageView *fractionimg2 = [[UIImageView alloc]initWithFrame:CGRectMake(220.0f, 360.0f, 45.0f, 35.0f)];
    [fractionimg2 setImage:[UIImage imageNamed:@"valuepercentageimg2"]];
    [MainView addSubview:fractionimg2];
    
    
    UIImageView *fractionimg3 = [[UIImageView alloc]initWithFrame:CGRectMake(220.0f, 415.0f, 45.0f, 35.0f)];
    [fractionimg3 setImage:[UIImage imageNamed:@"valuepercentageimg2"]];
    [MainView addSubview:fractionimg3];
    
    
    UIButton *plusbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusbtn setFrame:CGRectMake(220,470,45, 35)];
    [plusbtn setBackgroundImage:[UIImage imageNamed:@"plusbtn"] forState:UIControlStateNormal];
    //[plusbtn setBackgroundImage:[UIImage imageNamed:@"sideviewPrintimg"] forState:UIControlStateHighlighted];
    [plusbtn addTarget:self action:@selector(print_sidebtn:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:plusbtn];
    
    
    UIView *detailsview = [[UIView alloc]initWithFrame:CGRectMake(210.0f, 274.0f, 70.0f, 50.0f)];
    [detailsview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:detailsview];
    
    UITapGestureRecognizer *detailstap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailstap:)];
    [detailsview addGestureRecognizer:detailstap];
    detailsview.userInteractionEnabled = YES;
    
    //pay bill button.................
    
    
    UserName = [[UILabel alloc] initWithFrame:CGRectMake(10, 300.0f, 180,40)];
    UserName.text = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"firstname"],[[NSUserDefaults standardUserDefaults]objectForKey:@"lastname"]];
    UserName.textColor = [UIColor whiteColor];
    UserName.backgroundColor = [UIColor clearColor];
    UserName.numberOfLines = 2;
    UserName.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
    UserName.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:UserName];
    
    //    UserVisa = [[UILabel alloc] initWithFrame:CGRectMake(5,300.0f,130,40)];
    //    UserVisa.text = [NSString stringWithFormat:@"You"];
    //    UserVisa.textColor = [UIColor whiteColor];
    //    UserVisa.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
    //    UserVisa.textAlignment = NSTextAlignmentCenter;
    //    [MainView addSubview:UserVisa];
    UILabel *remainder = [[UILabel alloc] initWithFrame:CGRectMake(100,281,200,20)];
    remainder.text = [NSString stringWithFormat:@"REMAINDER   $0.00"];
    remainder.textColor = [UIColor whiteColor];
    remainder.font = [UIFont fontWithName:GLOBALTEXTFONT size:9];
    remainder.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:remainder];
    
    
    
    UILabel *Username1 = [[UILabel alloc] initWithFrame:CGRectMake(37,350.0f,130,40)];
    Username1.text = [NSString stringWithFormat:@"Becky Philips"];
    Username1.textColor = [UIColor whiteColor];
    Username1.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
    Username1.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:Username1];
    
    UILabel *Username2 = [[UILabel alloc] initWithFrame:CGRectMake(44,405.0f,130,40)];
    Username2.text = [NSString stringWithFormat:@"Rashad Pharon"];
    Username2.textColor = [UIColor whiteColor];
    Username2.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
    Username2.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:Username2];
    
    UILabel *synclbl=[[UILabel alloc] initWithFrame:CGRectMake(13,372.0f,130,40)];
    synclbl.text = [NSString stringWithFormat:@"Synced"];
    synclbl.textColor = [UIColor whiteColor];
    synclbl.font = [UIFont fontWithName:GLOBALTEXTFONT size:11];
    synclbl.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:synclbl];
    
    UILabel *notsynclbl=[[UILabel alloc] initWithFrame:CGRectMake(22,427.0f,130,40)];
    notsynclbl.text = [NSString stringWithFormat:@"Not Synced"];
    notsynclbl.textColor = [UIColor whiteColor];
    notsynclbl.font = [UIFont fontWithName:GLOBALTEXTFONT size:11];
    notsynclbl.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:notsynclbl];
    
    
    
    UserAcct = [[UILabel alloc] initWithFrame:CGRectMake(12,465.0f,130,40)];
    UserAcct.text = [NSString stringWithFormat:@"New"];
    UserAcct.textColor = [UIColor whiteColor];
    UserAcct.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
    UserAcct.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:UserAcct];
    
    
    //    paybillbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [paybillbutton setFrame:CGRectMake(206.0f, 390.0f, 90.0f, 43.5f)];
    //    [paybillbutton setBackgroundImage:[UIImage imageNamed:@"paybillbutton"] forState:UIControlStateNormal];
    //    [paybillbutton setBackgroundImage:[UIImage imageNamed:@"paybillbutton"] forState:UIControlStateHighlighted];
    // [paybillbutton addTarget:self action:@selector(paybill:) forControlEvents:UIControlEventTouchUpInside];
    //[MainView addSubview:paybillbutton];
    
    ////==============//////////////////=============
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    //back button ..........
    
    
    back = [UIButton buttonWithType:UIButtonTypeCustom];
    [back setFrame:CGRectMake(15.0f, 532.0f, 27.0f, 30.5f)];
    [back setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [back setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    //[paymethod addTarget:self action:@selector(paymethod:) forControlEvents:UIControlEventTouchUpInside];
    [back addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:back];
    
    
    //email button......
    
    UIButton *Emailbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Emailbtn setFrame:CGRectMake(100.0f, 532.3f, 27.0f, 32.0f)];
    [Emailbtn setBackgroundImage:[UIImage imageNamed:@"emailbtnimg"] forState:UIControlStateNormal];
    [Emailbtn setBackgroundImage:[UIImage imageNamed:@"emailbtnimg"] forState:UIControlStateHighlighted];
    [Emailbtn addTarget:self action:@selector(email:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Emailbtn];
    
    
    //share bill button ..........
    
    
    Sharebillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Sharebillbtn setFrame:CGRectMake(185.0f, 522.0f, 50.0f, 50.0f)];
    [Sharebillbtn setBackgroundImage:[UIImage imageNamed:@"sharebillbtnimg"] forState:UIControlStateNormal];
    [Sharebillbtn setBackgroundImage:[UIImage imageNamed:@"sharebillbtnimg"] forState:UIControlStateHighlighted];
    [Sharebillbtn addTarget:self action:@selector(sharebill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Sharebillbtn];
    
    
    //pay button......
    
    
    UIButton *paybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [paybtn setFrame:CGRectMake(280.0f, 531.0f, 20.5f, 30.5f)];
    [paybtn setBackgroundImage:[UIImage imageNamed:@"paybtnimg"] forState:UIControlStateNormal];
    [paybtn setBackgroundImage:[UIImage imageNamed:@"paybtnimg"] forState:UIControlStateHighlighted];
    //[paybtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
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

//plusbtn function.....

-(void)print_sidebtn:(UIButton *)sender
{
    
    UIView *dynaview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:dynaview];
    
    
    UIImageView *backimgview=[[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height)];
    backimgview.userInteractionEnabled=YES;
    [backimgview setImage:[UIImage imageNamed:@"dynamicviewbackground"]];
    [dynaview addSubview:backimgview];
    
    UILabel *mylbl1 = [[UILabel alloc] initWithFrame:CGRectMake(30,10,250,150)];
    mylbl1.text = [NSString stringWithFormat:@"Send a Split Bill request to someone who is also responsible for the bill."];
    mylbl1.textColor = [UIColor whiteColor];
    mylbl1.numberOfLines = 3;
    mylbl1.font = [UIFont fontWithName:GLOBALTEXTFONT size:18];
    mylbl1.textAlignment = NSTextAlignmentCenter;
    [dynaview addSubview:mylbl1];
    
    
    UILabel *mylbl2 = [[UILabel alloc] initWithFrame:CGRectMake(25,150,270,15)];
    mylbl2.text = [NSString stringWithFormat:@"Split Bill requires all parties to own a smartphone"];
    mylbl2.textColor = [UIColor whiteColor];
    mylbl2.numberOfLines = 1;
    mylbl2.font = [UIFont fontWithName:GLOBALTEXTFONT size:12];
    mylbl2.textAlignment = NSTextAlignmentCenter;
    [dynaview addSubview:mylbl2];
    
    
    UIView *row1=[[UIView alloc]initWithFrame:CGRectMake(0,168,[UIScreen mainScreen].bounds.size.width,40)];
    row1.userInteractionEnabled=YES;
    [row1 setBackgroundColor:[UIColor blackColor]];
    //[rowimg1 setImage:[UIImage imageNamed:@"dynaviewrow"]];
    row1.alpha=0.3;
    [dynaview addSubview:row1];
    
    UIView *row2=[[UIView alloc]initWithFrame:CGRectMake(0,212,[UIScreen mainScreen].bounds.size.width,40)];
    //[rowimg2 setImage:[UIImage imageNamed:@"dynaviewrow"]];
    [row2 setBackgroundColor:[UIColor blackColor]];
    row2.alpha=0.3;
    [dynaview addSubview:row2];
    
    UIView *row3=[[UIView alloc]initWithFrame:CGRectMake(0,256,[UIScreen mainScreen].bounds.size.width,40)];
    //[rowimg3 setImage:[UIImage imageNamed:@"dynaviewrow"]];
    [row3 setBackgroundColor:[UIColor blackColor]];
    row3.alpha=0.3;
    [dynaview addSubview:row3];
    
    UIView *row4=[[UIView alloc]initWithFrame:CGRectMake(0,300,[UIScreen mainScreen].bounds.size.width,40)];
    [row4 setBackgroundColor:[UIColor clearColor]];
    //[rowimg4 setImage:[UIImage imageNamed:@"dynaviewrow"]];
    [row4 setBackgroundColor:[UIColor blackColor]];
    row4.alpha=0.3;
    [dynaview addSubview:row4];
    
    
    UITextField *firsttxt = [[UITextField alloc] initWithFrame:CGRectMake(90,8,150,25)];
    UIColor *mycolor=[UIColor colorWithRed:255/255 green:255/255 blue:255/255 alpha:1];
    //firsttxt.text = [NSString stringWithFormat:@"First Name"];
    firsttxt.textColor = mycolor;
    firsttxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName:mycolor}];
    firsttxt.font = [UIFont fontWithName:GLOBALTEXTFONT size:18];
    firsttxt.textAlignment = NSTextAlignmentCenter;
    [row1 addSubview:firsttxt];
    
    UITextField *secondtxt = [[UITextField alloc] initWithFrame:CGRectMake(90,8,150,25)];
    //secondtxt.text = [NSString stringWithFormat:@"Last Name"];
    secondtxt.textColor = mycolor;
    secondtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    secondtxt.font = [UIFont fontWithName:GLOBALTEXTFONT size:18];
    secondtxt.textAlignment = NSTextAlignmentCenter;
    [backimgview addSubview:row2];
    [row2 addSubview:secondtxt];
    [dynaview addSubview:row2];
    
    UITextField *thirdtxt = [[UITextField alloc] initWithFrame:CGRectMake(90,8,150,25)];
    //secondtxt.text = [NSString stringWithFormat:@"Last Name"];
    thirdtxt.textColor = mycolor;
    thirdtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Mobile Number" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    thirdtxt.font = [UIFont fontWithName:GLOBALTEXTFONT size:18];
    thirdtxt.textAlignment = NSTextAlignmentCenter;
    [row3 addSubview:thirdtxt];
    
    UITextField *fourthtxt = [[UITextField alloc] initWithFrame:CGRectMake(90,8,150,25)];
    //secondtxt.text = [NSString stringWithFormat:@"Last Name"];
    fourthtxt.textColor = mycolor;
    fourthtxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Bill Percentage" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    fourthtxt.font = [UIFont fontWithName:GLOBALTEXTFONT size:18];
    fourthtxt.textAlignment = NSTextAlignmentCenter;
    [row4 addSubview:fourthtxt];
    
    checkbox = [[UIButton alloc]initWithFrame:CGRectMake(75.0f, 360.0f, 15.0f, 15.0f)];
    [checkbox setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    [checkbox addTarget:self action:@selector(checkbox:) forControlEvents:UIControlEventTouchUpInside];
    [dynaview addSubview:checkbox];
    
    UILabel *checklbl = [[UILabel alloc] initWithFrame:CGRectMake(checkbox.frame.origin.x+checkbox.frame.size.width+2.0f,360,220,15)];
    checklbl.text = [NSString stringWithFormat:@"Select to split Bill evenly."];
    checklbl.textColor = [UIColor whiteColor];
    checklbl.numberOfLines = 1;
    checklbl.font = [UIFont fontWithName:GLOBALTEXTFONT size:14];
    checklbl.textAlignment = NSTextAlignmentLeft;
    [dynaview addSubview:checklbl];
    
    
    UIView *subview = [[UIView alloc]initWithFrame:CGRectMake(0,455,[UIScreen mainScreen].bounds.size.width,45)];
    [subview setBackgroundColor:[UIColor blackColor]];
    subview.alpha=0.2;
    [dynaview addSubview:subview];
    
    
    UILabel *sublbl = [[UILabel alloc] initWithFrame:CGRectMake(30,470,280,15)];
    sublbl.text = [NSString stringWithFormat:@"We do not collect or use any information."];
    sublbl.textColor = [UIColor whiteColor];
    sublbl.alpha=1;
    sublbl.numberOfLines = 1;
    sublbl.font = [UIFont fontWithName:GLOBALTEXTFONT size:14];
    sublbl.textAlignment = NSTextAlignmentCenter;
    [dynaview addSubview:sublbl];
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor=[UIColor lightGrayColor];
    UsBackView8.alpha=0.2;
    [dynaview addSubview:UsBackView8];
    
    
    
    UIButton *dynaviewback = [UIButton buttonWithType:UIButtonTypeCustom];
    [dynaviewback setFrame:CGRectMake(15.0f, 532.0f, 27.0f, 30.5f)];
    [dynaviewback setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [dynaviewback setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [dynaviewback addTarget:self action:@selector(dynacancel:) forControlEvents:UIControlEventTouchUpInside];
    [dynaview addSubview:dynaviewback];
    
    
    UIButton *sendbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendbtn setFrame:CGRectMake(280.0f, 531.0f, 40.0f, 30.5f)];
    [sendbtn setBackgroundImage:[UIImage imageNamed:@"dynaviewsend"] forState:UIControlStateNormal];
    [sendbtn setBackgroundImage:[UIImage imageNamed:@"dynaviewsend"] forState:UIControlStateHighlighted];
    [sendbtn addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    [dynaview addSubview:sendbtn];
    
}

-(void)checkbox:(UIButton *)sender{
    
    NSLog(@"CHECK BOX TAPPED");
    
    if ([checkbox.currentImage isEqual:[UIImage imageNamed:@"uncheck"]]) {
        
        
        [checkbox setImage:[UIImage imageNamed:@"check"] forState:UIControlStateNormal];
        
    }else{
        
        [checkbox setImage:[UIImage imageNamed:@"uncheck"] forState:UIControlStateNormal];
    }
    
}


//dynamic view send button....

-(void)send:(UIButton *)sender
{
    
}

//dynamic view cancel button.....

-(void)dynacancel:(UIButton *)sender
{
    MMUsagePayViewController *backbill=[[MMUsagePayViewController alloc]init];
    [self.navigationController pushViewController:backbill animated:NO];
    
}

//cancel function............

-(void)cancel:(UIButton *)sender
{
    
    MMusagebillViewController *backtoprev =[[MMusagebillViewController alloc]init];
    [self.navigationController pushViewController:backtoprev animated:NO];
}
//share bill function............

-(void)sharebill:(UIButton *)sender{
    
    MMusagesharebillViewController *sharebill = [[MMusagesharebillViewController alloc]init];
    [self.navigationController pushViewController:sharebill animated:NO];
}
-(void)budget:(UIButton *)sender{
    
    MMUsageBudgetViewController *model = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
    
}

-(void)email:(UIButton *)sender{
    
    MMUsageEmailViewController *model = [[MMUsageEmailViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
    
}

-(void)pay:(UIButton *)sender
{
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *model = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
}


-(void)detailstap:(UIButton *)sender{
    
    MMBillPayDetailsViewController *view = [[MMBillPayDetailsViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
