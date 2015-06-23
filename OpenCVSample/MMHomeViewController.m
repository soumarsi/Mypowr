//
//  MMHomeViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMHomeViewController.h"
#import "MMmapViewController.h"
#import "MMReportViewController.h"
#import "MPTestDriveViewController.h"
#import "MMSettingsViewController.h"
#import "MMusagebillViewController.h"
#import "MMUsageBudgetViewController.h"

@interface MMHomeViewController ()

@end

@implementation MMHomeViewController

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
    
    NSLog(@"homeviewcontroller");
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];
    
    MainView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,568)];
    MainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]];
    [self.view addSubview:MainView];
    
    //usage button and label................
    
    
    
    UILabel *Usage = [[UILabel alloc] initWithFrame:CGRectMake(40, 140, 300,40)];
    Usage.text = @"USAGE";
    Usage.textColor = [UIColor whiteColor];
    Usage.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    [MainView addSubview:Usage];
    
    
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(42.0f, 185.0f, 116/2, 84/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usagebtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usagebtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usagebutton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    
    UIView *usageview = [[UIView alloc]initWithFrame:CGRectMake(40, 140, 100, 90)];
    [usageview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:usageview];
    
    
    
    UITapGestureRecognizer *usagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usagebutton:)];
    [usageview addGestureRecognizer:usagetap];
    usageview.userInteractionEnabled = YES;
    
    
    //report button and label................
    
    
    
    UILabel *Report = [[UILabel alloc] initWithFrame:CGRectMake(200, 140, 100,40)];
    Report.text = @"REPORT";
    Report.textColor = [UIColor whiteColor];
    Report.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    [MainView addSubview:Report];
    
    
    
    reportbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reportbtn setFrame:CGRectMake(220.0f, 185.0f, 73/2, 99/2)];
    [reportbtn setBackgroundImage:[UIImage imageNamed:@"reportbtn"] forState:UIControlStateNormal];
    [reportbtn setBackgroundImage:[UIImage imageNamed:@"reportbtn"] forState:UIControlStateHighlighted];
    [reportbtn addTarget:self action:@selector(reportbutton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:reportbtn];
    
    
    
    UIView *reportview = [[UIView alloc]initWithFrame:CGRectMake(200, 120, 100, 100)];
    [reportview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:reportview];
    
    
    
    UITapGestureRecognizer *reporttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reportbutton:)];
    [reportview addGestureRecognizer:reporttap];
    reportview.userInteractionEnabled = YES;
    
    
    //Map button and label................
    
    
    
    UILabel *maplbl = [[UILabel alloc] initWithFrame:CGRectMake(52, 370, 100,40)];
    maplbl.text = @"MAP";
    maplbl.textColor = [UIColor whiteColor];
    maplbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    [MainView addSubview:maplbl];
    
    
    
    mapbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapbtn setFrame:CGRectMake(45.0f, 315.0f, 92/2, 103/2)];
    [mapbtn setBackgroundImage:[UIImage imageNamed:@"Mapbtn"] forState:UIControlStateNormal];
    [mapbtn setBackgroundImage:[UIImage imageNamed:@"Mapbtn"] forState:UIControlStateHighlighted];
    [mapbtn addTarget:self action:@selector(mapbutton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:mapbtn];
    
    
    
    UIView *mapview = [[UIView alloc]initWithFrame:CGRectMake(52, 370, 100, 100)];
    [mapview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:mapview];
    
    
    UITapGestureRecognizer *maptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapbutton:)];
    [mapview addGestureRecognizer:maptap];
    mapview.userInteractionEnabled = YES;
    
    
    
    //settings button and label................
    
    
    
    UILabel *settinglbl = [[UILabel alloc] initWithFrame:CGRectMake(200, 370, 100,40)];
    settinglbl.text = @"SETTINGS";
    settinglbl.textColor = [UIColor whiteColor];
    settinglbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    [MainView addSubview:settinglbl];
    
    
    settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingbtn setFrame:CGRectMake(210.0f, 315.0f, 116/2, 118/2)];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settingsbtn"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settingsbtn"] forState:UIControlStateHighlighted];
    [settingbtn addTarget:self action:@selector(settingbutton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:settingbtn];
    
    
    UIView *settingsview = [[UIView alloc]initWithFrame:CGRectMake(200, 350, 100, 100)];
    [settingsview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:settingsview];
    
    
    UITapGestureRecognizer *settingstap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settingbutton:)];
    [settingsview addGestureRecognizer:settingstap];
    settingsview.userInteractionEnabled = YES;
    
    //metermaid image..........
    
    UIImageView *meterlogo = [[UIImageView alloc]initWithFrame:CGRectMake(115.0f, 240.0f, 70.0f, 50.5f)];
    [meterlogo setImage:[UIImage imageNamed:@"meterlogo"]];
    [MainView addSubview:meterlogo];
    

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
    
    //user full name............
    
    fullnamelbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 480.0f, 180,40)];
    fullnamelbl.text = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"firstname"],[[NSUserDefaults standardUserDefaults]objectForKey:@"lastname"]];
    fullnamelbl.textColor = [UIColor whiteColor];
    [fullnamelbl setBackgroundColor:[UIColor clearColor]];
    [fullnamelbl setNumberOfLines:2];
    fullnamelbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:16];
    fullnamelbl.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:fullnamelbl];
    
    //signout button............
    
    signoutbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [signoutbtn setFrame:CGRectMake(210.0f, 480.0f, 90,87/2)];
    [signoutbtn setBackgroundImage:[UIImage imageNamed:@"signoutbtn"] forState:UIControlStateNormal];
    [signoutbtn setBackgroundImage:[UIImage imageNamed:@"signoutbtn"] forState:UIControlStateHighlighted];
    [signoutbtn addTarget:self action:@selector(signout:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:signoutbtn];
    // Do any additional setup after loading the view.
}
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
//map function...........

-(void)mapbutton:(UIButton *)sender{
    
    MMmapViewController *signup = [[MMmapViewController alloc]init];
    [self.navigationController pushViewController:signup animated:NO];
    
    
}
//report function............

-(void)reportbutton:(UIButton *)sender{
    
    MMReportViewController *set = [[MMReportViewController alloc]init];
    [self.navigationController pushViewController:set animated:NO];
    
}

//usage function........

-(void)usagebutton:(UIButton *)sender{
    
    MMUsageBudgetViewController *set = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:set animated:NO];
    
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

//settings function.....................

-(void)settingbutton:(UIButton *)sender{
    
    MMSettingsViewController *settng = [[MMSettingsViewController alloc]init];
    [self.navigationController pushViewController:settng animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
