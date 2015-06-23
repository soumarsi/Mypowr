//
//  MMLandingViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 09/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMLandingViewController.h"
#import "MPTestDriveViewController.h"
#import "MMHomeViewController.h"
#import "MMSvcscheduleViewController.h"
#import "MMQrcodeViewController.h"

@interface MMLandingViewController (){
    NSMutableArray *allFonts;
}

@end

@implementation MMLandingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"Landingviewcontroller");
    
    //backgroundView...................
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 30.0f;
   
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
   // [self updateCurrentLocation];
    

    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [self.view addSubview:MainView];
    
    
    //HeaderLabel.......................
    
    HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(85.0f, 20.0f,150.0f, 40.0f)];
    [HeaderLbl setBackgroundColor:[UIColor clearColor]];
    [HeaderLbl setText:@"H E L L O"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [MainView addSubview:HeaderLbl];
    
    
    HeaderTextlbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 80.0f,240.0f, 40.0f)];
    [HeaderTextlbl setBackgroundColor:[UIColor clearColor]];
    [HeaderTextlbl setText:@"How would you like to begin?"];
    [HeaderTextlbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderTextlbl setTextColor:[UIColor whiteColor]];
    [HeaderTextlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:18.0f]];
    [MainView addSubview:HeaderTextlbl];
    
    
    //QR code button and Text..............
    
    Qrlbl = [[UILabel alloc]initWithFrame:CGRectMake(35.0f, 150.0f,100.0f, 30.0f)];
    [Qrlbl setBackgroundColor:[UIColor clearColor]];
    [Qrlbl setText:@"QR CODE"];
    [Qrlbl setTextAlignment:NSTextAlignmentCenter];
    [Qrlbl setTextColor:[UIColor whiteColor]];
    [Qrlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17.0f]];
    [MainView addSubview:Qrlbl];
    
    
    Qrbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Qrbtn setFrame:CGRectMake(62.0f, 190.0f, 93/2, 93/2)];
    [Qrbtn setBackgroundImage:[UIImage imageNamed:@"QRcodebtnimg"] forState:UIControlStateNormal];
    [Qrbtn setBackgroundImage:[UIImage imageNamed:@"QRcodebtnimg"] forState:UIControlStateHighlighted];
    [Qrbtn addTarget:self action:@selector(qrbutton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Qrbtn];
    
    //testdrive button and text/...........
    
    
    Testdrivelbl = [[UILabel alloc]initWithFrame:CGRectMake(170.0f, 150.0f,120.0f, 30.0f)];
    [Testdrivelbl setBackgroundColor:[UIColor clearColor]];
    [Testdrivelbl setText:@"TEST DRIVE"];
    [Testdrivelbl setTextAlignment:NSTextAlignmentCenter];
    [Testdrivelbl setTextColor:[UIColor whiteColor]];
    [Testdrivelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17.0f]];
    [MainView addSubview:Testdrivelbl];
    
    
    Testdrivebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Testdrivebtn setFrame:CGRectMake(210.0f, 190.0f, 97/2, 98/2)];
    [Testdrivebtn setBackgroundImage:[UIImage imageNamed:@"Textdriveimg"] forState:UIControlStateNormal];
    [Testdrivebtn setBackgroundImage:[UIImage imageNamed:@"Textdriveimg"] forState:UIControlStateHighlighted];
    [Testdrivebtn addTarget:self action:@selector(Testdrive:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Testdrivebtn];
/// meterMaid icon set /////////
    
    UIImageView *meterMainicon=[[UIImageView alloc]initWithFrame:CGRectMake(100, 285, 230/2, 40/2)];
    meterMainicon.image=[UIImage imageNamed:@"mypwrLogo"];
    [MainView addSubview:meterMainicon];
    
 
  //sync button & text ///
    
    Synclbl = [[UILabel alloc]initWithFrame:CGRectMake(35.0f, 410.0f,100.0f, 30.0f)];
    [Synclbl setBackgroundColor:[UIColor clearColor]];
    [Synclbl setText:@"SYNC"];
    [Synclbl setTextAlignment:NSTextAlignmentCenter];
    [Synclbl setTextColor:[UIColor whiteColor]];
    [Synclbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17.0f]];
    [MainView addSubview:Synclbl];
    
    Syncbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Syncbtn setFrame:CGRectMake(55.0f, 350.0f, 119/2, 92/2)];
    [Syncbtn setBackgroundImage:[UIImage imageNamed:@"sync"] forState:UIControlStateNormal];
    [Syncbtn setBackgroundImage:[UIImage imageNamed:@"sync"] forState:UIControlStateHighlighted];
    //[Syncbtn addTarget:self action:@selector(Syncbtn:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Syncbtn];
    
    // about button & text ////
    
    Aboutlbl = [[UILabel alloc]initWithFrame:CGRectMake(185.0f, 410.0f,100.0f, 30.0f)];
    [Aboutlbl setBackgroundColor:[UIColor clearColor]];
    [Aboutlbl setText:@"ABOUT"];
    [Aboutlbl setTextAlignment:NSTextAlignmentCenter];
    [Aboutlbl setTextColor:[UIColor whiteColor]];
    [Aboutlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17.0f]];
    [MainView addSubview:Aboutlbl];

    Aboutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Aboutbtn setFrame:CGRectMake(210.0f, 350.0f, 96/2, 96/2)];
    [Aboutbtn setBackgroundImage:[UIImage imageNamed:@"Aboutbtnimg"] forState:UIControlStateNormal];
    [Aboutbtn setBackgroundImage:[UIImage imageNamed:@"Aboutbtnimg"] forState:UIControlStateHighlighted];
   // [Syncbtn addTarget:self action:@selector(Aboutbtn:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Aboutbtn];
    
 
    UILabel *downlbl=[[UILabel alloc]initWithFrame:CGRectMake(14, 530, 300,30)];
    downlbl.text=@"We are serious about privacy, View our policy";
    downlbl.textColor=[UIColor whiteColor];
    downlbl.textAlignment=NSTextAlignmentLeft;
    [downlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:12]];
    [MainView addSubview:downlbl];
    
    UILabel *here=[[UILabel alloc]initWithFrame:CGRectMake(268, 530, 40, 30)];
    here.textAlignment=NSTextAlignmentRight;
    here.text=@"here.";
    here.textColor=[UIColor blueColor];
    [here setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:12]];
    [MainView addSubview:here];
    
    //[self getAllFonts];
    allFonts=[[NSMutableArray alloc]init];
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationPortraitUpsideDown );
    }
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
}


//testdrivebutton function..................
-(void)getAllFonts {
    
    NSLog(@"-(void)getAllFonts");
    
    for(id familyName in [UIFont familyNames]){
        NSLog(@"FontFamily = %@",familyName);
        for(id fontName in [UIFont fontNamesForFamilyName:familyName]){
            [allFonts addObject:fontName];
            NSLog(@"Fonts at family %@ %@",fontName,familyName);
        }
    }
}


-(void)Testdrive:(UIButton *)sender{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"fb"] isEqualToString:@"facebook"] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"fb"] length] == 0) {
        
        NSString *logout=[[NSBundle mainBundle] bundleIdentifier];
        
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:logout];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        MPTestDriveViewController *test = [[MPTestDriveViewController alloc]init];
        [self.navigationController pushViewController:test animated:NO];
    }
    else{
        
        MMHomeViewController *home = [[MMHomeViewController alloc]init];
        [self.navigationController pushViewController:home animated:NO];
    }
    

    
    
}
-(void)qrbutton:(UIButton *)sender{
    
//    MMQrcodeViewController *test = [[MMQrcodeViewController alloc]init];
//    [self.navigationController pushViewController:test animated:NO];
    

}
- (void)updateCurrentLocation {
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
  
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude] forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude] forKey:@"long"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [locationManager stopUpdatingLocation];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    
    
    currentLocation = newLocation;
    
    if (currentLocation != nil) {

        
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude] forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude] forKey:@"long"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [locationManager stopUpdatingLocation];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
