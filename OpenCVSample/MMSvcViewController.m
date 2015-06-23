//
//  MMSvcViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 20/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMSvcViewController.h"
#import "MMSvcsubcategoryViewController.h"
#import "MMReportViewController.h"

@interface MMSvcViewController ()

@end

@implementation MMSvcViewController

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
    
    NSLog(@"MMSvcViewController");
    
    Svc_Array = [[NSMutableArray alloc]init];
    
    NSBundle *mainBundle = [NSBundle mainBundle] ;
    
    NSString *SvcStr = [[NSString alloc]init];
    
    SvcStr = [NSString stringWithFormat:@"%@%@",DOMAIN_APP_URL,[mainBundle objectForInfoDictionaryKey:@"SVC_CATEGORY"]];
    
 
    
    NSError *error=nil;
    
    
    NSData *SvcData=[NSData dataWithContentsOfURL:[NSURL URLWithString:SvcStr]options:NSDataReadingUncached error:&error];
    NSDictionary *Svc_categoryjson=[NSJSONSerialization JSONObjectWithData:SvcData options:kNilOptions error:&error];
    
    for(dict in Svc_categoryjson){
        
        [Svc_Array addObject:dict];
    }
    
    // Do any additional setup after loading the view.
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
    [outagebtn setFrame:CGRectMake(100.0f, 77.0f, 45.0f, 40.5f)];
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outageblnkbtn"] forState:UIControlStateNormal];
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outageblnkbtn"] forState:UIControlStateHighlighted];
    [outagebtn addTarget:self action:@selector(outage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:outagebtn];
    
    //svccall button.................
    
    svccallbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [svccallbtn setFrame:CGRectMake(170.0f,75.0f, 52.5f, 42.5f)];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svcblnkcall"] forState:UIControlStateNormal];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svcblnkcall"] forState:UIControlStateHighlighted];
   // [svccallbtn addTarget:self action:@selector(Svccall:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:svccallbtn];
    
    
    
    //Home button and text...............
    
    
    Homebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Homebtn setFrame:CGRectMake(37.0f,240.0f, 59.0f, 47.0f)];
    [Homebtn setBackgroundImage:[UIImage imageNamed:@"homebtn"] forState:UIControlStateNormal];
    [Homebtn setBackgroundImage:[UIImage imageNamed:@"homebtn"] forState:UIControlStateHighlighted];
    [Homebtn addTarget:self action:@selector(Home:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Homebtn];
    
    
    
    
    
    Homelbl = [[UILabel alloc]initWithFrame:CGRectMake(17.0f, 205.0f,130.0f, 30.0f)];
    [Homelbl setBackgroundColor:[UIColor clearColor]];
    [Homelbl setText:[NSString stringWithFormat:@"%@",[[Svc_Array objectAtIndex:0]objectForKey:@"category"]]];
    [Homelbl setTextAlignment:NSTextAlignmentLeft];
    [Homelbl setTextColor:[UIColor whiteColor]];
    [Homelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17.0f]];
    [MainView addSubview:Homelbl];
    
    
    
    UIView *homeview = [[UIView alloc]initWithFrame:CGRectMake(17.0f,204.0f, 130.0f, 80.0f)];
    [homeview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:homeview];
    
    
    UITapGestureRecognizer *hometap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Home:)];
    [homeview addGestureRecognizer:hometap];
    homeview.userInteractionEnabled = YES;
    
    
    
    //public light button and text...............
    
    
    publightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [publightbtn setFrame:CGRectMake(220.0f,240.0f, 55.0f, 51.5f)];
    [publightbtn setBackgroundImage:[UIImage imageNamed:@"publiclight"] forState:UIControlStateNormal];
    [publightbtn setBackgroundImage:[UIImage imageNamed:@"publiclight"] forState:UIControlStateHighlighted];
    [publightbtn addTarget:self action:@selector(Publight:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:publightbtn];
    
    
    
    publightlbl = [[UILabel alloc]initWithFrame:CGRectMake(190.0f, 205.0f,130.0f, 30.0f)];
    [publightlbl setBackgroundColor:[UIColor clearColor]];
    [publightlbl setText:[NSString stringWithFormat:@"%@",[[Svc_Array objectAtIndex:1]objectForKey:@"category"]]];
    [publightlbl setTextAlignment:NSTextAlignmentLeft];
    [publightlbl setTextColor:[UIColor whiteColor]];
    [publightlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17.0f]];
    [MainView addSubview:publightlbl];
    
    
    
    UIView *publightview = [[UIView alloc]initWithFrame:CGRectMake(190.0f,203.0f, 130.0f, 90.0f)];
    [publightview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:publightview];
    
    
    UITapGestureRecognizer *publighttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Publight:)];
    [publightview addGestureRecognizer:publighttap];
    publightview.userInteractionEnabled = YES;
    
       
    //outreach button and text...............
    
    
    
    outreachbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outreachbtn setFrame:CGRectMake(32.0f,400.0f, 79.5f, 43.0f)];
    [outreachbtn setBackgroundImage:[UIImage imageNamed:@"outreach"] forState:UIControlStateNormal];
    [outreachbtn setBackgroundImage:[UIImage imageNamed:@"outreach"] forState:UIControlStateHighlighted];
    [outreachbtn addTarget:self action:@selector(Outreach:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:outreachbtn];
    
    
    
    outreachlbl = [[UILabel alloc]initWithFrame:CGRectMake(27.0f, 452.0f,100.0f, 30.0f)];
    [outreachlbl setBackgroundColor:[UIColor clearColor]];
    [outreachlbl setText:[NSString stringWithFormat:@"%@",[[Svc_Array objectAtIndex:2]objectForKey:@"category"]]];
    [outreachlbl setTextAlignment:NSTextAlignmentLeft];
    [outreachlbl setTextColor:[UIColor whiteColor]];
    [outreachlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17.0f]];
    [MainView addSubview:outreachlbl];
    
    
    UIView *outreachview = [[UIView alloc]initWithFrame:CGRectMake(24.0f,400.0f, 110.0f, 100.0f)];
    [outreachview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:outreachview];
    
    
    UITapGestureRecognizer *outreachtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Outreach:)];
    [outreachview addGestureRecognizer:outreachtap];
    outreachview.userInteractionEnabled = YES;
    
    
    //other button and text...............
    
    
    otherbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherbtn setFrame:CGRectMake(220.0f,390.0f, 62.0f, 59.0f)];
    [otherbtn setBackgroundImage:[UIImage imageNamed:@"otherimg"] forState:UIControlStateNormal];
    [otherbtn setBackgroundImage:[UIImage imageNamed:@"otherimg"] forState:UIControlStateHighlighted];
    [otherbtn addTarget:self action:@selector(Other:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:otherbtn];
    
    
    
    otherlbl = [[UILabel alloc]initWithFrame:CGRectMake(225.0f, 452.0f,100.0f, 30.0f)];
    [otherlbl setBackgroundColor:[UIColor clearColor]];
    [otherlbl setText:[NSString stringWithFormat:@"%@",[[Svc_Array objectAtIndex:3]objectForKey:@"category"]]];
    //[otherlbl setText:@"OTHER"];
    [otherlbl setTextAlignment:NSTextAlignmentLeft];
    [otherlbl setTextColor:[UIColor whiteColor]];
    [otherlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17.0f]];
    [MainView addSubview:otherlbl];
    
    
    
    UIView *otherview = [[UIView alloc]initWithFrame:CGRectMake(220.0f,390.0f, 100.0f, 100.0f)];
    [otherview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:otherview];
    
    
    UITapGestureRecognizer *othertap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Other:)];
    [otherview addGestureRecognizer:othertap];
    otherview.userInteractionEnabled = YES;
    
    //meter logo.............
    
    
    meterlogo = [[UIImageView alloc]initWithFrame:CGRectMake(125.0f, 310.0f, 70.0f, 50.5f)];
    [meterlogo setImage:[UIImage imageNamed:@"meterlogo"]];
    [MainView addSubview:meterlogo];
    
    //backbutton.........................
    
//    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
//    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
//    [MainView addSubview:UsBackView8];
//    
//    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Backbtn setFrame:CGRectMake(25.0f, 528.0f, 54/2, 33)];
//    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
//    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
//    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
//    [MainView addSubview:Backbtn];
    

    
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

//-(void)back:(UIButton *)sender{
//
//}

//home button function...................

-(void)Home:(UIButton *)sender{
    
    MMSvcsubcategoryViewController *viewmodel = [[MMSvcsubcategoryViewController alloc]init];
    viewmodel.Svc_catid = [[Svc_Array objectAtIndex:0]objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults]setObject:[[Svc_Array objectAtIndex:0]objectForKey:@"id"] forKey:@"Svccatid"];
    [self.navigationController pushViewController:viewmodel animated:NO];
    
}

//public light button fuction.....................


-(void)Publight:(UIButton *)sender{
 
    
    MMSvcsubcategoryViewController *viewmodel = [[MMSvcsubcategoryViewController alloc]init];
    viewmodel.Svc_catid = [[Svc_Array objectAtIndex:1]objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults]setObject:[[Svc_Array objectAtIndex:1]objectForKey:@"id"] forKey:@"Svccatid"];
    [self.navigationController pushViewController:viewmodel animated:NO];
}

//outreach button function...........
-(void)Outreach:(UIButton *)sender{
    
    MMSvcsubcategoryViewController *viewmodel = [[MMSvcsubcategoryViewController alloc]init];
    viewmodel.Svc_catid = [[Svc_Array objectAtIndex:2]objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults]setObject:[[Svc_Array objectAtIndex:2]objectForKey:@"id"] forKey:@"Svccatid"];
    [self.navigationController pushViewController:viewmodel animated:NO];
}

//other button function........................

-(void)Other:(UIButton *)sender{
    
    MMSvcsubcategoryViewController *viewmodel = [[MMSvcsubcategoryViewController alloc]init];
    viewmodel.Svc_catid = [[Svc_Array objectAtIndex:3]objectForKey:@"id"];
    [[NSUserDefaults standardUserDefaults]setObject:[[Svc_Array objectAtIndex:2]objectForKey:@"id"] forKey:@"Svccatid"];
    [self.navigationController pushViewController:viewmodel animated:NO];
}

-(void)outage:(UIButton *)sender
{
    MMReportViewController *list = [[MMReportViewController alloc]init];
    [self.navigationController pushViewController:list animated:NO];
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
