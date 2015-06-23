//
//  MMSettingsViewController.m
//  MeterMaid
//
//  Created by Admin on 10/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMSettingsViewController.h"
#import "MPTestDriveViewController.h"
#import "MMSYNCViewController.h"
#import "MMProfileViewController.h"
#import "MMEmfDelayViewController.h"
#import "MMPaymentViewController.h"
#import "MMAlertsViewController.h"

@interface MMSettingsViewController ()

@end

@implementation MMSettingsViewController

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
    
    NSLog(@"MMSettingsViewController");
    
	// Do any additional setup after loading the view.
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];
    
    MainView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,568)];
    MainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]];
    [self.view addSubview:MainView];
    
    SettingsheaderLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(75.0f, 20.0f,170.0f, 40.0f)];
    [SettingsheaderLbl1 setBackgroundColor:[UIColor clearColor]];
    [SettingsheaderLbl1 setText:@"S E T T I N G S"];
    [SettingsheaderLbl1 setTextAlignment:NSTextAlignmentCenter];
    [SettingsheaderLbl1 setTextColor:[UIColor whiteColor]];
    [SettingsheaderLbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:23.0f]];
    [MainView addSubview:SettingsheaderLbl1];
    
    
    ////======================///////////=============
    
    UIImageView *textfieldview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 80, 320, 50)];
    textfieldview.image=[UIImage imageNamed:@"textfieldimg"];
    [MainView addSubview:textfieldview];
    
    UITapGestureRecognizer *alerttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alerttap:)];
    [textfieldview addGestureRecognizer:alerttap];
    textfieldview.userInteractionEnabled = YES;
    
    UIImageView *Alertimgview=[[UIImageView alloc]initWithFrame:CGRectMake(15, 92, 62/2, 54/2)];
    Alertimgview.image=[UIImage imageNamed:@"Alertimg"];
    [MainView addSubview:Alertimgview];
    
    
    UILabel *Alertlbl = [[UILabel alloc]initWithFrame:CGRectMake(45, 82, 80, 25)];
    [Alertlbl setBackgroundColor:[UIColor clearColor]];
    [Alertlbl setText:@"Alerts"];
    [Alertlbl setTextAlignment:NSTextAlignmentCenter];
    [Alertlbl setTextColor:[UIColor whiteColor]];
    [Alertlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainView addSubview:Alertlbl];
    
    UILabel *Alertltxt = [[UILabel alloc]initWithFrame:CGRectMake(80, 105, 80, 25)];
    [Alertltxt setBackgroundColor:[UIColor clearColor]];
    [Alertltxt setText:@"3 Active"];
    [Alertltxt setTextAlignment:NSTextAlignmentLeft];
    [Alertltxt setTextColor:[UIColor whiteColor]];
    [Alertltxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14.0f]];
    [MainView addSubview:Alertltxt];
    
    ////================///////////=======
    
    
    //Profile Section
    
    UIImageView *textfieldview1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 131, 320, 50)];
    textfieldview1.image=[UIImage imageNamed:@"textfieldimg"];
    [MainView addSubview:textfieldview1];
    
    UITapGestureRecognizer *profiletap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(profiletap:)];
    [textfieldview1 addGestureRecognizer:profiletap];
    textfieldview1.userInteractionEnabled = YES;
    
    UIImageView *Profileimgview=[[UIImageView alloc]initWithFrame:CGRectMake(15, 144, 52/2 ,48/2)];
    Profileimgview.image=[UIImage imageNamed:@"Profimg"];
    [MainView addSubview:Profileimgview];
    
    
    UILabel *Profilelbl = [[UILabel alloc]initWithFrame:CGRectMake(45, 133, 80, 25)];
    [Profilelbl setBackgroundColor:[UIColor clearColor]];
    [Profilelbl setText:@"Profile"];
    [Profilelbl setTextAlignment:NSTextAlignmentCenter];
    [Profilelbl setTextColor:[UIColor whiteColor]];
    [Profilelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainView addSubview:Profilelbl];
    
    UILabel *Profiletxt = [[UILabel alloc]initWithFrame:CGRectMake(80, 155, 200, 25)];
    [Profiletxt setBackgroundColor:[UIColor clearColor]];
    [Profiletxt setText:[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];
    [Profiletxt setTextAlignment:NSTextAlignmentLeft];
    [Profiletxt setTextColor:[UIColor whiteColor]];
    [Profiletxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14.0f]];
    [MainView addSubview:Profiletxt];
    
  ////==============////////////=======================
    
    //payment section..........................
    
    
    UIImageView *textfieldview2=[[UIImageView alloc]initWithFrame:CGRectMake(0, 182, 320, 50)];
    textfieldview2.image=[UIImage imageNamed:@"textfieldimg"];
    [MainView addSubview:textfieldview2];
    
    
    UITapGestureRecognizer *paymenttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(paymenttap:)];
    [textfieldview2 addGestureRecognizer:paymenttap];
    textfieldview2.userInteractionEnabled = YES;
    
    UIImageView *Paymentimgview=[[UIImageView alloc]initWithFrame:CGRectMake(13, 195, 68/2, 48/2)];
    Paymentimgview.image=[UIImage imageNamed:@"Paymentimg"];
    [MainView addSubview:Paymentimgview];
    
    
    UILabel *Paymentlbl = [[UILabel alloc]initWithFrame:CGRectMake(45, 186, 180, 25)];
    [Paymentlbl setBackgroundColor:[UIColor clearColor]];
    [Paymentlbl setText:@"Payment Methods"];
    [Paymentlbl setTextAlignment:NSTextAlignmentCenter];
    [Paymentlbl setTextColor:[UIColor whiteColor]];
    [Paymentlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainView addSubview:Paymentlbl];
    
    UILabel *Paymenttxt = [[UILabel alloc]initWithFrame:CGRectMake(80, 208, 200, 25)];
    [Paymenttxt setBackgroundColor:[UIColor clearColor]];
    [Paymenttxt setText:@"Visa.. 3098"];
    [Paymenttxt setTextAlignment:NSTextAlignmentLeft];
    [Paymenttxt setTextColor:[UIColor whiteColor]];
    [Paymenttxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14.0f]];
    [MainView addSubview:Paymenttxt];
  
    /////============================///////////==================
    
   
    ////===========;;;;;;;;==============
    //sync section.......................
    
  
    UIImageView *textfieldview3=[[UIImageView alloc]initWithFrame:CGRectMake(0, 233, 320, 50)];
    textfieldview3.image=[UIImage imageNamed:@"textfieldimg"];
    [MainView addSubview:textfieldview3];
    
    
    UITapGestureRecognizer *synctap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(synctap:)];
    [textfieldview3 addGestureRecognizer:synctap];
    textfieldview3.userInteractionEnabled = YES;
    
    UIImageView *Syncimgview=[[UIImageView alloc]initWithFrame:CGRectMake(15, 245, 69/2, 54/2)];
    Syncimgview.image=[UIImage imageNamed:@"Syncimg"];
    [MainView addSubview:Syncimgview];
    
    
    
    
    UILabel *Synclbl = [[UILabel alloc]initWithFrame:CGRectMake(40, 236, 80, 25)];
    [Synclbl setBackgroundColor:[UIColor clearColor]];
    [Synclbl setText:@"Sync"];
    [Synclbl setTextAlignment:NSTextAlignmentCenter];
    [Synclbl setTextColor:[UIColor whiteColor]];
    [Synclbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainView addSubview:Synclbl];
    
    UILabel *Synctxt = [[UILabel alloc]initWithFrame:CGRectMake(80, 258, 200, 25)];
    [Synctxt setBackgroundColor:[UIColor clearColor]];
    [Synctxt setText:@"Sync#: 3P78WB81"];
    [Synctxt setTextAlignment:NSTextAlignmentLeft];
    [Synctxt setTextColor:[UIColor whiteColor]];
    [Synctxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14.0f]];
    [MainView addSubview:Synctxt];
    
    /////===================//////////////////////
    
    ///emf delay..................
    
    UIImageView *textfieldview4=[[UIImageView alloc]initWithFrame:CGRectMake(0, 284, 320, 50)];
    textfieldview4.image=[UIImage imageNamed:@"textfieldimg"];
    [MainView addSubview:textfieldview4];
    
    
    UITapGestureRecognizer *emftap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(emftap:)];
    [textfieldview4 addGestureRecognizer:emftap];
    textfieldview4.userInteractionEnabled = YES;
    
    UIImageView *Emfimgview=[[UIImageView alloc]initWithFrame:CGRectMake(19, 294, 59/2, 59/2)];
    Emfimgview.image=[UIImage imageNamed:@"Emfimg"];
    [MainView addSubview:Emfimgview];
    
    
    UILabel *Emflbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 285, 180, 25)];
    [Emflbl setBackgroundColor:[UIColor clearColor]];
    [Emflbl setText:@"EMF Delay"];
    [Emflbl setTextAlignment:NSTextAlignmentCenter];
    [Emflbl setTextColor:[UIColor whiteColor]];
    [Emflbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainView addSubview:Emflbl];
    
    UILabel *Emftxt = [[UILabel alloc]initWithFrame:CGRectMake(80, 307, 200, 25)];
    [Emftxt setBackgroundColor:[UIColor clearColor]];
    [Emftxt setText:@"30 Sec Delay On"];
    [Emftxt setTextAlignment:NSTextAlignmentLeft];
    [Emftxt setTextColor:[UIColor whiteColor]];
    [Emftxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14.0f]];
    [MainView addSubview:Emftxt];
    
    
    //////======================//////=============
    
    //passcode section...............
    
    UIImageView *textfieldview5=[[UIImageView alloc]initWithFrame:CGRectMake(0, 360, 320, 50)];
    textfieldview5.image=[UIImage imageNamed:@"textfieldimg"];
    [MainView addSubview:textfieldview5];
    
    UIImageView *Passcodeimgview=[[UIImageView alloc]initWithFrame:CGRectMake(20.5, 367, 54/2, 66/2)];
    Passcodeimgview.image=[UIImage imageNamed:@"Passcodeimg"];
    [MainView addSubview:Passcodeimgview];
    
    
    UILabel *Passcodelbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 371, 180, 25)];
    [Passcodelbl setBackgroundColor:[UIColor clearColor]];
    [Passcodelbl setText:@"Passcode"];
    [Passcodelbl setTextAlignment:NSTextAlignmentCenter];
    [Passcodelbl setTextColor:[UIColor whiteColor]];
    [Passcodelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainView addSubview:Passcodelbl];
    
    UILabel *Footerlbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 458, 180, 37)];
    [Footerlbl setBackgroundColor:[UIColor clearColor]];
    [Footerlbl setText:[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"firstname"],[[NSUserDefaults standardUserDefaults]objectForKey:@"lastname"]]];
    [Footerlbl setTextAlignment:NSTextAlignmentCenter];
    [Footerlbl setTextColor:[UIColor whiteColor]];
    [Footerlbl setNumberOfLines:2];
    [Footerlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:16.0f]];
    [MainView addSubview:Footerlbl];
    
    UILabel *Footertxt = [[UILabel alloc]initWithFrame:CGRectMake(14, 490, 180, 25)];
    [Footertxt setBackgroundColor:[UIColor clearColor]];
    [Footertxt setText:@"Acct #:324567865"];
    [Footertxt setTextAlignment:NSTextAlignmentCenter];
    [Footertxt setTextColor:[UIColor whiteColor]];
    [Footertxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17.0f]];
    [MainView addSubview:Footertxt];
    
    ///======================///////////=====================
    

    UIButton *SignoutimageView = [UIButton buttonWithType:UIButtonTypeCustom];
    SignoutimageView.frame = CGRectMake(203.0f, 460, 100,50);
    [SignoutimageView setBackgroundImage:[UIImage imageNamed:@"signoutbtn"] forState:UIControlStateNormal];
    [SignoutimageView setBackgroundImage:[UIImage imageNamed:@"signoutbtn"] forState:UIControlStateHighlighted];
    [SignoutimageView addTarget:self action:@selector(signout:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:SignoutimageView];
    
    
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
}
//signout function...........
-(void)signout:(UIButton *)sender{
    
    
    NSString *logout=[[NSBundle mainBundle] bundleIdentifier];
    
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:logout];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    
     [[NSUserDefaults standardUserDefaults]setObject:@"facebook" forKey:@"fb"];
    
    MPTestDriveViewController *test = [[MPTestDriveViewController alloc]init];
    [self.navigationController pushViewController:test animated:NO];
    
}

///menu button function.....................
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
//alert button tap function.................

-(void)alerttap:(UIButton *)sender{
    

    MMAlertsViewController *profile = [[MMAlertsViewController alloc]init];
    [self.navigationController pushViewController:profile animated:NO];
    
}

//profile button tap function................

-(void)profiletap:(UITapGestureRecognizer *)sender{
    
    MMProfileViewController *profile = [[MMProfileViewController alloc]init];
    [self.navigationController pushViewController:profile animated:NO];
    
}

//emf delay tap function..................

-(void)emftap:(UIButton *)sender{
    
    MMEmfDelayViewController *emfdelay = [[MMEmfDelayViewController alloc]init];
    [self.navigationController pushViewController:emfdelay animated:NO];
    
    
}

//======sync tap function........

-(void)synctap:(UIButton *)sender{
    
    MMSYNCViewController *sync = [[MMSYNCViewController alloc]init];
    [self.navigationController pushViewController:sync animated:NO];
    
}

//==========payment tap function.........

-(void)paymenttap:(UIButton *)sender{
    
    MMPaymentViewController *sync = [[MMPaymentViewController alloc]init];
    [self.navigationController pushViewController:sync animated:NO];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
