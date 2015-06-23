//
//  MMReportPoleViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMReportPoleViewController.h"
#import "MMReportPoleMapViewController.h"
#import "MMReportViewController.h"
#import "MMSvcViewController.h"

@interface MMReportPoleViewController ()

@end

@implementation MMReportPoleViewController
@synthesize Pole_Id,Pole_Name;

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

    NSLog(@"MMReportPoleViewController");
    
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = 30.0f;
    if ([CLLocationManager locationServicesEnabled])
    {
        [locationManager startUpdatingLocation];
    }
    else
    {
        
    }
    
    ReportPole_Array = [[NSMutableArray alloc]init];
    
    NSBundle *mainBundle = [NSBundle mainBundle] ;
    
    NSString *ReportPoleStr = [[NSString alloc]init];
    
    ReportPoleStr = [NSString stringWithFormat:@"%@%@%@",DOMAIN_APP_URL,[mainBundle objectForInfoDictionaryKey:@"REPORTPOLE_CATEGORY"],Pole_Id];

    
    NSError *error=nil;
    
    
    NSData *ReportData=[NSData dataWithContentsOfURL:[NSURL URLWithString:ReportPoleStr]options:NSDataReadingUncached error:&error];
    NSDictionary *ReportPole_categoryjson=[NSJSONSerialization JSONObjectWithData:ReportData options:kNilOptions error:&error];
    
    for(NSDictionary *dict in ReportPole_categoryjson){
        
        [ReportPole_Array addObject:dict];
    }

    
    // Do any additional setup after loading the view.
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


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
    
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
    [HeaderLbl setText:@"REPORT"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [MainView addSubview:HeaderLbl];
    
    //outage button.................
    
    outagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outagebtn setFrame:CGRectMake(100.0f, 77.0f, 45.5f, 41.5f)];
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outagebtn"] forState:UIControlStateNormal];
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outagebtn"] forState:UIControlStateHighlighted];
    //[outagebtn addTarget:self action:@selector(outage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:outagebtn];
    
    //svccall button.................
    
    svccallbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [svccallbtn setFrame:CGRectMake(170.0f,77.0f, 53.0f, 43.0f)];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svccallbtn"] forState:UIControlStateNormal];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svccallbtn"] forState:UIControlStateHighlighted];
    [svccallbtn addTarget:self action:@selector(Svccall:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:svccallbtn];
    
    
    
    //Downpole button and text...............
    //Downpole button and text...............
    
    downpolebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [downpolebtn setFrame:CGRectMake(57.0f,244.0f, 48.0f, 42.5f)];
    [downpolebtn setBackgroundImage:[UIImage imageNamed:@"downpolebtn"] forState:UIControlStateNormal];
    [downpolebtn setBackgroundImage:[UIImage imageNamed:@"downpolebtn"] forState:UIControlStateHighlighted];
    [downpolebtn addTarget:self action:@selector(Downpole:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:downpolebtn];
    
    
    downpolelbl = [[UILabel alloc]initWithFrame:CGRectMake(35.0f, 205.0f,130.0f, 30.0f)];
    [downpolelbl setBackgroundColor:[UIColor clearColor]];
    [downpolelbl setText:[NSString stringWithFormat:@"%@",[[ReportPole_Array objectAtIndex:0]objectForKey:@"sub_category"]]];
    [downpolelbl setTextAlignment:NSTextAlignmentLeft];
    [downpolelbl setTextColor:[UIColor whiteColor]];
    [downpolelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17.0f]];
    [MainView addSubview:downpolelbl];
    
    
    
    UIView *downpoleview = [[UIView alloc]initWithFrame:CGRectMake(40.0f, 205.0f, 135.0f, 90.0f)];
    [downpoleview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:downpoleview];
    
    
    
    UITapGestureRecognizer *downpoletap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Downpole:)];
    [downpoleview addGestureRecognizer:downpoletap];
    downpoleview.userInteractionEnabled = YES;
    
    
    
    //pole fire button and text...............
    
    
    
    polefirebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [polefirebtn setFrame:CGRectMake(228.0f,240.0f, 37.0f, 52.0f)];
    [polefirebtn setBackgroundImage:[UIImage imageNamed:@"polefirebtn"] forState:UIControlStateNormal];
    [polefirebtn setBackgroundImage:[UIImage imageNamed:@"polefirebtn"] forState:UIControlStateHighlighted];
    [polefirebtn addTarget:self action:@selector(polefire:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:polefirebtn];
    
    
    polefirelbl = [[UILabel alloc]initWithFrame:CGRectMake(207.0f, 205.0f,100.0f, 30.0f)];
    [polefirelbl setBackgroundColor:[UIColor clearColor]];
    [polefirelbl setText:[NSString stringWithFormat:@"%@",[[ReportPole_Array objectAtIndex:1]objectForKey:@"sub_category"]]];
    [polefirelbl setTextAlignment:NSTextAlignmentLeft];
    [polefirelbl setTextColor:[UIColor whiteColor]];
    [polefirelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17.0f]];
    [MainView addSubview:polefirelbl];
    
    
    
    UIView *polefireview = [[UIView alloc]initWithFrame:CGRectMake(212.0f, 205.0f, 100.0f, 90.0f)];
    [polefireview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:polefireview];
    
    
    UITapGestureRecognizer *polefiretap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(polefire:)];
    [polefireview addGestureRecognizer:polefiretap];
    polefireview.userInteractionEnabled = YES;
    
    
    
    //WIRE button and text...............
    
    
    debrisbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [debrisbtn setFrame:CGRectMake(50.0f,385.0f, 68.0f, 56.5f)];
    [debrisbtn setBackgroundImage:[UIImage imageNamed:@"derbisbtn"] forState:UIControlStateNormal];
    [debrisbtn setBackgroundImage:[UIImage imageNamed:@"derbisbtn"] forState:UIControlStateHighlighted];
    [debrisbtn addTarget:self action:@selector(debris:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:debrisbtn];
    
    
    debrislbl = [[UILabel alloc]initWithFrame:CGRectMake(50.0f, 445.0f,100.0f, 30.0f)];
    [debrislbl setBackgroundColor:[UIColor clearColor]];
    [debrislbl setText:[NSString stringWithFormat:@"%@",[[ReportPole_Array objectAtIndex:2]objectForKey:@"sub_category"]]];
    [debrislbl setTextAlignment:NSTextAlignmentLeft];
    [debrislbl setTextColor:[UIColor whiteColor]];
    [debrislbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17.0f]];
    [MainView addSubview:debrislbl];
    
    
    
    UIView *debrisview = [[UIView alloc]initWithFrame:CGRectMake(50.0f,385.0f, 100.0f, 90.0f)];
    [debrisview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:debrisview];
    
    
    
    UITapGestureRecognizer *debristap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(debris:)];
    debrisview.userInteractionEnabled = YES;
    [debrisview addGestureRecognizer:debristap];
    
    
    //meter logo.............
    
    
    meterlogo = [[UIImageView alloc]initWithFrame:CGRectMake(125.0f, 310.0f, 70.0f, 50.5f)];
    [meterlogo setImage:[UIImage imageNamed:@"meterlogo"]];
    [MainView addSubview:meterlogo];
    
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

-(void)back:(UIButton *)sender{
    
    MMReportViewController *map = [[MMReportViewController alloc]init];
    [self.navigationController pushViewController:map animated:NO];
}

-(void)debris:(UIButton *)sender{
    
    [[NSUserDefaults standardUserDefaults]setObject:Pole_Id forKey:@"Pole_ID"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[ReportPole_Array objectAtIndex:2]objectForKey:@"id"]] forKey:@"PoleCAT_ID"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[ReportPole_Array objectAtIndex:2]objectForKey:@"sub_category"]] forKey:@"PoleCAT_NAME"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    MMReportPoleMapViewController *map = [[MMReportPoleMapViewController alloc]init];
    [self.navigationController pushViewController:map animated:NO];
    
}
-(void)Downpole:(UIButton *)sender{
    
    [[NSUserDefaults standardUserDefaults]setObject:Pole_Id forKey:@"Pole_ID"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[ReportPole_Array objectAtIndex:0]objectForKey:@"id"]] forKey:@"PoleCAT_ID"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[ReportPole_Array objectAtIndex:0]objectForKey:@"sub_category"]] forKey:@"PoleCAT_NAME"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    MMReportPoleMapViewController *map = [[MMReportPoleMapViewController alloc]init];
    [self.navigationController pushViewController:map animated:NO];
}

-(void)polefire:(UIButton *)sender{
    
    [[NSUserDefaults standardUserDefaults]setObject:Pole_Id forKey:@"Pole_ID"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[ReportPole_Array objectAtIndex:1]objectForKey:@"id"]] forKey:@"PoleCAT_ID"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[ReportPole_Array objectAtIndex:1]objectForKey:@"sub_category"]] forKey:@"PoleCAT_NAME"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    MMReportPoleMapViewController *map = [[MMReportPoleMapViewController alloc]init];
    [self.navigationController pushViewController:map animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)Svccall:(UIButton *)sender{
    
    MMSvcViewController *svc = [[MMSvcViewController alloc]init];
    [self.navigationController pushViewController:svc animated:NO];
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
