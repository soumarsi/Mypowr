//
//  MMReportViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMReportViewController.h"
#import "MMReportPoleViewController.h"
#import "MMHomeViewController.h"
#import "MMSvcViewController.h"

@interface MMReportViewController ()

@end

@implementation MMReportViewController

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
    
    NSLog(@"mmreportviewcontroller");
    
    // Do any additional setup after loading the view.
    
    Report_Array = [[NSMutableArray alloc]init];
    
    NSBundle *mainBundle = [NSBundle mainBundle] ;
    
    NSString *ReportStr = [[NSString alloc]init];
    
    ReportStr = [NSString stringWithFormat:@"%@%@",DOMAIN_APP_URL,[mainBundle objectForInfoDictionaryKey:@"REPORT_CATEGORY"]];
    NSError *error=nil;
    NSData *ReportData=[NSData dataWithContentsOfURL:[NSURL URLWithString:ReportStr]options:NSDataReadingUncached error:&error];
    NSDictionary *Report_categoryjson=[NSJSONSerialization JSONObjectWithData:ReportData options:kNilOptions error:&error];
    
    for(dict in Report_categoryjson){
        
        [Report_Array addObject:dict];
    }
    
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
    //[HeaderLbl setFont:[UIFont systemFontOfSize:25.0f]];
    [MainView addSubview:HeaderLbl];
    
    //outage button.................
    
    outagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outagebtn setFrame:CGRectMake(100.0f, 77.0f, 45.5f, 41.5f)];
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outagebtn"] forState:UIControlStateNormal];
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outagebtn"] forState:UIControlStateHighlighted];
    //    [outagebtn addTarget:self action:@selector(outage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:outagebtn];
    
    //svccall button.................
    
    svccallbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [svccallbtn setFrame:CGRectMake(170.0f,77.0f, 53.0f, 43.0f)];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svccallbtn"] forState:UIControlStateNormal];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svccallbtn"] forState:UIControlStateHighlighted];
    [svccallbtn addTarget:self action:@selector(Svccall:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:svccallbtn];
    
    
    
    //inside button and text...............
    
    
    insidebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [insidebtn setFrame:CGRectMake(50.0f,190.0f, 50.0f, 40.0f)];
    [insidebtn setBackgroundImage:[UIImage imageNamed:@"insidebtn"] forState:UIControlStateNormal];
    [insidebtn setBackgroundImage:[UIImage imageNamed:@"insidebtn"] forState:UIControlStateHighlighted];
    //    [insidebtn addTarget:self action:@selector(inside:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:insidebtn];
    
    
    
    
    
    insidelbl = [[UILabel alloc]initWithFrame:CGRectMake(47.0f, 155.0f,100.0f, 30.0f)];
    [insidelbl setBackgroundColor:[UIColor clearColor]];
    //[insidelbl setText:@"INSIDE"];
    [insidelbl setText:[NSString stringWithFormat:@"%@",[[Report_Array objectAtIndex:0]objectForKey:@"parent_category"]]];
    [insidelbl setTextAlignment:NSTextAlignmentLeft];
    [insidelbl setTextColor:[UIColor whiteColor]];
    [insidelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:15.0f]];
    [MainView addSubview:insidelbl];
    
    
    
    UIView *insideview = [[UIView alloc]initWithFrame:CGRectMake(45.0f,154.0f, 100.0f, 80.0f)];
    [insideview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:insideview];
    
    
    //    UITapGestureRecognizer *insidetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(inside:)];
    //    [insideview addGestureRecognizer:insidetap];
    //    insideview.userInteractionEnabled = YES;
    
    
    
    //pole button and text...............
    
    
    polebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [polebtn setFrame:CGRectMake(225.0f,190.0f, 37.0f, 52.5f)];
    [polebtn setBackgroundImage:[UIImage imageNamed:@"polebtn"] forState:UIControlStateNormal];
    [polebtn setBackgroundImage:[UIImage imageNamed:@"polebtn"] forState:UIControlStateHighlighted];
    [polebtn addTarget:self action:@selector(pole:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:polebtn];
    
    
    
    polelbl = [[UILabel alloc]initWithFrame:CGRectMake(222.0f, 155.0f,100.0f, 30.0f)];
    [polelbl setBackgroundColor:[UIColor clearColor]];
    [polelbl setText:[NSString stringWithFormat:@"%@",[[Report_Array objectAtIndex:1]objectForKey:@"parent_category"]]];
    [polelbl setTextAlignment:NSTextAlignmentLeft];
    [polelbl setTextColor:[UIColor whiteColor]];
    [polelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:15.0f]];
    [MainView addSubview:polelbl];
    
    
    
    UIView *poleview = [[UIView alloc]initWithFrame:CGRectMake(222.0f,153.0f, 100.0f, 90.0f)];
    [poleview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:poleview];
    
    
    UITapGestureRecognizer *poletap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pole:)];
    [poleview addGestureRecognizer:poletap];
    poleview.userInteractionEnabled = YES;
    
    
    
    
    
    //WIRE button and text...............
    
    
    
    wirebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [wirebtn setFrame:CGRectMake(50.0f,335.0f, 39.0f, 47.5f)];
    [wirebtn setBackgroundImage:[UIImage imageNamed:@"wire"] forState:UIControlStateNormal];
    [wirebtn setBackgroundImage:[UIImage imageNamed:@"wire"] forState:UIControlStateHighlighted];
    //    [wirebtn addTarget:self action:@selector(wire:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:wirebtn];
    
    
    
    wirelbl = [[UILabel alloc]initWithFrame:CGRectMake(50.0f, 387.0f,100.0f, 30.0f)];
    [wirelbl setBackgroundColor:[UIColor clearColor]];
    [wirelbl setText:[NSString stringWithFormat:@"%@",[[Report_Array objectAtIndex:2]objectForKey:@"parent_category"]]];
    [wirelbl setTextAlignment:NSTextAlignmentLeft];
    [wirelbl setTextColor:[UIColor whiteColor]];
    [wirelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:15.0f]];
    [MainView addSubview:wirelbl];
    
    
    UIView *wireview = [[UIView alloc]initWithFrame:CGRectMake(50.0f,335.0f, 100.0f, 100.0f)];
    [wireview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:wireview];
    
    
    //    UITapGestureRecognizer *wiretap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(wire:)];
    //    [wireview addGestureRecognizer:wiretap];
    //    wireview.userInteractionEnabled = YES;
    
    
    //parts button and text...............
    
    
    partsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [partsbtn setFrame:CGRectMake(225.0f,335.0f, 37.0f, 52.5f)];
    [partsbtn setBackgroundImage:[UIImage imageNamed:@"parts"] forState:UIControlStateNormal];
    [partsbtn setBackgroundImage:[UIImage imageNamed:@"parts"] forState:UIControlStateHighlighted];
    //    [partsbtn addTarget:self action:@selector(parts:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:partsbtn];
    
    
    
    partslbl = [[UILabel alloc]initWithFrame:CGRectMake(218.0f, 387.0f,100.0f, 30.0f)];
    [partslbl setBackgroundColor:[UIColor clearColor]];
    [partslbl setText:[NSString stringWithFormat:@"%@",[[Report_Array objectAtIndex:3]objectForKey:@"parent_category"]]];
    [partslbl setTextAlignment:NSTextAlignmentLeft];
    [partslbl setTextColor:[UIColor whiteColor]];
    [partslbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:15.0f]];
    [MainView addSubview:partslbl];
    
    
    
    UIView *partsview = [[UIView alloc]initWithFrame:CGRectMake(220.0f,335.0f, 100.0f, 100.0f)];
    [partsview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:partsview];
    
    
    //    UITapGestureRecognizer *partstap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(parts:)];
    //    [partsview addGestureRecognizer:partstap];
    //    partsview.userInteractionEnabled = YES;
    
    //meter logo.............
    
    
    meterlogo = [[UIImageView alloc]initWithFrame:CGRectMake(125.0f, 260.0f, 70.0f, 50.5f)];
    [meterlogo setImage:[UIImage imageNamed:@"meterlogo"]];
    [MainView addSubview:meterlogo];
    
    // Emergency view....
    
    EmergencyView = [[UIView alloc]initWithFrame:CGRectMake(50.0f, 440.0f,220.0f, 70.0f)];
    [EmergencyView setBackgroundColor:[UIColor clearColor]];
    EmergencyView.layer.borderWidth = 1.8f;
    EmergencyView.layer.cornerRadius = 1.0f;
    EmergencyView.layer.borderColor = [[UIColor colorWithRed:(167.0f/255.0f) green:(190.0f/255.0f) blue:(207.0f/255.0f) alpha:1.0f]CGColor];
    [MainView addSubview:EmergencyView];
    
    Emergencylbl = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 1.0f,200.0f, 30.0f)];
    [Emergencylbl setBackgroundColor:[UIColor clearColor]];
    [Emergencylbl setText:@"If This Is An Emergency"];
    [Emergencylbl setTextAlignment:NSTextAlignmentCenter];
    [Emergencylbl setTextColor:[UIColor whiteColor]];
    [Emergencylbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17.0f]];
    [EmergencyView addSubview:Emergencylbl];
    
    CallLbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 30.0f,140.0f, 33.0f)];
    [CallLbl setBackgroundColor:[UIColor whiteColor]];
    [CallLbl setText:@"Call 911"];
    [CallLbl setTextAlignment:NSTextAlignmentCenter];
    [CallLbl setTextColor:[UIColor redColor]];
    [CallLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    CallLbl.layer.borderColor = [UIColor redColor].CGColor;
    CallLbl.layer.borderWidth = 2.0;
    [EmergencyView addSubview:CallLbl];
    
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
    
    //  [self.navigationController popViewControllerAnimated:NO];
    
    MMHomeViewController *home = [[MMHomeViewController alloc]init];
    [self.navigationController pushViewController:home animated:NO];
    
}

//pole button function.............

-(void)pole:(UIButton *)sender{
    
    MMReportPoleViewController *pole = [[MMReportPoleViewController alloc]init];
    pole.Pole_Id = [NSString stringWithFormat:@"%@",[[Report_Array objectAtIndex:1]objectForKey:@"id"]];
    
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[[Report_Array objectAtIndex:1]objectForKey:@"parent_category"]] forKey:@"Pole_NAME"];
    [self.navigationController pushViewController:pole animated:NO];
}

-(void)Svccall:(UIButton *)sender{
    
    MMSvcViewController *svc = [[MMSvcViewController alloc]init];
    [self.navigationController pushViewController:svc animated:NO];
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
