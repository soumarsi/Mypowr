//
//  MMAlertsViewController.m
//  MeterMaid
//
//  Created by Admin on 16/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMAlertsViewController.h"
#import "MMUsageTreeViewController.h"

@interface MMAlertsViewController ()

@end

@implementation MMAlertsViewController

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
	// Do any additional setup after loading the view.

    NSLog(@"MMAlertsViewController");
    
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
    [HeaderLbl setText:@"A L E R T S"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [MainView addSubview:HeaderLbl];
    
    //budget button ..........
    
    budgetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [budgetbtn setFrame:CGRectMake(35.0f, 80.0f, 90/2, 83/2)];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateNormal];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateHighlighted];
    //[budgetbtn addTarget:self action:@selector(budget:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:budgetbtn];
    
    
    //bill button ..........
    
    billbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billbtn setFrame:CGRectMake(150.0f, 82.0f, 50/2, 79/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateHighlighted];
    //[billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(250.0f, 89.0f, 74/2, 65/2)];
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

    ///====================///////======================//////====================
    
    UIView *scrollview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 140.0f, 320.0f, 385.0f)];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:scrollview];
    
    //scrollview................
    MainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 385.0f)];
    MainScroll.userInteractionEnabled=YES;
//    MainScroll.scrollEnabled=YES;
//    MainScroll.showsVerticalScrollIndicator=YES;
//    MainScroll.contentSize=CGSizeMake(300.0f, 601.0f);
    [scrollview addSubview:MainScroll];
    
    
    UIImageView *linetext = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 0.5f)];
    [linetext setImage:[UIImage imageNamed:@"divideimg"]];
    [MainScroll addSubview:linetext];
    
    // 1st eliment......////====///==/
    
    UILabel *Notificationlbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 3, 180, 25)];
    [Notificationlbl setBackgroundColor:[UIColor clearColor]];
    [Notificationlbl setText:@"Notifications"];
    [Notificationlbl setTextAlignment:NSTextAlignmentLeft];
    [Notificationlbl setTextColor:[UIColor whiteColor]];
    [Notificationlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainScroll addSubview:Notificationlbl];
    
    UILabel *Notificationtxt = [[UILabel alloc]initWithFrame:CGRectMake(30, 28, 200, 20)];
    [Notificationtxt setBackgroundColor:[UIColor clearColor]];
    [Notificationtxt setText:@"3 active"];
    [Notificationtxt setTextAlignment:NSTextAlignmentLeft];
    [Notificationtxt setTextColor:[UIColor colorWithRed:(230.0f/255.0f) green:(236.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f]];
    [Notificationtxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14.0f]];
    [MainScroll addSubview:Notificationtxt];
    
    
    Notification_Switch = [[UISwitch alloc] initWithFrame:CGRectMake(260.0f, 10, 50.0f,30.0f)];
    Notification_Switch.backgroundColor = [UIColor whiteColor];
    Notification_Switch.layer.cornerRadius = 16.0; // you must import QuartzCore to do this.
    Notification_Switch.transform = CGAffineTransformMakeScale(1.1, 1.1);
    Notification_Switch.tag = 1;
    //[Notification_Switch addTarget:self action:@selector(switchstate:) forControlEvents:UIControlEventValueChanged];
    Notification_Switch.onTintColor = [UIColor colorWithRed:(92.0f / 255.0f) green:(205.0f / 255.0f) blue:(250.0f / 255.0f) alpha:1];
    [Notification_Switch setOn:YES animated:YES];
    [MainScroll addSubview:Notification_Switch];
    
    
    ///2nd eliment......../////=====////..===
    
    
    UIImageView *linetext1 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 50.0f, 320.0f, 0.5f)];
    [linetext1 setImage:[UIImage imageNamed:@"divideimg"]];
    [MainScroll addSubview:linetext1];
    
    
    UILabel *personalizationlbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 53, 180, 25)];
    [personalizationlbl setBackgroundColor:[UIColor clearColor]];
    [personalizationlbl setText:@"Personalization"];
    [personalizationlbl setTextAlignment:NSTextAlignmentLeft];
    [personalizationlbl setTextColor:[UIColor whiteColor]];
    [personalizationlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainScroll addSubview:personalizationlbl];
    
    UILabel *personalizationtxt = [[UILabel alloc]initWithFrame:CGRectMake(30, 78, 200, 20)];
    [personalizationtxt setBackgroundColor:[UIColor clearColor]];
    [personalizationtxt setText:@"sdfdsf@dsfdw.com"];
    [personalizationtxt setTextAlignment:NSTextAlignmentLeft];
    [personalizationtxt setTextColor:[UIColor colorWithRed:(230.0f/255.0f) green:(236.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f]];
    [personalizationtxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14.0f]];
    [MainScroll addSubview:personalizationtxt];
    
    
    Personalization_Switch = [[UISwitch alloc] initWithFrame:CGRectMake(260.0f, 60, 50.0f,30.0f)];
    Personalization_Switch.backgroundColor = [UIColor whiteColor];
    Personalization_Switch.layer.cornerRadius = 16.0; // you must import QuartzCore to do this.
    Personalization_Switch.transform = CGAffineTransformMakeScale(1.1, 1.1);
    Personalization_Switch.tag = 2;
    //[Personalization_Switch addTarget:self action:@selector(switchstate:) forControlEvents:UIControlEventValueChanged];
    Personalization_Switch.onTintColor = [UIColor colorWithRed:(92.0f / 255.0f) green:(205.0f / 255.0f) blue:(250.0f / 255.0f) alpha:1];
    [Personalization_Switch setOn:YES animated:YES];
    [MainScroll addSubview:Personalization_Switch];
    
    ///3rd eliment...............////////////=========///////=========
    
    UIImageView *linetext2 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 100.0f, 320.0f, 0.5f)];
    [linetext2 setImage:[UIImage imageNamed:@"divideimg"]];
    [MainScroll addSubview:linetext2];
    
    UILabel *Paymentmethodlbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 103, 180, 25)];
    [Paymentmethodlbl setBackgroundColor:[UIColor clearColor]];
    [Paymentmethodlbl setText:@"Payment Methods"];
    [Paymentmethodlbl setTextAlignment:NSTextAlignmentLeft];
    [Paymentmethodlbl setTextColor:[UIColor whiteColor]];
    [Paymentmethodlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainScroll addSubview:Paymentmethodlbl];
    
    UILabel *Paymentmethodtxt = [[UILabel alloc]initWithFrame:CGRectMake(30, 128, 200, 20)];
    [Paymentmethodtxt setBackgroundColor:[UIColor clearColor]];
    [Paymentmethodtxt setText:@"Visa....123456"];
    [Paymentmethodtxt setTextAlignment:NSTextAlignmentLeft];
    [Paymentmethodtxt setTextColor:[UIColor colorWithRed:(230.0f/255.0f) green:(236.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f]];
    [Paymentmethodtxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14.0f]];
    [MainScroll addSubview:Paymentmethodtxt];
    
    
    Paymentmethods_Switch = [[UISwitch alloc] initWithFrame:CGRectMake(260.0f, 110, 50.0f,30.0f)];
    Paymentmethods_Switch.backgroundColor = [UIColor whiteColor];
    Paymentmethods_Switch.layer.cornerRadius = 16.0; // you must import QuartzCore to do this.
    Paymentmethods_Switch.transform = CGAffineTransformMakeScale(1.1, 1.1);
    Paymentmethods_Switch.tag = 3;
    //[Paymentmethods_Switch addTarget:self action:@selector(switchstate:) forControlEvents:UIControlEventValueChanged];
    Paymentmethods_Switch.onTintColor = [UIColor colorWithRed:(92.0f / 255.0f) green:(205.0f / 255.0f) blue:(250.0f / 255.0f) alpha:1];
    [Paymentmethods_Switch setOn:YES animated:YES];
    [MainScroll addSubview:Paymentmethods_Switch];
    
    
    ///4th eliment...............////////////=========///////=========
    
    UIImageView *linetext3 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 150.0f, 320.0f, 0.5f)];
    [linetext3 setImage:[UIImage imageNamed:@"divideimg"]];
    [MainScroll addSubview:linetext3];
    
    UILabel *Synclbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 153, 180, 25)];
    [Synclbl setBackgroundColor:[UIColor clearColor]];
    [Synclbl setText:@"Sync"];
    [Synclbl setTextAlignment:NSTextAlignmentLeft];
    [Synclbl setTextColor:[UIColor whiteColor]];
    [Synclbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainScroll addSubview:Synclbl];
    
    UILabel *Synctxt = [[UILabel alloc]initWithFrame:CGRectMake(30, 178, 200, 20)];
    [Synctxt setBackgroundColor:[UIColor clearColor]];
    [Synctxt setText:@"sync#.34567"];
    [Synctxt setTextAlignment:NSTextAlignmentLeft];
    [Synctxt setTextColor:[UIColor colorWithRed:(230.0f/255.0f) green:(236.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f]];
    [Synctxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14.0f]];
    [MainScroll addSubview:Synctxt];
    
    
    Sync_Switch = [[UISwitch alloc] initWithFrame:CGRectMake(260.0f, 160, 50.0f,30.0f)];
    Sync_Switch.backgroundColor = [UIColor whiteColor];
    Sync_Switch.layer.cornerRadius = 16.0; // you must import QuartzCore to do this.
    Sync_Switch.transform = CGAffineTransformMakeScale(1.1, 1.1);
    Sync_Switch.tag = 4;
    //[Paymentmethods_Switch addTarget:self action:@selector(switchstate:) forControlEvents:UIControlEventValueChanged];
    Sync_Switch.onTintColor = [UIColor colorWithRed:(92.0f / 255.0f) green:(205.0f / 255.0f) blue:(250.0f / 255.0f) alpha:1];
    [Sync_Switch setOn:YES animated:YES];
    [MainScroll addSubview:Sync_Switch];

    
    ///5th eliment...............////////////=========///////=========
    
    UIImageView *linetext4 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 0.5f)];
    [linetext4 setImage:[UIImage imageNamed:@"divideimg"]];
    [MainScroll addSubview:linetext4];
    
    UILabel *delaylbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 203, 180, 25)];
    [delaylbl setBackgroundColor:[UIColor clearColor]];
    [delaylbl setText:@"EMF Delay"];
    [delaylbl setTextAlignment:NSTextAlignmentLeft];
    [delaylbl setTextColor:[UIColor whiteColor]];
    [delaylbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainScroll addSubview:delaylbl];
    
    UILabel *delaytxt = [[UILabel alloc]initWithFrame:CGRectMake(30, 228, 200, 20)];
    [delaytxt setBackgroundColor:[UIColor clearColor]];
    [delaytxt setText:@"30 Second Delay On"];
    [delaytxt setTextAlignment:NSTextAlignmentLeft];
    [delaytxt setTextColor:[UIColor colorWithRed:(230.0f/255.0f) green:(236.0f/255.0f) blue:(240.0f/255.0f) alpha:1.0f]];
    [delaytxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14]];
    [MainScroll addSubview:delaytxt];
    
    
    Dealy_Switch = [[UISwitch alloc] initWithFrame:CGRectMake(260.0f, 210, 50.0f,30.0f)];
    Dealy_Switch.backgroundColor = [UIColor whiteColor];
    Dealy_Switch.layer.cornerRadius = 16.0; // you must import QuartzCore to do this.
    Dealy_Switch.transform = CGAffineTransformMakeScale(1.1, 1.1);
    Dealy_Switch.tag = 5;
    //[Paymentmethods_Switch addTarget:self action:@selector(switchstate:) forControlEvents:UIControlEventValueChanged];
    Dealy_Switch.onTintColor = [UIColor colorWithRed:(92.0f / 255.0f) green:(205.0f / 255.0f) blue:(250.0f / 255.0f) alpha:1];
    [Dealy_Switch setOn:YES animated:YES];
    [MainScroll addSubview:Dealy_Switch];
    
    
    UIImageView *linetext5 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 200.0f, 320.0f, 0.5f)];
    [linetext5 setImage:[UIImage imageNamed:@"divideimg"]];
    [MainScroll addSubview:linetext5];
    
    ///=================//////////=======================/////////================
    
    
    //backbutton.........................
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 530.0f, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Backbtn];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 526.0f, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;

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

-(void)usage:(UIButton *)sender{
    
 
}

-(void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
