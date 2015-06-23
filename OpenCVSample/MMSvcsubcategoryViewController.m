//
//  MMSvcsubcategoryViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 20/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMSvcsubcategoryViewController.h"
#import "MMSvcViewController.h"
#import "MMSvcscheduleViewController.h"
#import "CKCalendarView.h"
#import "MMReportViewController.h"
@interface MMSvcsubcategoryViewController ()<CKCalendarDelegate>
{
    CKCalendarView *calendar;
    NSMutableArray *DateArray,*FinalDatesOfMonth;
    BOOL FindingFirstDate;
    NSString *PreviousDate;
    int StartIndex;
}

@end

@implementation MMSvcsubcategoryViewController
@synthesize Svc_catid;

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
    NSLog(@"MMSvcsubcategoryViewController");
    
    FindingFirstDate=NO;
    StartIndex=1;
    [super viewDidLoad];
    FinalDatesOfMonth=[[NSMutableArray alloc]init];
    DateArray=[[NSMutableArray alloc]init];
    Svcsubcat_Array = [[NSMutableArray alloc]init];
    
    NSBundle *mainBundle = [NSBundle mainBundle] ;
    
    NSString *SvcsubStr = [[NSString alloc]init];
    
    SvcsubStr = [NSString stringWithFormat:@"%@%@%@",DOMAIN_APP_URL,[mainBundle objectForInfoDictionaryKey:@"SVC_SUBCATEGORY"],[[NSUserDefaults standardUserDefaults]objectForKey:@"Svccatid"]];

    
    NSError *error=nil;
    
    
    NSData *SvcsubcatData=[NSData dataWithContentsOfURL:[NSURL URLWithString:SvcsubStr]options:NSDataReadingUncached error:&error];
    NSDictionary *Svc_subcategoryjson=[NSJSONSerialization JSONObjectWithData:SvcsubcatData options:kNilOptions error:&error];
    
    for(dict in Svc_subcategoryjson){
        
        [Svcsubcat_Array addObject:dict];
    }
    

    calendar = [[CKCalendarView alloc] initWithStartDay:startMonday];
    
    calendar.delegate = self;
    calendar.hidden = YES;
    
    calendar.onlyShowCurrentMonth = YES;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    
      calendar.frame = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
   
    [self.view addSubview:calendar];
    
    
    // Do any additional setup after loading the view.
}

- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date {

    NSDateFormatter* theDateFormatter = [[NSDateFormatter alloc] init];
    [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter setDateFormat:@"dd-EEE"];
    
    //[DateArray addObject:[theDateFormatter stringFromDate:date]];
    
    if (!FindingFirstDate) {
        PreviousDate=[NSString stringWithFormat:@"%@",[[[NSString stringWithFormat:@"%@",[theDateFormatter stringFromDate:date]] componentsSeparatedByString:@"-"] objectAtIndex:0]];
        FindingFirstDate=YES;
        [FinalDatesOfMonth addObject:[NSString stringWithFormat:@"%@",[theDateFormatter stringFromDate:date]]];
    }

    if(StartIndex<32) {
        StartIndex++;
        if (![PreviousDate isEqualToString:[NSString stringWithFormat:@"%@",[[[NSString stringWithFormat:@"%@",[theDateFormatter stringFromDate:date]] componentsSeparatedByString:@"-"] objectAtIndex:0]]]) {
            [FinalDatesOfMonth addObject:[NSString stringWithFormat:@"%@",[theDateFormatter stringFromDate:date]]];
            PreviousDate=[NSString stringWithFormat:@"%@",[theDateFormatter stringFromDate:date]];
        }
        
    }
        
    
   

    
    
    
}




- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame {

}

- (void)localeDidChange {
    [calendar setLocale:[NSLocale currentLocale]];
    
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
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outageblnkbtn"] forState:UIControlStateNormal];
    [outagebtn setBackgroundImage:[UIImage imageNamed:@"outageblnkbtn"] forState:UIControlStateHighlighted];
    [outagebtn addTarget:self action:@selector(outage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:outagebtn];
    
    //svccall button.................
    
    svccallbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [svccallbtn setFrame:CGRectMake(170.0f,75.0f, 53.0f, 43.0f)];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svcblnkcall"] forState:UIControlStateNormal];
    [svccallbtn setBackgroundImage:[UIImage imageNamed:@"svcblnkcall"] forState:UIControlStateHighlighted];
    //[svccallbtn addTarget:self action:@selector(Svccall:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:svccallbtn];
    
    
    
    //linelocate button and text...............
    
    
    linelocatbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [linelocatbtn setFrame:CGRectMake(55.0f,243.0f, 62.5f, 39.0f)];
    [linelocatbtn setBackgroundImage:[UIImage imageNamed:@"linelocatebtn"] forState:UIControlStateNormal];
    [linelocatbtn setBackgroundImage:[UIImage imageNamed:@"linelocatebtn"] forState:UIControlStateHighlighted];
    [linelocatbtn addTarget:self action:@selector(Linelocate:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:linelocatbtn];
    

    linelocatlbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 200.0f,130.0f, 30.0f)];
    [linelocatlbl setBackgroundColor:[UIColor clearColor]];
    //[linelocatlbl setText:@"LINE LOCATE"];
    [linelocatlbl setText:[NSString stringWithFormat:@"%@",[[Svcsubcat_Array objectAtIndex:0]objectForKey:@"cat_name"]]];
    [linelocatlbl setTextAlignment:NSTextAlignmentLeft];
    [linelocatlbl setTextColor:[UIColor whiteColor]];
    [linelocatlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17.0f]];
    [MainView addSubview:linelocatlbl];
    
    
    
    UIView *linelocateview = [[UIView alloc]initWithFrame:CGRectMake(40.0f,200.0f, 130.0f, 80.0f)];
    [linelocateview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:linelocateview];
    
    
    UITapGestureRecognizer *linelocatetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Linelocate:)];
    [linelocateview addGestureRecognizer:linelocatetap];
    linelocateview.userInteractionEnabled = YES;
    
    
    
    //audit button and text...............
    
    
    auditbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [auditbtn setFrame:CGRectMake(225.0f,240.0f, 47.5f, 48.0f)];
    [auditbtn setBackgroundImage:[UIImage imageNamed:@"Auditbtn"] forState:UIControlStateNormal];
    [auditbtn setBackgroundImage:[UIImage imageNamed:@"Auditbtn"] forState:UIControlStateHighlighted];
    [auditbtn addTarget:self action:@selector(Audit:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:auditbtn];
    
    
    
    auditlbl = [[UILabel alloc]initWithFrame:CGRectMake(222.0f, 200.0f,100.0f, 30.0f)];
    [auditlbl setBackgroundColor:[UIColor clearColor]];
    //[auditlbl setText:@"AUDIT"];
    [auditlbl setText:[NSString stringWithFormat:@"%@",[[Svcsubcat_Array objectAtIndex:1]objectForKey:@"cat_name"]]];
    [auditlbl setTextAlignment:NSTextAlignmentLeft];
    [auditlbl setTextColor:[UIColor whiteColor]];
    [auditlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17.0f]];
    [MainView addSubview:auditlbl];
    
    
    
    UIView *auditview = [[UIView alloc]initWithFrame:CGRectMake(222.0f,197.0f, 100.0f, 90.0f)];
    [auditview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:auditview];
    
    
    UITapGestureRecognizer *audittap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Audit:)];
    [auditview addGestureRecognizer:audittap];
    auditview.userInteractionEnabled = YES;
    
    
    
    
    
    //treetirm button and text...............
    
    
    
    treetirmbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [treetirmbtn setFrame:CGRectMake(57.0f,394.0f, 41.0f, 50.0f)];
    [treetirmbtn setBackgroundImage:[UIImage imageNamed:@"treetirmbtn"] forState:UIControlStateNormal];
    [treetirmbtn setBackgroundImage:[UIImage imageNamed:@"treetirmbtn"] forState:UIControlStateHighlighted];
    [treetirmbtn addTarget:self action:@selector(Treetirm:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:treetirmbtn];
    
    
    
    treetirmlbl = [[UILabel alloc]initWithFrame:CGRectMake(38.0f, 452.0f,100.0f, 30.0f)];
    [treetirmlbl setBackgroundColor:[UIColor clearColor]];
    //[treetirmlbl setText:@"TREE TRIM"];
    [treetirmlbl setText:[NSString stringWithFormat:@"%@",[[Svcsubcat_Array objectAtIndex:2]objectForKey:@"cat_name"]]];
    [treetirmlbl setTextAlignment:NSTextAlignmentLeft];
    [treetirmlbl setTextColor:[UIColor whiteColor]];
    [treetirmlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17.0f]];
    [MainView addSubview:treetirmlbl];
    
    
    UIView *treetirmview = [[UIView alloc]initWithFrame:CGRectMake(38.0f,394.0f, 100.0f, 90.0f)];
    [treetirmview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:treetirmview];
    
    
    UITapGestureRecognizer *treetirmtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Treetirm:)];
    [treetirmview addGestureRecognizer:treetirmtap];
    treetirmview.userInteractionEnabled = YES;
    
    
    //other button and text...............
    
    
    otherbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [otherbtn setFrame:CGRectMake(220.0f,390.0f, 62.0f, 59.0f)];
    [otherbtn setBackgroundImage:[UIImage imageNamed:@"otherimg"] forState:UIControlStateNormal];
    [otherbtn setBackgroundImage:[UIImage imageNamed:@"otherimg"] forState:UIControlStateHighlighted];
    [otherbtn addTarget:self action:@selector(Other:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:otherbtn];
    
    
    
    otherlbl = [[UILabel alloc]initWithFrame:CGRectMake(225.0f, 452.0f,100.0f, 30.0f)];
    [otherlbl setBackgroundColor:[UIColor clearColor]];
    [otherlbl setText:[NSString stringWithFormat:@"%@",[[Svcsubcat_Array objectAtIndex:3]objectForKey:@"cat_name"]]];
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

    //[self Filtering];

}
-(void)Filtering
{
 
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
    
    MMSvcViewController *viewmodel = [[MMSvcViewController alloc]init];
    [self.navigationController pushViewController:viewmodel animated:NO];
    
}

//line locate button function.............
-(void)Linelocate:(UIButton *)sender{

    MMSvcscheduleViewController *viewmodel = [[MMSvcscheduleViewController alloc]init];
    [viewmodel setArrayOfMonthDates:FinalDatesOfMonth];
    viewmodel.Cat_id = [[Svcsubcat_Array objectAtIndex:0]objectForKey:@"cat_id"];
    viewmodel.SubCat_id = [[Svcsubcat_Array objectAtIndex:0]objectForKey:@"id"];
    viewmodel.svcstring = @"linelocate";
    [self.navigationController pushViewController:viewmodel animated:NO];
    
}

//Audit button function........

-(void)Audit:(UIButton *)sender{

    MMSvcscheduleViewController *viewmodel = [[MMSvcscheduleViewController alloc]init];
    [viewmodel setArrayOfMonthDates:FinalDatesOfMonth];
    viewmodel.Cat_id = [[Svcsubcat_Array objectAtIndex:1]objectForKey:@"cat_id"];
    viewmodel.SubCat_id = [[Svcsubcat_Array objectAtIndex:1]objectForKey:@"id"];
    viewmodel.svcstring = @"audit";
    [self.navigationController pushViewController:viewmodel animated:NO];
    
}

//Tree Trim button function..........
-(void)Treetirm:(UIButton *)sender{

    MMSvcscheduleViewController *viewmodel = [[MMSvcscheduleViewController alloc]init];
    [viewmodel setArrayOfMonthDates:FinalDatesOfMonth];
    viewmodel.Cat_id = [[Svcsubcat_Array objectAtIndex:2]objectForKey:@"cat_id"];
    viewmodel.SubCat_id = [[Svcsubcat_Array objectAtIndex:2]objectForKey:@"id"];
    viewmodel.svcstring = @"treetirm";
    [self.navigationController pushViewController:viewmodel animated:NO];
}

//other button function...............

-(void)Other:(UIButton *)sender{

    MMSvcscheduleViewController *viewmodel = [[MMSvcscheduleViewController alloc]init];
    [viewmodel setArrayOfMonthDates:FinalDatesOfMonth];
    viewmodel.Cat_id = [[Svcsubcat_Array objectAtIndex:3]objectForKey:@"cat_id"];
    viewmodel.SubCat_id = [[Svcsubcat_Array objectAtIndex:3]objectForKey:@"id"];
    viewmodel.svcstring = @"other";
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
