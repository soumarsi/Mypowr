//
//  MMUsageBudgetViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMUsageBudgetViewController.h"
#import "MMusagebillViewController.h"
#import "MMUsageBudgetauditViewController.h"
#import "MMUsageTreeViewController.h"
#import "MMGlobalUrlClass.h"

#import "AbstractOCVViewController.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"
#import "ColorCircleViewController.h"
#import "AppDelegate.h"

@interface MMUsageBudgetViewController ()
{
    UIScrollView *ContainerScroll;
    NSMutableArray *ReadingArray;
    NSMutableArray *DateArray;
    
    
    /////
    
    UIButton *footerbackbtn;
    NSArray *ReturnArray;
    NSDictionary *ReturnDict;
    NSMutableArray *DateMonthArray;
    int MaxReading;
    AppDelegate *AppObj;
    
}
////// meterpurpose

@property(nonatomic,readwrite) UIImageView *imagecoming;
@property CGPoint circleCenter;
@property CGPoint location;
@property CGFloat  circleRadius;
@property(nonatomic,readwrite) NSMutableArray *CircleArray;
@property(nonatomic,readwrite) NSMutableDictionary *individualCircleDataDict;
@property(nonatomic,readwrite) NSArray *SortedCircleArray;
@property (nonatomic,readwrite) NSMutableArray *FirstKataXArray,*FirstKataYArray,*SecondKataXArray,*SecondKataYArray,*ThirdKataXArray,*ThirdKataYArray,*ForthKataXArray,*ForthKataYArray,*FifthKataXArray,*FifthKataYArray;


/////meterpurpose
@end

@implementation MMUsageBudgetViewController
@synthesize FirstKataXArray,FirstKataYArray,SecondKataXArray,SecondKataYArray,ThirdKataXArray,ThirdKataYArray,ForthKataXArray,ForthKataYArray,FifthKataXArray,FifthKataYArray;
@synthesize CircleArray,individualCircleDataDict,SortedCircleArray,imagecoming;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(int)returnPercentageOfGivvenInt:(int)InputInt
{
    //[[ReadingArray lastObject] intValue]
    int MAx=2000;
    int   returnInt=928*InputInt/MAx;
    
    return returnInt;
}





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"MMUsageBudgetViewController");
    
//    AppDelegate *AppObj=[[UIApplication sharedApplication]delegate];
    
    AppObj=[[UIApplication sharedApplication]delegate];
    
    NSLog(@"usage");
    
    Reading_Listarray = [[NSMutableArray alloc]init];
    
    
    NSBundle *mainBundle = [NSBundle mainBundle] ;
    
    NSString *Reading_Str = [[NSString alloc]init];
    
    Reading_Str = [NSString stringWithFormat:@"%@%@%@",DOMAIN_APP_URL,[mainBundle objectForInfoDictionaryKey:@"READING_LIST"],[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]];
    
    
    
    NSError *error=nil;
    
    
    NSData *Reading_Data=[NSData dataWithContentsOfURL:[NSURL URLWithString:Reading_Str]options:NSDataReadingUncached error:&error];
    Reading_json=[NSJSONSerialization JSONObjectWithData:Reading_Data options:kNilOptions error:&error];
    
    NSLog(@"resding json.... :%@",Reading_json);
    
    NSString *str = [NSString stringWithFormat:@"%@",[Reading_json objectForKey:@"reading_list"]];
    
    
    
    if ([Reading_json count] == 0) {
        
    }
    else{
        
        if ([str length] == 3) {
            
            
        }
        else{
            for(NSDictionary *dict in [Reading_json objectForKey:@"reading_list"]){
                
                [Reading_Listarray addObject:dict];
            }
            long count = [Reading_Listarray count];
            
            float monthreadvalue = [[NSString stringWithFormat:@"%@",[Reading_json objectForKey:@"perday_budget"]]floatValue];
            
            NSString *hightvalue = [NSString stringWithFormat:@"%@",[[Reading_Listarray objectAtIndex:count-1]objectForKey:@"date"]];
            NSArray *divide = [hightvalue componentsSeparatedByString:@" "];
            NSString *dividestr = [divide objectAtIndex:0];
            NSArray *valuearray = [dividestr componentsSeparatedByString:@"-"];
            float date = [[valuearray objectAtIndex:2]floatValue];
            float totalvalue = monthreadvalue * date;
            float monthmeterrding = [[NSString stringWithFormat:@"%@",[[Reading_Listarray objectAtIndex:count-1]objectForKey:@"meter_reading"]]floatValue];
            float totalmonthrding = monthmeterrding *0.07;
            float setbudget = [[NSString stringWithFormat:@"%@",[Reading_json objectForKey:@"budget"]]floatValue];
            float diff = (totalvalue - totalmonthrding)/setbudget;
            float different = diff*100;
            
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[Reading_json objectForKey:@"time"]] forKey:@"budgettime"];
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",different] forKey:@"budgetexceed"];
            
            
            
            ///////////////////////
            
            
            ReadingArray=[[NSMutableArray alloc]init];
            DateArray=[[NSMutableArray alloc]init];
            
        }
    }
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    
    
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
    [HeaderLbl setText:@"U S A G E"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [MainView addSubview:HeaderLbl];
    
    //budget button ..........
    
    budgetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [budgetbtn setFrame:CGRectMake(30.0f, 83.0f, 104/2, 85/2)];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"budgetselectedimg"] forState:UIControlStateNormal];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"budgetselectedimg"] forState:UIControlStateHighlighted];
    //[budgetbtn addTarget:self action:@selector(budget:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:budgetbtn];
    
    
    //bill button ..........
    
    billbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billbtn setFrame:CGRectMake(148.0f, 82.0f, 70/2, 84/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"Billselectedbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"Billselectedbtn"] forState:UIControlStateHighlighted];
    [billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(251, 91.0f, 74/2, 65/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    //phill button ..........
    
    //    phillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [phillbtn setFrame:CGRectMake(255, 84.0f, 56/2, 78/2)];
    //    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateNormal];
    //    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateHighlighted];
    //    [phillbtn addTarget:self action:@selector(phill:) forControlEvents:UIControlEventTouchUpInside];
    //    [MainView addSubview:phillbtn];
    
    ///================/////----------=================
    
    
    /***********OLDER CODE**************
     
     if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"budgetexceed"] length] == 0) {
     
     UILabel *dialogelbl = [[UILabel alloc]initWithFrame:CGRectMake(30.0f, 155.0f, 260.0f, 70.0f)];
     [dialogelbl setText:@"Please set budget and read your meter"];
     [dialogelbl setTextAlignment:NSTextAlignmentCenter];
     [dialogelbl setTextColor:[UIColor whiteColor]];
     [dialogelbl setBackgroundColor:[UIColor clearColor]];
     [dialogelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:25]];
     dialogelbl.numberOfLines = 2;
     [MainView addSubview:dialogelbl];
     
     }
     */
    
    
    /***********SANDEEP DUTTA START**************/
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"budgetexceed"] length] == 0) {
        
        UILabel *dialogelbl1 = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 155.0f, 80.0f, 70.0f)];
        dialogelbl1.backgroundColor=[UIColor redColor];
        [dialogelbl1 setText:@"12"];
        [dialogelbl1 setTextAlignment:NSTextAlignmentCenter];
        [dialogelbl1 setTextColor:[UIColor whiteColor]];
        [dialogelbl1 setBackgroundColor:[UIColor clearColor]];
        [dialogelbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:65]];
        dialogelbl1.numberOfLines = 2;
        [MainView addSubview:dialogelbl1];
        
        UILabel *dialogelbl2 = [[UILabel alloc]initWithFrame:CGRectMake(147.0f, 155.0f, 30.0f, 50.0f)];
        [dialogelbl2 setText:@"%"];
        dialogelbl2.backgroundColor=[UIColor greenColor];
        [dialogelbl2 setTextAlignment:NSTextAlignmentCenter];
        [dialogelbl2 setTextColor:[UIColor whiteColor]];
        [dialogelbl2 setBackgroundColor:[UIColor clearColor]];
        [dialogelbl2 setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:33]];
        dialogelbl2.numberOfLines = 1;
        [MainView addSubview:dialogelbl2];
        
        UILabel *dialogelbl3 = [[UILabel alloc]initWithFrame:CGRectMake(180.0f, 155.0f, 130.0f, 70.0f)];
        [dialogelbl3 setText:@"Over Budget"];
        [dialogelbl3 setTextAlignment:NSTextAlignmentLeft];
        [dialogelbl3 setTextColor:[UIColor whiteColor]];
        [dialogelbl3 setBackgroundColor:[UIColor clearColor]];
        [dialogelbl3 setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:23]];
        dialogelbl3.numberOfLines = 2;
        [MainView addSubview:dialogelbl3];
        
        UILabel *dialogelbl4 = [[UILabel alloc]initWithFrame:CGRectMake(91.0f, 210.0f, 125.0f, 30.0f)];
        [dialogelbl4 setText:@"Since Yesterday."];
        [dialogelbl4 setTextAlignment:NSTextAlignmentLeft];
        [dialogelbl4 setTextColor:[UIColor whiteColor]];
        [dialogelbl4 setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:14]];
        dialogelbl4.numberOfLines = 1;
        [MainView addSubview:dialogelbl4];
    }
    /***********SANDEEP DUTTA END**************/
    else{
        
        NSArray *array = [[[NSUserDefaults standardUserDefaults]objectForKey:@"budgetexceed"] componentsSeparatedByString:@"."];
        
        NSString *budgetfst = [array objectAtIndex:0];
        
        NSString *substr = [budgetfst substringToIndex:1];
        
        
        NSString *stringWithoutSpaces = [budgetfst stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        
        UILabel *overbdgt = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 155.0f, 137.0f, 60.0f)];
        [overbdgt setText:[NSString stringWithFormat:@"%@",stringWithoutSpaces]];
        [overbdgt setTextAlignment:NSTextAlignmentRight];
        [overbdgt setTextColor:[UIColor whiteColor]];
        [overbdgt setBackgroundColor:[UIColor clearColor]];
        [overbdgt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:60]];
        [MainView addSubview:overbdgt];
        
        UILabel *overbdgtpercent = [[UILabel alloc]initWithFrame:CGRectMake(140.0f, 155.0f, 50.0f, 40.0f)];
        [overbdgtpercent setText:@"%"];
        [overbdgtpercent setTextAlignment:NSTextAlignmentLeft];
        [overbdgtpercent setTextColor:[UIColor whiteColor]];
        [overbdgtpercent setBackgroundColor:[UIColor clearColor]];
        [overbdgtpercent setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:30]];
        [MainView addSubview:overbdgtpercent];
        
        
        
        UILabel *overbdgttext = [[UILabel alloc]initWithFrame:CGRectMake(175.0f, 155.0f, 100.0f, 60.0f)];
        if ([substr isEqualToString:@"-"]) {
            
            [overbdgttext setText:@"Over Budget"];
        }
        else{
            [overbdgttext setText:@"Below Budget"];
        }
        [overbdgttext setTextAlignment:NSTextAlignmentLeft];
        [overbdgttext setTextColor:[UIColor whiteColor]];
        overbdgttext.numberOfLines = 2;
        [overbdgttext setBackgroundColor:[UIColor clearColor]];
        [overbdgttext setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25]];
        [MainView addSubview:overbdgttext];
        
        
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(70.0f, 195.0f, 50.0f, 60.0f)];
        [text setText:@"Since"];
        [text setTextAlignment:NSTextAlignmentLeft];
        [text setTextColor:[UIColor whiteColor]];
        [text setBackgroundColor:[UIColor clearColor]];
        [text setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:18]];
        [MainView addSubview:text];
        
        
        
        UILabel *lstreadtxt = [[UILabel alloc]initWithFrame:CGRectMake(125.0f, 195.0f, 200.0f, 60.0f)];
        [lstreadtxt setText:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"budgettime"]]];
        [lstreadtxt setTextAlignment:NSTextAlignmentLeft];
        [lstreadtxt setTextColor:[UIColor whiteColor]];
        [lstreadtxt setBackgroundColor:[UIColor clearColor]];
        [lstreadtxt setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:18]];
        [MainView addSubview:lstreadtxt];
        
        //        UILabel *lasttext = [[UILabel alloc]initWithFrame:CGRectMake(225.0f, 195.0f, 40.0f, 60.0f)];
        //        [lasttext setText:@"ago"];
        //        [lasttext setTextAlignment:NSTextAlignmentLeft];
        //        [lasttext setTextColor:[UIColor whiteColor]];
        //        [lasttext setBackgroundColor:[UIColor clearColor]];
        //        [lasttext setFont:[UIFont fontWithName:@"Helvetica-LT-Light.ttf" size:20]];
        //        [lasttext setFont:[UIFont systemFontOfSize:18]];
        //        [MainView addSubview:lasttext];
        
    }
    /////=================------------------===///////////
    
    //footerview..........==========............============
    
    UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    /*******************OLDER CODE*********************/
    /* footerbudgtbtn = [UIButton buttonWithType:UIButtonTypeCustom];
     [footerbudgtbtn setFrame:CGRectMake(20.0f, 3.0f, 31.5f, 36.0f)];
     [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedbudgt"] forState:UIControlStateNormal];
     [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedbudgt"] forState:UIControlStateHighlighted];*/
    [UsBackView8 addSubview:footerbudgtbtn];
    /*******************OLDER CODE*********************/
    /*******************SANDEEP DUTTA*********************/
    footerbackbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerbackbtn setFrame:CGRectMake(20.0f, 3.0f, 31.5f, 36.0f)];
    // [footerbackbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedbudgt"] forState:UIControlStateNormal];
    //[footerbackbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedbudgt"] forState:UIControlStateHighlighted];
    [footerbackbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [footerbackbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [footerbackbtn addTarget:self action:@selector(footerback:) forControlEvents:UIControlEventTouchUpInside];
    footerbackbtn.userInteractionEnabled=YES;
    [UsBackView8 addSubview:footerbackbtn];
    [footerbackbtn bringSubviewToFront:UsBackView8];
    /*******************SANDEEP DUTTA*********************/
    //    [footerbudgtbtn addTarget:self action:@selector(footerbudght:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    footerauditbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerauditbtn setFrame:CGRectMake(105.0f, 5.0f, 23.0f, 33.0f)];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footeraudit"] forState:UIControlStateNormal];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footeraudit"] forState:UIControlStateHighlighted];
    [footerauditbtn addTarget:self action:@selector(footeraudit:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerauditbtn];
    
    
    footersetbudgt = [UIButton buttonWithType:UIButtonTypeCustom];
    [footersetbudgt setFrame:CGRectMake(180.0f, 3.0f, 48.5f, 37.0f)];
    [footersetbudgt setBackgroundImage:[UIImage imageNamed:@"footersetbudght"] forState:UIControlStateNormal];
    [footersetbudgt setBackgroundImage:[UIImage imageNamed:@"footersetbudght"] forState:UIControlStateHighlighted];
    [footersetbudgt addTarget:self action:@selector(footersetbudght:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footersetbudgt];
    
    
    footerupdtebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerupdtebtn setFrame:CGRectMake(270.0f, 5.0f, 32.0f, 35.0f)];
    [footerupdtebtn setBackgroundImage:[UIImage imageNamed:@"footerupdte"] forState:UIControlStateNormal];
    [footerupdtebtn setBackgroundImage:[UIImage imageNamed:@"footerupdte"] forState:UIControlStateHighlighted];
    [footerupdtebtn addTarget:self action:@selector(footerupdate:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerupdtebtn];
    
    ///////==================//////======
    
    ContainerScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(20, 300,self.view.frame.size.width*2, 200)];
    ContainerScroll.backgroundColor=[UIColor clearColor];
    [MainView addSubview:ContainerScroll];
    
    
    ///////////////////////////////////////////////////////////////////
    MaxReading=0;
    /*******************************SANDEEP DUTTA**************************/
    /*UIImageView *graphimg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 350.f, 310.0f, 106)];
     [graphimg setImage:[UIImage imageNamed:@"graphimg"]];
     [MainView addSubview:graphimg];
     
     
     UILabel *graphamout = [[UILabel alloc]initWithFrame:CGRectMake(183.0f, 377.0f, 70.0f, 40.0f)];
     [graphamout setText:@"92.01"];
     [graphamout setTextAlignment:NSTextAlignmentLeft];
     [graphamout setTextColor:[UIColor whiteColor]];
     [graphamout setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20]];
     [MainView addSubview:graphamout];
     
     UILabel *graphdate = [[UILabel alloc]initWithFrame:CGRectMake(160.0f,450.0f, 50.0f, 40.0f)];
     [graphdate setText:@"July Total"];
     graphdate.numberOfLines = 2;
     [graphdate setTextAlignment:NSTextAlignmentLeft];
     [graphdate setTextColor:[UIColor whiteColor]];
     [graphdate setFont:[UIFont fontWithName:GLOBALTEXTFONT size:13.0f]];
     [MainView addSubview:graphdate];
     
     UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(160.0f, 490.0f, 66.0f/2, 40.0f/2)];
     [img setImage:[UIImage imageNamed:@"menubtn"]];
     [MainView addSubview:img];*/
    
    /*******************************SANDEEP DUTTA EDIT**************************/
    
    UIImageView *graphimg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 310.f, 310.0f, 120.0f)];
    graphimg.backgroundColor = [UIColor clearColor];
    [graphimg setImage:[UIImage imageNamed:@"graphstatic"]];
    [MainView addSubview:graphimg];
    
    UILabel *graphSideDollar = [[UILabel alloc]initWithFrame:CGRectMake(graphimg.frame.origin.x+graphimg.frame.size.width-116.0f, graphimg.frame.origin.y+5.0f, 18.0f, 20.0f)];
    graphSideDollar.backgroundColor = [UIColor clearColor];
    graphSideDollar.text = @"$";
    graphSideDollar.textAlignment = NSTextAlignmentCenter;
    graphSideDollar.textColor = [UIColor whiteColor];
    graphSideDollar.font = [UIFont fontWithName:GLOBALTEXTFONT size:12.0f];
    [MainView addSubview:graphSideDollar];
    
    UILabel *graphSidePrice = [[UILabel alloc]initWithFrame:CGRectMake(graphSideDollar.frame.origin.x+graphSideDollar.frame.size.width, graphimg.frame.origin.y+2, 70.0f, 35.0f)];
    graphSidePrice.backgroundColor = [UIColor clearColor];
    graphSidePrice.text = [NSString stringWithFormat:@"111.93"];
    graphSidePrice.textAlignment = NSTextAlignmentLeft;
    graphSidePrice.textColor = [UIColor whiteColor];
    graphSidePrice.font = [UIFont fontWithName:GLOBALTEXTFONT size:21.0f];
    [MainView addSubview:graphSidePrice];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
    NSInteger week = [components month];
    NSInteger year = [components year];
    
    NSString *string = [NSString stringWithFormat:@"%ld.%ld.%ld", (long)day, (long)week, (long)year];
    
    NSLog(@"DATE--------> %@",string);
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    
    [df setDateFormat:@"MMM"];
    NSString *myMonthString = [[NSString alloc]init];
    myMonthString = [df stringFromDate:[NSDate date]];
    
    NSLog(@"MONTH------> %@",myMonthString);
    
    
    UILabel *dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, graphimg.frame.origin.y+graphimg.frame.size.height+1.0f, 180.0f, 25.0f)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:11.0f];
    dateLabel.text = [NSString stringWithFormat:@"%ld     %ld    %ld     %ld     %ld     %ld     %ld",day-7,day-6,day-5,day-4,day-3,day-2,day-1];
    [MainView addSubview:dateLabel];
    
    UILabel *dateLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(dateLabel.frame.origin.x+dateLabel.frame.size.width+2.0f, graphimg.frame.origin.y+graphimg.frame.size.height+1.0f, 30.0f, 28.0f)];
    dateLabel2.backgroundColor = [UIColor clearColor];
    dateLabel2.textColor = [UIColor whiteColor];
    dateLabel2.numberOfLines = 2;
    dateLabel2.font = [UIFont fontWithName:GLOBALTEXTFONT size:11.0f];
    dateLabel2.text = [NSString stringWithFormat:@"%@ \n %ld",myMonthString,day];
    [MainView addSubview:dateLabel2];

    
    /*
    UILabel *graphamount1 = [[UILabel alloc]initWithFrame:CGRectMake(183.0f, 337.0f, 31.0f, 40.0f)];
    [graphamount1 setText:@"111"];
    [graphamount1 setTextAlignment:NSTextAlignmentLeft];
    [graphamount1 setTextColor:[UIColor whiteColor]];
    [graphamount1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20]];
    // graphamount1.backgroundColor=[UIColor redColor];
    [MainView addSubview:graphamount1];
    
    UILabel *graphamount2 = [[UILabel alloc]initWithFrame:CGRectMake(213.0f, 338.0f, 70.0f, 40.0f)];
    [graphamount2 setText:@".93"];
    [graphamount2 setTextAlignment:NSTextAlignmentLeft];
    [graphamount2 setTextColor:[UIColor whiteColor]];
    [graphamount2 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:15]];
    [MainView addSubview:graphamount2];
    for(int i=4,j=0;i<=9;i++,j++)
    {
        UILabel *graphdate1 = [[UILabel alloc]initWithFrame:CGRectMake((11.0f+(27.0f*j)),418.0f, 10.0f, 10.0f)];
        // UILabel *graphdate1 = [[UILabel alloc]initWithFrame:CGRectMake((self.view.frame.origin.x+(11.0f*j)),418.0f, 10.0f, 10.0f)];
        [graphdate1 setText:[NSString stringWithFormat:@"%i", i]];
        graphdate1.numberOfLines = 1;
        [graphdate1 setTextAlignment:NSTextAlignmentCenter];
        [graphdate1 setTextColor:[UIColor whiteColor]];
        [graphdate1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:13.0f]];
        // graphdate1.backgroundColor=[UIColor redColor];
        [MainView addSubview:graphdate1];
    }
    
    //    UILabel *graphdate9 = [[UILabel alloc]initWithFrame:CGRectMake(145.0f,418.0f, 10.0f, 10.0f)];
    //    [graphdate9 setText:@"9"];
    //    graphdate9.numberOfLines = 1;
    //    [graphdate9 setTextAlignment:NSTextAlignmentCenter];
    //    [graphdate9 setTextColor:[UIColor whiteColor]];
    //    [graphdate9 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:13.0f]];
    //    //graphdate9.backgroundColor=[UIColor redColor];
    //    [MainView addSubview:graphdate9];
    
    
    UILabel *graphdate10 = [[UILabel alloc]initWithFrame:CGRectMake(158.0f,410.0f, 40.0f, 40.0f)];
    [graphdate10 setText:@"Aug 10"];
    graphdate10.numberOfLines = 2;
    [graphdate10 setTextAlignment:NSTextAlignmentCenter];
    [graphdate10 setTextColor:[UIColor whiteColor]];
    [graphdate10 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:13.0f]];
    //graphdate10.backgroundColor=[UIColor redColor];
    [MainView addSubview:graphdate10];*/
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(187.0f, dateLabel2.frame.origin.y+dateLabel2.frame.size.height+3.0f, 66.0f/2, 40.0f/2)];
    [img setImage:[UIImage imageNamed:@"menubtn"]];
    [MainView addSubview:img];
    /*******************************SANDEEP DUTTA EDIT**************************/
    
    /***********************************OLDER CODE**************************/
    /* dispatch_queue_t Queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
     dispatch_async(Queue, ^{
     
     NSString *  Url_Str=[NSString stringWithFormat:@"%@reading_list.php?userid=%d",DOMAIN_APP_URL,13];
     
     
     
     NSData *ReturnData=[NSData dataWithContentsOfURL:[NSURL URLWithString:Url_Str]];
     
     
     
     dispatch_async(dispatch_get_main_queue(), ^{
     NSError *error;
     ReturnDict=[NSJSONSerialization JSONObjectWithData:ReturnData options:kNilOptions error:&error];
     ReturnArray=[ReturnDict objectForKey:@"reading_list"];
     
     ReadingArray=[[NSMutableArray alloc]init];
     DateArray=[[NSMutableArray alloc]init];
     DateMonthArray=[[NSMutableArray alloc]init];
     
     for (int i=0;i<[ReturnArray count]-1;i++) {
     
     int M2=[[[ReturnArray objectAtIndex:i] objectForKey:@"meter_reading"] intValue];
     int M1=[[[ReturnArray objectAtIndex:i+1] objectForKey:@"meter_reading"] intValue];
     int D2=[[[[[ReturnArray objectAtIndex:i] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:2] intValue];
     int D1=[[[[[ReturnArray objectAtIndex:i+1] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:2] intValue];
     
     if (D2!=D1) {
     int MeterValue=(M2-M1)/(D2-D1);
     
     
     MeterValue=MeterValue*.07;
     
     
     if (MeterValue<0) {
     [ReadingArray addObject:[NSNumber numberWithInt:MeterValue*-1]];
     
     }
     else
     {
     
     [ReadingArray addObject:[NSNumber numberWithInt:MeterValue]];
     if (MeterValue>MaxReading) {
     MaxReading=MeterValue;
     }
     
     
     }
     
     
     //                    int MonthNumber=[[[[[ReturnArray objectAtIndex:i] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:1] intValue];
     //                    [DateArray addObject:[NSString stringWithFormat:@"%d-%@",[[NSNumber numberWithInt:D2] intValue],[self findingMonth:MonthNumber]]];
     
     [DateArray addObject:[NSString stringWithFormat:@"%d-%d",[[NSNumber numberWithInt:D2] intValue],D1]];
     }
     }
     
     
     
     //[DateArray addObject:[NSString stringWithFormat:@"%d-%@",[[[[[ReturnArray lastObject] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:2] intValue],[self findingMonth:[[[[[ReturnArray lastObject] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:1] intValue]]]];
     
     
     
     
     //initate the graph view
     SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(10, 0, 538, 220)];
     
     NSDictionary *_themeAttributes = @{
     kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
     kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
     kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
     kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
     kYAxisLabelSideMarginsKey : @20,
     kPlotBackgroundLineColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
     kDotSizeKey : @10
     };
     _lineGraph.themeAttributes = _themeAttributes;
     
     _lineGraph.yAxisRange = @(MaxReading);
     
     _lineGraph.yAxisPrefix = @"$";
     
     
     _lineGraph.xAxisValues=[[NSMutableArray alloc]init];
     for (int i=1; i<=[DateArray count]; i++) {
     NSMutableDictionary *f=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[DateArray objectAtIndex:i-1]],[NSString stringWithFormat:@"%d",i], nil];
     [_lineGraph.xAxisValues addObject:f];
     }
     
     
     
     
     SHPlot *_plot0 = [[SHPlot alloc] init];
     
     
     _plot0.plottingValues=[[NSMutableArray alloc]init];
     for (int i=1; i<=[ReadingArray count]; i++) {
     NSMutableDictionary *f=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[ReadingArray objectAtIndex:i-1]],[NSString stringWithFormat:@"%d",i], nil];
     [_plot0.plottingValues addObject:f];
     }
     
     
     NSArray *arr0 = @[@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
     _plot0.plottingPointsLabels = arr0;
     
     
     NSDictionary *_plotThemeAttributes0 = @{
     kPlotFillColorKey :[UIColor colorWithRed:(156.0f/255.0f) green:(183.0f/255.0f) blue:(203.0f/255.0f) alpha:1],
     kPlotStrokeWidthKey : @0,
     kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
     kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
     kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
     };
     
     _plot0.plotThemeAttributes = _plotThemeAttributes0;
     [_lineGraph addPlot:_plot0];
     
     
     
     ///////  end of it
     
     
    //create a new plot object that you want to draw on the `_lineGraph`
     SHPlot *_plot1 = [[SHPlot alloc] init];
     
     
     //set the plot attributes
     int Budget=[[ReturnDict  objectForKey:@"budget"] intValue];
     
     
     NSArray *MyBudgetPlotvalues=[[NSArray alloc]initWithObjects:[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget], nil];
     _plot1.plottingValues=[[NSMutableArray alloc]init];
     
     for (int i=1; i<13; i++) {
     NSMutableDictionary *f=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[MyBudgetPlotvalues objectAtIndex:i-1]],[NSString stringWithFormat:@"%d",i], nil];
     [_plot1.plottingValues addObject:f];
     }
     
     
     
     
     //
     //            _plot1.plottingValues = @[
     //                                      @{ @1 :[NSNumber numberWithInt:Budget]},
     //                                      @{ @2 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @3 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @4 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @5 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @6 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @7 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @8 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @9 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @10 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @11 : [NSNumber numberWithInt:Budget]},
     //                                      @{ @12 : [NSNumber numberWithInt:Budget]}
     //
     //                                      ];
     */
    //*****************************OLDER CODE**********************************
    /**
     *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
     *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
     *  greater than the `yAxisRange` specified in `SHLineGraphView`.
     */
    
    
    /**
     *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
     *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
     *  in this array.
     */
    //*****************************OLDER CODE**********************************
    // NSArray *arr = @[@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    // _plot1.plottingPointsLabels = arr;
    //*****************************OLDER CODE**********************************
    //set plot theme attributes
    
    /**
     *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
     *  is applied selected and the graph is plotted with those default settings.
     */
    //*****************************OLDER CODE**********************************
    /*   NSDictionary *_plotThemeAttributes = @{
     kPlotFillColorKey : [UIColor colorWithRed:(163.0f/255.0f) green:(224.0f/255.0f) blue:(228.0f/255.0f) alpha:1],
     kPlotStrokeWidthKey : @0,
     kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
     kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
     kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
     };
     
     _plot1.plotThemeAttributes = _plotThemeAttributes;
     [_lineGraph addPlot:_plot1];
     
     //You can as much `SHPlots` as you can in a `SHLineGraphView`
     
     [_lineGraph setupTheView];
     
     UIView *GraphContainerView=[[UIView alloc]initWithFrame:CGRectMake(0, 250,_lineGraph.frame.size.width, _lineGraph.frame.size.height)];
     [MainView addSubview:GraphContainerView];
     
     [GraphContainerView addSubview:_lineGraph];
     
     //[MainView addSubview:_lineGraph];
     
     
     });
     });
     */
    /**********************************OLDER CODE*******************************/
    if(_yesfrm == YES)
    {
        
        
        
        
        BlackView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 568.0f)];
        [BlackView setBackgroundColor:[UIColor blackColor]];
        [BlackView setAlpha:0.8f];
        [MainView addSubview:BlackView];
        [MainView bringSubviewToFront:BlackView];
        UIButton *crss2 = [UIButton buttonWithType:UIButtonTypeCustom];
        crss2.frame = CGRectMake(255, 80, 90/2, 90/2);
        crss2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"crossBtn"]];
        [crss2 addTarget:self action:@selector(cross) forControlEvents:UIControlEventTouchUpInside];
        [BlackView addSubview:crss2];
        
        
        backview = [[UIView alloc]initWithFrame:CGRectMake(20.0f, 120.0f, 280.0f, 150.0f)];
        [backview setBackgroundColor:[UIColor whiteColor]];
        backview.layer.cornerRadius = 5.0f;
        [MainView addSubview:backview];
        
        
        float x=10;
        NSString *allval;
        for(int j = 0;j < _readingVal.count ;j++){
            
            if(j==0){
                allval = [NSString stringWithFormat:@"%@",[_readingVal objectAtIndex:j]];
            }else{
                allval = [NSString stringWithFormat:@"%@%@",allval,[_readingVal objectAtIndex:j]];
            }
            
            
            
        }
        
        metertxt = [[UITextField alloc] initWithFrame:CGRectMake(10, 35.0f, 260.0f, 30)];
        metertxt.backgroundColor = [UIColor clearColor];
        metertxt.font = [UIFont fontWithName:@"Helvetica-LT-Light.ttf" size:15];
        metertxt.font = [UIFont boldSystemFontOfSize:17.0f];
        metertxt.placeholder = @"Meter Reading";
        metertxt.text=allval;
        metertxt.layer.borderWidth = 1.0f;
        metertxt.layer.borderColor = [[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f]CGColor];
        metertxt.textColor = [UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f];
        UIView *leftView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
        [metertxt setLeftView:leftView8];
        [metertxt setLeftViewMode:UITextFieldViewModeAlways];
        [metertxt setValue:[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
        metertxt.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [metertxt setValue:[UIFont fontWithName:@"Helvetica-LT-Light.ttf" size:22]  forKeyPath:@"_placeholderLabel.font"];
        [metertxt setValue:[UIFont boldSystemFontOfSize:17.0f] forKeyPath:@"_placeholderLabel.font"];
        [metertxt setDelegate:self];
        [backview addSubview:metertxt];
        
        UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [savebtn setFrame:CGRectMake(50.0f, 80.0f, 180.0f, 40.0f)];
        [savebtn setTitle:@"Save" forState:UIControlStateNormal];
        [savebtn setTitle:@"Save" forState:UIControlStateHighlighted];
        [savebtn setTitle:@"Save" forState:UIControlStateSelected];
        [savebtn setBackgroundColor:[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f]];
        savebtn.titleLabel.textColor = [UIColor whiteColor];
        savebtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        savebtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-LT-Light.ttf" size:20];
        savebtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [savebtn addTarget:self action:@selector(save1:) forControlEvents:UIControlEventTouchUpInside];
        [backview addSubview:savebtn];
        
        
    }
    
    
    // [ContainerScroll addSubview:[self chart1]];
    
}

-(NSString *)findingMonth:(int)MonthNumber
{
    NSString *Month;
    switch (MonthNumber) {
        case 1:
            Month=@"JAN";
            break;
            
        case 2:
            Month=@"FEB";
            break;
        case 3:
            Month=@"MAR";
            break;
        case 4:
            Month=@"APR";
            break;
        case 5:
            Month=@"MAY";
            break;
        case 6:
            Month=@"JUN";
            break;
        case 7:
            Month=@"JUL";
            break;
        case 8:
            Month=@"AUG";
            break;
        case 9:
            Month=@"SEP";
            break;
        case 10:
            Month=@"OCT";
            break;
        case 11:
            Month=@"NOV";
            break;
        case 12:
            Month=@"DEC";
            break;
    }
    return Month;
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


/// audit function..........

-(void)footeraudit:(UIButton *)sender{
    
    
    MMUsageBudgetauditViewController *model = [[MMUsageBudgetauditViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
    
}
-(void)footerback:(UIButton *)sender{
    
    NSLog(@"footerbackclk......");
    // MMUsageBudgetauditViewController *model = [[MMUsageBudgetauditViewController alloc]init];
    //  [self.navigationController pushViewController: animated:<#(BOOL)#>];
    [self.navigationController popViewControllerAnimated:YES];
    
}
//set budget function........

-(void)footersetbudght:(UIButton *)sender{
    
    [footersetbudgt removeFromSuperview];
    
    
    footersetbudgt = [UIButton buttonWithType:UIButtonTypeCustom];
    [footersetbudgt setFrame:CGRectMake(180.0f, 3.0f, 48.5f, 37.0f)];
    
    [footersetbudgt setBackgroundImage:[UIImage imageNamed:@"footerselectedsetbudght"] forState:UIControlStateNormal];
    [footersetbudgt setBackgroundImage:[UIImage imageNamed:@"footerselectedsetbudght"] forState:UIControlStateHighlighted];
    //[footersetbudgt addTarget:self action:@selector(footersetbudght:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footersetbudgt];
    
    //---------------BLUR EFFECT------------//
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    self.bluredView = [[UIVisualEffectView alloc] initWithEffect:effect];
    
    self.bluredView.frame = self.view.bounds;
    
    [MainView addSubview:self.bluredView];
    
    //-------------------------------------//
    
    BlackView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 568.0f)];
    [BlackView setBackgroundColor:[UIColor blackColor]];
    [BlackView setAlpha:0.7f];
    [self.bluredView addSubview:BlackView];
    
    self.setViewFooter = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    self.setViewFooter.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"setBudgetTextfield"]];
    [self.bluredView addSubview:self.setViewFooter];
    
     self.setBudgetBack = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.setBudgetBack setFrame:CGRectMake(20.0f, 3.0f, 31.5f, 36.0f)];
    [self.setBudgetBack setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [self.setBudgetBack setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [self.setBudgetBack addTarget:self action:@selector(cross) forControlEvents:UIControlEventTouchUpInside];
    self.setBudgetBack.userInteractionEnabled=YES;
    [self.setViewFooter addSubview:self.setBudgetBack];
    
    self.setBudgetSave = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.setBudgetSave setFrame:CGRectMake(191.0f, 3.0f, 24.5f, 37.0f)];
    [self.setBudgetSave setBackgroundImage:[UIImage imageNamed:@"setBudgetSave"] forState:UIControlStateNormal];
    [self.setBudgetSave setBackgroundImage:[UIImage imageNamed:@"setBudgetSave"] forState:UIControlStateHighlighted];
    [self.setBudgetSave addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [self.setViewFooter addSubview:self.setBudgetSave];
    
    
    UILabel *budghtlbl = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 120.0f, 280.0f, 60.0f)];
    [budghtlbl setTextAlignment:NSTextAlignmentCenter];
    [budghtlbl setNumberOfLines:2];
    budghtlbl.lineBreakMode = NSLineBreakByWordWrapping;
    [budghtlbl setText:@"How much would you like to spend per month?"];
    [budghtlbl setTextColor:[UIColor whiteColor]];
    [budghtlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:23]];
    [BlackView addSubview:budghtlbl];
    
    UIImageView *textFieldBackImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, budghtlbl.frame.origin.y+budghtlbl.frame.size.height+35.0f, self.view.bounds.size.width, 50)];
    textFieldBackImage.backgroundColor = [UIColor clearColor];
    textFieldBackImage.image = [UIImage imageNamed:@"setBudgetTextfield"];
    [self.bluredView addSubview:textFieldBackImage];
    
    

    budget = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, budghtlbl.frame.origin.y+budghtlbl.frame.size.height+35.0f, textFieldBackImage.frame.size.width-22.0f, 50)];
    budget.backgroundColor = [UIColor clearColor];
    budget.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:45.0f];;
    budget.placeholder = @"Type your value";
    budget.text=@"";
    budget.textColor = [UIColor whiteColor];
    budget.textAlignment = NSTextAlignmentCenter;
    [budget setLeftViewMode:UITextFieldViewModeAlways];
    [budget setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    budget.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [budget setValue:[UIFont fontWithName:GLOBALTEXTFONT size:35.0f]  forKeyPath:@"_placeholderLabel.font"];
    [budget setDelegate:self];
    [self.bluredView addSubview:budget];
    
    
    UILabel *budghtlbl2 = [[UILabel alloc]initWithFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2.0f)-260.0f/2.0f, textFieldBackImage.frame.origin.y+textFieldBackImage.frame.size.height+5.0f, 260.0f, 60.0f)];
    [budghtlbl2 setTextAlignment:NSTextAlignmentCenter];
    [budghtlbl2 setNumberOfLines:2];
    budghtlbl2.lineBreakMode = NSLineBreakByWordWrapping;
    [budghtlbl2 setText:@"We will show how you can \nget to your monthly target."];
    [budghtlbl2 setTextColor:[UIColor whiteColor]];
    [budghtlbl2 setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17.0f]];
    [BlackView addSubview:budghtlbl2];
    
    UIView *emojiBack = [[UIView alloc]initWithFrame:CGRectMake(0.0f, budghtlbl2.frame.origin.y+budghtlbl2.frame.size.height+40.0f, [UIScreen mainScreen].bounds.size.width, 85.0f)];
    emojiBack.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
    [self.bluredView addSubview:emojiBack];
    
    UIImageView *emojiIcon = [[UIImageView alloc]init];
    [emojiIcon setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2.0f)-(23.0f/2.0f), 7.0f, 23.0f, 20.0f)];
    [emojiIcon setImage:[UIImage imageNamed:@"setBudgetAuditIcon"]];
    [emojiIcon setBackgroundColor:[UIColor clearColor]];
    [emojiBack addSubview:emojiIcon];
    
    UILabel *emojiLabel = [[UILabel alloc]init];
    [emojiLabel setFrame:CGRectMake(([UIScreen mainScreen].bounds.size.width/2.0f)-((emojiBack.frame.size.width-45.0f)/2.0f), emojiIcon.frame.origin.y+emojiIcon.frame.size.height+3.0f, emojiBack.frame.size.width-45.0f, 50.0f)];
    [emojiLabel setText:@"Next step is to select Audit \nfrom bottom navbar."];
    [emojiLabel setNumberOfLines:2];
    [emojiLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [emojiLabel setTextColor:[UIColor whiteColor]];
    [emojiLabel setTextAlignment:NSTextAlignmentCenter];
    [emojiLabel setBackgroundColor:[UIColor clearColor]];
    [emojiLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17.0f]];
    [emojiBack addSubview:emojiLabel];

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    //limit the size :
    int limit = 10;
    return !([textField.text length]>limit && [string length] > range.length);
}

//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    
//    budget.text = [NSString stringWithFormat:@"$"];
//    return YES;
//}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


-(void)cross{
    
    [BlackView setHidden:YES];
    [backview removeFromSuperview];
    [self.bluredView removeFromSuperview];
    [self.setViewFooter removeFromSuperview];
    
    
    footersetbudgt = [UIButton buttonWithType:UIButtonTypeCustom];
    [footersetbudgt setFrame:CGRectMake(180.0f, 3.0f, 48.5f, 37.0f)];
    
    [footersetbudgt setBackgroundImage:[UIImage imageNamed:@"footersetbudght"] forState:UIControlStateNormal];
    [footersetbudgt setBackgroundImage:[UIImage imageNamed:@"footersetbudght"] forState:UIControlStateHighlighted];
    [footersetbudgt addTarget:self action:@selector(footersetbudght:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footersetbudgt];
}

//budget save button......

-(void)save:(UIButton *)sender{
    
    if ([budget.text length] == 0) {
        
        budget.text = @"";
        
        budget.placeholder = @"Please set budget";
        return;
    }
    else{
        
        NSString *setbudget = [[NSString alloc]init];
        
        setbudget = [NSString stringWithFormat:@"%@/set_budget.php?userid=%@&budget=%@",DOMAIN_APP_URL,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],budget.text];
        
        NSError *error=nil;
        
        
        NSData *BudgetData=[NSData dataWithContentsOfURL:[NSURL URLWithString:setbudget]options:NSDataReadingUncached error:&error];
        NSString *Budgetstring = [[NSString alloc] initWithData:BudgetData encoding:NSUTF8StringEncoding];
        
        if ([Budgetstring isEqualToString:@"success"]) {
            
            [BlackView setHidden:YES];
            [backview removeFromSuperview];
            [self.bluredView removeFromSuperview];
            
            [footersetbudgt removeFromSuperview];
            footersetbudgt = [UIButton buttonWithType:UIButtonTypeCustom];
            [footersetbudgt setFrame:CGRectMake(180.0f, 3.0f, 48.5f, 37.0f)];
            [footersetbudgt setBackgroundImage:[UIImage imageNamed:@"footersetbudght"] forState:UIControlStateNormal];
            [footersetbudgt setBackgroundImage:[UIImage imageNamed:@"footersetbudght"] forState:UIControlStateHighlighted];
            [footersetbudgt addTarget:self action:@selector(footersetbudght:) forControlEvents:UIControlEventTouchUpInside];
            [UsBackView8 addSubview:footersetbudgt];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Successfully Submitted" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [alert show];
        }
    }
}

-(void)footerupdate:(UIButton *)sender{
    
    
    ColorCircleViewController *view = [[ColorCircleViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
    
    
}

-(void)save1:(UIButton *)sender{
    
    NSLog(@"entry save button.....");
    
    NSDate *currentdate = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *currenttime = [dateFormatter stringFromDate:currentdate];
    
    
    
    
    
    NSString *setbudget = [[NSString alloc]init];
    
    setbudget = [NSString stringWithFormat:@"%@/meter_reading.php?userid=%@&meter_reading=%@&date=%@",DOMAIN_APP_URL,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],metertxt.text,[currenttime stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSError *error=nil;
    
    
    NSData *BudgetData=[NSData dataWithContentsOfURL:[NSURL URLWithString:setbudget]options:NSDataReadingUncached error:&error];
    NSDictionary *result_new=[NSJSONSerialization JSONObjectWithData:BudgetData options:kNilOptions error:&error];
    
    
    newdict = [result_new objectForKey:@"budgetetails"];
    
    budgtstr = [[newdict objectForKey:@"budget_exceed"]floatValue];
    
    budgettime = [newdict objectForKey:@"time"];
    
    
    if ([[result_new objectForKey:@"auth"]isEqualToString:@"success"]) {
        
        if ([[newdict objectForKey:@"budget_status"] isEqualToString:@"NO"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry" message:@"Please set your budget" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            
            [alert show];
            
        }
        else{
            [BlackView setHidden:YES];
            [backview removeFromSuperview];
            [self.bluredView removeFromSuperview];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",budgettime] forKey:@"budgettime"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",budgtstr] forKey:@"budgetexceed"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            //                MMUsageBudgetViewController *model = [[MMUsageBudgetViewController alloc]init];
            //                [self.navigationController pushViewController:model animated:NO];
            
            
            [BlackView removeFromSuperview];
            [backview removeFromSuperview];
            [self.bluredView removeFromSuperview];
        }
        
        
    }
}

-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *model = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
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

-(void)DoingCalculationForMeterReading
{
    NSLog(@",,,,,,,,,,,,,,,,,,,,,,,,,,");
    FirstKataXArray=[[NSMutableArray alloc]init];
    FirstKataYArray=[[NSMutableArray alloc]init];
    
    SecondKataXArray=[[NSMutableArray alloc]init];
    SecondKataYArray=[[NSMutableArray alloc]init];
    
    ThirdKataXArray=[[NSMutableArray alloc]init];
    ThirdKataYArray=[[NSMutableArray alloc]init];
    
    ForthKataXArray=[[NSMutableArray alloc]init];
    ForthKataYArray=[[NSMutableArray alloc]init];
    
    FifthKataXArray=[[NSMutableArray alloc]init];
    FifthKataYArray=[[NSMutableArray alloc]init];
    
//    AppDelegate *  AppObj=[[UIApplication sharedApplication]delegate];
    
    /*
     (
     117,
     169,
     29,
     49,
     169,
     31,
     247,
     173,
     27,
     177,
     169,
     31,
     311,
     171,
     32
     )*/
    
    
    
    
    CircleArray=[[NSMutableArray alloc]init];
    NSMutableArray *someary = [[NSMutableArray alloc] init];
    someary = [_dataary objectForKey:@"4"];
    // NSLog(@"somearay...%lu  count--%lu   sorted--%@",someary.count%3,(unsigned long)someary.count,someary);
    if (someary.count%3==0) {
        NSLog(@"hhhhhhhhh");
        int k=0;
        for (int j=0; j<someary.count; j+=3) {
            
            
            
            
            [CircleArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[someary objectAtIndex:j] intValue]],@"x",[NSNumber numberWithInt:[[someary objectAtIndex:j+1] intValue]],@"y",[NSNumber numberWithInt:[[someary objectAtIndex:j+2] intValue]],@"r", nil]];
            NSLog(@"heree----%d",k);
            
            
            
            
        }
        
    }
    
    
    
    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"x" ascending:YES];
    
    SortedCircleArray= [CircleArray sortedArrayUsingDescriptors:@[sd1]];
    NSLog(@"the fffffffffffffffff---%@",SortedCircleArray);
    
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    
    
    imagecoming = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.width, 421)];
    imagecoming.image = _cominimg;
    //    imagecoming.contentMode = UIViewContentModeScaleAspectFill;
    //    imagecoming.clipsToBounds =YES;
    [self.view addSubview:imagecoming];
    
    
    
    [self findingInnerCirclePeripheralPixcels];
    for (int i=0; i<[AppObj.CirclePeripheral1PointsXDataArray count]; i++) {
        //NSLog(@"the circle111-xxx-%@  circle1111-yyyy-%@",[AppObj.CirclePeripheral1PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral1PointsYDataArray objectAtIndex:i]);
    }
    
    for (int i=0; i<[AppObj.CirclePeripheral2PointsXDataArray count]; i++) {
        //NSLog(@"the circle2222-xxx-%@  circle22222-yyyy-%@",[AppObj.CirclePeripheral2PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral2PointsYDataArray objectAtIndex:i]);
    }
    
    
    for (int i=0; i<[AppObj.CirclePeripheral3PointsXDataArray count]; i++) {
        //NSLog(@"the circle3333-xxx-%@  circle333333-yyyy-%@",[AppObj.CirclePeripheral3PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral3PointsYDataArray objectAtIndex:i]);
    }
    
    for (int i=0; i<[AppObj.CirclePeripheral4PointsXDataArray count]; i++) {
        //NSLog(@"the circle44444-xxx-%@  circle44444-yyyy-%@",[AppObj.CirclePeripheral4PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral4PointsYDataArray objectAtIndex:i]);
    }
    
    
    for (int i=0; i<[AppObj.CirclePeripheral5PointsXDataArray count]; i++) {
        //NSLog(@"the circle55555-xxx-%@  555555-yyyy-%@",[AppObj.CirclePeripheral5PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral5PointsYDataArray objectAtIndex:i]);
    }
    
    
    
    
    CGRect PreFrame=CGRectMake(20, 0, 0, 0);
    for (int i=0; i<5; i++) {
        UILabel *SampleView=[[UILabel alloc]initWithFrame:CGRectMake(PreFrame.origin.x, 263, 30, 30)];
        SampleView.tag=i;
        SampleView.textColor=[UIColor blackColor];
        PreFrame=SampleView.frame;
        PreFrame.origin.x=SampleView.frame.origin.x+SampleView.frame.size.width+10;
        [MainView addSubview:SampleView];
        SampleView.backgroundColor=RGBCOLOR1(.4, .4, .4, 1);
        
        
        
        
        
        
    }
    NSLog(@"hhhhhhhhhhhhhhhhhhhh");
    
    [self OwnHands];
}
-(void)findingInnerCirclePeripheralPixcels
{
    
    for (int k=0; k<SortedCircleArray.count; k++) {
        
        
        //NSLog(@"centered alimmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
        
        {
            
            
            
            ////////////////////////////////////////////////////
            int xc,yc,r,x,y,Pk;
            xc=[[[SortedCircleArray objectAtIndex:k] objectForKey:@"x"] intValue];
            yc=[[[SortedCircleArray objectAtIndex:k] objectForKey:@"y"] intValue];
            int rad1=[[[SortedCircleArray objectAtIndex:k] objectForKey:@"r"] intValue];
            
            r=rad1-17;
            
            x=0;
            y=r;
            
            
            // NSLog(@"kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk---%d",k);
            switch (k) {
                case 0:
                {
                    [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                    
                    
                    
                }
                    
                    
                    break;
                    
                case 1:
                {
                    [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                    
                    
                }
                    
                    break;
                case 2:
                {
                    [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                    
                }
                    break;
                case 3:
                {
                    
                    [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                    
                }
                    
                    break;
                case 4:
                {
                    [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                    
                }
                    
                    break;
            }
            
            
            
            
            //NSLog(@"first point--xxxx-%d  and ----yyyy---%d",xc+x,yc-y);
            //putpixel(xc+x,yc-y,1);
            
            
            Pk=3-(2*r);
            
            for(x=0;x<=y;x++)
            {
                
                if (Pk<0)
                {
                    y=y;
                    Pk=(Pk+(4*x)+6);
                }
                else
                {
                    y=y-1;
                    Pk=Pk+((4*(x-y)+10));
                }
                
                switch (k) {
                    case 0:
                    {
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                    }
                        
                        break;
                    case 1:
                    {
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                        
                    }
                        break;
                    case 2:
                    {
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                    }
                        
                        break;
                    case 3:
                    {
                        
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                        
                    }
                        
                        break;
                    case 4:
                    {
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                    }
                        
                        break;
                }
                
                
                
                
            }
            
            
            
            
            
            
        }
        
    }
}
-(void)FindingTheRegionInClockWise:(float)Angle AndClockNo:(int)ClockNo
{
    //NSLog(@"finding FindingTheRegionInClockWise reading here............");
    int ClockReading;
    
    if (Angle>0.0) {
        if (Angle>= 0.0 && Angle<=36.0) {
            ClockReading=2;
            
        }
        else if (Angle>=36.1 && Angle<=72.0) {
            ClockReading=1;
        }
        else  if (Angle>= 72.1 && Angle<=108.0) {
            ClockReading=0;
            
        }
        else   if (Angle>= 108.1 && Angle<=144.0) {
            ClockReading=9;
            
        }
        else {
            ClockReading=8;
            
        }
        
        
    } else {
        Angle=Angle*(-1);
        if (Angle>=0.1 && Angle<=36.0) {
            ClockReading=3;
            
        }
        else  if (Angle>=36.1 && Angle<=72.0) {
            ClockReading=4;
            
        }
        else  if (Angle>= 72.1 && Angle<=108.0) {
            ClockReading=5;
            
        }
        else  if (Angle>= 108.1 && Angle<=144.0) {
            ClockReading=6;
            
        }
        else  {
            ClockReading=7;
            
        }
        
    }
    
    
    [self PlacingValueInMeterReadingLabel:ClockReading andClockReading:ClockNo];
    
}

-(void)FindingTheRegionInAntiClockWise:(float)Angle AndClockNo:(int)ClockNo
{
    
    
    //NSLog(@"finding FindingTheRegionInAntiClockWise reading here............");
    int ClockReading;
    if (Angle>0.0) {
        if (Angle>= 0.0 && Angle<=36.0) {
            ClockReading=8;
            
        }
        else if (Angle>=36.1 && Angle<=72.0) {
            ClockReading=9;
            
        }
        else  if (Angle>= 72.1 && Angle<=108.0) {
            ClockReading=0;
        }
        else  if (Angle>= 108.1 && Angle<=144.0) {
            ClockReading=1;
            
        }
        else {
            ClockReading=2;
            
        }
        
        
    } else {
        Angle=Angle*(-1);
        if (Angle>=0.1 && Angle<=36.0) {
            ClockReading=7;
            
        }
        else  if (Angle>=36.1 && Angle<=72.0) {
            ClockReading=6;
            
        }
        else if (Angle>= 72.1 && Angle<=108.0) {
            ClockReading=5;
            
        }
        else  if (Angle>= 108.1 && Angle<=144.0) {
            ClockReading=4;
            
        }
        else {
            ClockReading=3;
            
        }
        
    }
    
    [self PlacingValueInMeterReadingLabel:ClockReading andClockReading:ClockNo];
    
}

-(NSArray*)getRGBAFromImage:(UIImage*)image atx:(int)xp atY:(int)yp

{
    
    //NSLog(@"here in the rgb color picking.....");
    
    NSMutableArray *resultColor = [NSMutableArray array];
    
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef);
    
    NSUInteger height = CGImageGetHeight(imageRef);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    
    NSUInteger bytesPerPixel = 4;
    
    NSUInteger bytesPerRow = bytesPerPixel * width;
    
    NSUInteger bitsPerComponent = 8;
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    
    CGColorSpaceRelease(colorSpace);
    
    
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    
    int byteIndex = (bytesPerRow * yp) + xp * bytesPerPixel;
    
    CGFloat red   = (rawData[byteIndex]     * 1.0) /255.0;
    
    CGFloat green = (rawData[byteIndex + 1] * 1.0)/255.0 ;
    
    CGFloat blue  = (rawData[byteIndex + 2] * 1.0)/255.0 ;
    
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) /255.0;
    
    byteIndex += 4;
    
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    [resultColor addObject:color];
    
    // NSLog(@"width:%i hight:%i Color:%@",width,height,[color description]);
    
    free(rawData);
    
    return resultColor;
    
}
-(void)PlacingValueInMeterReadingLabel:(int)Reading andClockReading:(int)ClockTag
{
    NSLog(@"hhrrrrrrrkkkkkkkkkkkkkk");
    NSLog(@"placing the value here,,,,,,,,,,,,,%d",Reading);
    
    
    
    for (UILabel *Subviews in self.view.subviews) {
        
        if ([Subviews isKindOfClass:NSClassFromString(@"UILabel")]) {
            UILabel *GetLbl=(UILabel *)Subviews;
            
            [GetLbl setText:[NSString stringWithFormat:@"%d",Reading]];
        }
    }
    
    //    CGRect PreFrame=CGRectMake(0, 0, 0, 0);
    
}
-(void)OwnHands
{
    
    NSLog(@" ");
    AppDelegate *appObj=[[UIApplication sharedApplication]delegate];
    
    // NSLog(@"the circle dataYarr count---%d",[SortedCircleArray count]);
    // if ([SortedCircleArray count]==5) {
    
    if ([FirstKataXArray count]>0) {
        [FirstKataXArray removeAllObjects];
        [FirstKataYArray removeAllObjects];
    }
    if ([SecondKataXArray count]>0) {
        [SecondKataXArray removeAllObjects];
        [SecondKataYArray removeAllObjects];
    }
    if ([ThirdKataXArray count]>0) {
        [ThirdKataXArray removeAllObjects];
        [ThirdKataYArray removeAllObjects];
    }
    
    for (int i=0;i<[SortedCircleArray  count]; i++)
    {
        //        switch (i)
        //        {
        //            case 0:
        for (int i=0; i<[appObj.CirclePeripheral1PointsXDataArray count]; i++)
        {
            
            
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral1PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral1PointsYDataArray objectAtIndex:i] intValue]]];
            NSLog(@"-1111111111-->>>>>>>>>>%@  and the xposition--%d  and yyy position---%d",Arr, [[appObj.CirclePeripheral1PointsXDataArray objectAtIndex:i] intValue],[[appObj.CirclePeripheral1PointsYDataArray objectAtIndex:i] intValue]);
            
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            
            
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [FirstKataXArray addObject:[appObj.CirclePeripheral1PointsXDataArray objectAtIndex:i]];
                [FirstKataYArray addObject:[appObj.CirclePeripheral1PointsYDataArray objectAtIndex:i]];
                
            }
            
            
            
            
            
            
            
            
        }
        
        //                break;
        //            case 1:
        for (int i=0; i<[appObj.CirclePeripheral2PointsXDataArray count]; i++)
        {
            
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral2PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral2PointsYDataArray objectAtIndex:i] intValue]]];
            NSLog(@"--2222222->>>>>>>>>>%@  and the xposition--%d  and yyy position---%d",Arr, [[appObj.CirclePeripheral2PointsXDataArray objectAtIndex:i] intValue],[[appObj.CirclePeripheral2PointsYDataArray objectAtIndex:i] intValue]);
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            
            
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [SecondKataXArray addObject:[appObj.CirclePeripheral2PointsXDataArray objectAtIndex:i]];
                [SecondKataYArray addObject:[appObj.CirclePeripheral2PointsYDataArray objectAtIndex:i]];
                
            }
            
            
            
            
            
            
            
        }
        
        //                break;
        //
        //            case 2:
        for (int i=0; i<[appObj.CirclePeripheral3PointsXDataArray count]; i++)
        {
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral3PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral3PointsYDataArray objectAtIndex:i] intValue]]];
            NSLog(@"--33333333->>>>>>>>>>%@  and the xposition--%d  and yyy position---%d",Arr, [[appObj.CirclePeripheral3PointsXDataArray objectAtIndex:i] intValue],[[appObj.CirclePeripheral3PointsYDataArray objectAtIndex:i] intValue]);
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            
            
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [ThirdKataXArray addObject:[appObj.CirclePeripheral3PointsXDataArray objectAtIndex:i]];
                [ThirdKataYArray addObject:[appObj.CirclePeripheral3PointsYDataArray objectAtIndex:i]];
                
            }
            
            
            
            
            
            
            
        }
        //                break;
        //            case 3:
        for (int i=0; i<[appObj.CirclePeripheral4PointsXDataArray count]; i++)
        {
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral4PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral4PointsYDataArray objectAtIndex:i] intValue]]];
            NSLog(@"--4444444->>>>>>>>>>%@  and the xposition--%d  and yyy position---%d",Arr, [[appObj.CirclePeripheral4PointsXDataArray objectAtIndex:i] intValue],[[appObj.CirclePeripheral4PointsYDataArray objectAtIndex:i] intValue]);
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            
            
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [ForthKataXArray addObject:[appObj.CirclePeripheral4PointsXDataArray objectAtIndex:i]];
                [ForthKataYArray addObject:[appObj.CirclePeripheral4PointsYDataArray objectAtIndex:i]];
                
            }
            
            
            
            /////////////////////////////
        }
        
        //                break;
        //            case 4:
        for (int i=0; i<[appObj.CirclePeripheral5PointsXDataArray count]; i++)
        {
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral5PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral5PointsYDataArray objectAtIndex:i] intValue]]];
            NSLog(@"-555555555555555-->>>>>>>>>>%@  and the xposition--%d  and yyy position---%d",Arr, [[appObj.CirclePeripheral5PointsXDataArray objectAtIndex:i] intValue],[[appObj.CirclePeripheral5PointsYDataArray objectAtIndex:i] intValue]);
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            
            
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [FifthKataXArray addObject:[appObj.CirclePeripheral5PointsXDataArray objectAtIndex:i]];
                [FifthKataYArray addObject:[appObj.CirclePeripheral5PointsYDataArray objectAtIndex:i]];
                
            }
            
            
            
            
            
            
            
        }
        
        // break;
        
        
        //}
        
    }
    
    ///end of for1
    
    
    
    
    int  FirstKataMinX,FirstKataMinY,FirstKataMaxX,FirstKataMaxY;
    int SecondKataMinX,SecondKataMinY,SecondKataMaxX,SecondKataMaxY;
    int ThirdKataMinX,ThirdKataMinY,ThirdKataMaxX,ThirdKataMaxY;
    int ForthKataMinX,ForthKataMinY,ForthKataMaxX,ForthKataMaxY;
    int FifthKataMinX,FifthKataMinY,FifthKataMaxX,FifthKataMaxY;
    
    NSLog(@"fff-%lu  sssss-%lu  tttt--%lu  fffffrrr--%lu  llllll--%lu",(unsigned long)[FirstKataXArray count],(unsigned long)[SecondKataXArray count],(unsigned long)[ThirdKataXArray count],(unsigned long)[ForthKataXArray count],(unsigned long)[FifthKataXArray count]);
    if ([FirstKataXArray count]>0&& [SecondKataXArray count]>0&&[ThirdKataXArray count]>0 &&[ForthKataXArray count]>0 &&[FifthKataXArray count]>0) {
        
        //case 0:
        //    {
        //        NSLog(@"---%@",FirstKataXArray);
        FirstKataMinX=[[FirstKataXArray objectAtIndex:0] intValue];
        FirstKataMinY=[[FirstKataYArray objectAtIndex:0] intValue];
        
        FirstKataMaxX=[[FirstKataXArray objectAtIndex:0] intValue];
        FirstKataMaxY=[[FirstKataYArray objectAtIndex:0] intValue];
        for (int i=1; i<[FirstKataXArray count]; i++)
        {
            //       NSLog(@"-----FirstKataXArray--%d  and FirstKataYArray---%d",[[FirstKataXArray objectAtIndex:i] intValue],[[FirstKataYArray objectAtIndex:i] intValue]);
            
            
            if (FirstKataMinX>[[FirstKataXArray objectAtIndex:i] intValue]) {
                FirstKataMinX=[[FirstKataXArray objectAtIndex:i] intValue];
            }
            
            if (FirstKataMaxX<[[FirstKataXArray objectAtIndex:i] intValue]) {
                FirstKataMaxX=[[FirstKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (FirstKataMinY>[[FirstKataYArray objectAtIndex:i] intValue]) {
                
                FirstKataMinY=[[FirstKataYArray objectAtIndex:i] intValue];
            }
            if (FirstKataMaxY <[[FirstKataYArray objectAtIndex:i] intValue]) {
                FirstKataMaxY=[[FirstKataYArray objectAtIndex:i] intValue];
            }
            
            
            
        }
        
        //    }
        //
        //    break;
        //case 1:
        //    {
        SecondKataMinX=[[SecondKataXArray objectAtIndex:0]intValue];
        SecondKataMinY=[[SecondKataYArray objectAtIndex:0]intValue];
        
        SecondKataMaxX=[[SecondKataXArray objectAtIndex:0]intValue];
        SecondKataMaxY=[[SecondKataYArray objectAtIndex:0]intValue];
        
        
        for (int i=1; i<[SecondKataYArray count]; i++)
        {
            // NSLog(@"-----secondkataxarray--%d  and secondkatayarray---%d",[[SecondKataXArray objectAtIndex:i] intValue],[[SecondKataYArray objectAtIndex:i] intValue]);
            if (SecondKataMinX>[[SecondKataXArray objectAtIndex:i] intValue]) {
                SecondKataMinX=[[SecondKataXArray objectAtIndex:i] intValue];
            }
            
            if (SecondKataMaxX<[[SecondKataXArray objectAtIndex:i] intValue]) {
                SecondKataMaxX=[[SecondKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (SecondKataMinY>[[SecondKataYArray objectAtIndex:i] intValue]) {
                
                SecondKataMinY=[[SecondKataYArray objectAtIndex:i] intValue];
            }
            if (SecondKataMaxY <[[SecondKataYArray objectAtIndex:i] intValue]) {
                SecondKataMaxY=[[SecondKataYArray objectAtIndex:i] intValue];
            }
            
            
            
        }
        
        //    }
        //    break;
        //case 2:
        //    {
        ThirdKataMinX=[[ThirdKataXArray objectAtIndex:0]intValue];
        ThirdKataMinY=[[ThirdKataYArray objectAtIndex:0]intValue];
        
        ThirdKataMaxX=[[ThirdKataXArray objectAtIndex:0]intValue];
        ThirdKataMaxY=[[ThirdKataYArray objectAtIndex:0]intValue];
        
        
        for (int i=1; i<[ThirdKataXArray count]; i++) {
            
            // NSLog(@"-----thirdkataxarray--%d  and thirdkatayarray---%d",[[ThirdKataXArray objectAtIndex:i] intValue],[[ThirdKataYArray objectAtIndex:i] intValue]);
            
            if (ThirdKataMinX>[[ThirdKataXArray objectAtIndex:i] intValue]) {
                ThirdKataMinX=[[ThirdKataXArray objectAtIndex:i] intValue];
            }
            
            if (ThirdKataMaxX<[[ThirdKataXArray objectAtIndex:i] intValue]) {
                ThirdKataMaxX=[[ThirdKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (ThirdKataMinY>[[ThirdKataYArray objectAtIndex:i] intValue]) {
                
                ThirdKataMinY=[[ThirdKataYArray objectAtIndex:i] intValue];
            }
            if (ThirdKataMaxY <[[ThirdKataYArray objectAtIndex:i] intValue]) {
                ThirdKataMaxY=[[ThirdKataYArray objectAtIndex:i] intValue];
            }
            
            
        }
        
        //    }
        //    break;
        //case 3:
        //    {
        
        ForthKataMinX=[[ForthKataXArray objectAtIndex:0]intValue];
        ForthKataMinY=[[ForthKataYArray objectAtIndex:0]intValue];
        
        ForthKataMaxX=[[ForthKataXArray objectAtIndex:0]intValue];
        ForthKataMaxY=[[ForthKataYArray objectAtIndex:0]intValue];
        
        for (int i=1; i<[ForthKataXArray count]; i++) {
            
            // NSLog(@"-----fothkataxarray--%d  and forthkatayarray---%d",[[ForthKataXArray objectAtIndex:i] intValue],[[ForthKataYArray objectAtIndex:i] intValue]);
            
            if (ForthKataMinX>[[ForthKataXArray objectAtIndex:i] intValue]) {
                ForthKataMinX=[[ForthKataXArray objectAtIndex:i] intValue];
            }
            
            if (ForthKataMaxX<[[ForthKataXArray objectAtIndex:i] intValue]) {
                ForthKataMaxX=[[ForthKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (ForthKataMinY>[[ForthKataYArray objectAtIndex:i] intValue]) {
                
                ForthKataMinY=[[ForthKataYArray objectAtIndex:i] intValue];
            }
            if (ForthKataMaxY <[[ForthKataYArray objectAtIndex:i] intValue]) {
                ForthKataMaxY=[[ForthKataYArray objectAtIndex:i] intValue];
            }
            
            
            
        }
        
        
        
        //}
        //    break;
        //case 4:
        //    {
        FifthKataMinX=[[FifthKataXArray objectAtIndex:0]intValue];
        FifthKataMinY=[[FifthKataYArray objectAtIndex:0]intValue];
        
        FifthKataMaxX=[[FifthKataXArray objectAtIndex:0]intValue];
        FifthKataMaxY=[[FifthKataYArray objectAtIndex:0]intValue];
        
        
        for (int i=1; i<[FifthKataXArray count]; i++)
        {
            // NSLog(@"-----FifthKataXArray--%d  and FifthKataYArray---%d",[[FifthKataXArray objectAtIndex:i] intValue],[[FifthKataYArray objectAtIndex:i] intValue]);
            
            
            if (FifthKataMinX>[[FifthKataXArray objectAtIndex:i] intValue]) {
                FifthKataMinX=[[FifthKataXArray objectAtIndex:i] intValue];
            }
            
            if (FifthKataMaxX<[[FifthKataXArray objectAtIndex:i] intValue]) {
                FifthKataMaxX=[[FifthKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (FifthKataMinY>[[FifthKataYArray objectAtIndex:i] intValue]) {
                
                FifthKataMinY=[[FifthKataYArray objectAtIndex:i] intValue];
            }
            if (FifthKataMaxY <[[FifthKataYArray objectAtIndex:i] intValue]) {
                FifthKataMaxY=[[FifthKataYArray objectAtIndex:i] intValue];
            }
            
            
        }
        
        //}
        
        
        
        ///////me
        
        // end of for2
        
        
        NSLog(@"firtskata minx--%d  firstkatamin y--%d  firstkatamaxx--%d  firstkatamaxy--%d",FirstKataMinX,FirstKataMinY,FirstKataMaxX,FirstKataMaxY);
        
        
        
        NSLog(@"secondkata minx--%d  secondkatamin y--%d  secondkatamax--%d  secondkatamaxyyy--%d",SecondKataMinX,SecondKataMinY,SecondKataMaxX,SecondKataMaxY);
        
        
        
        NSLog(@"thidkata minx--%d  thidkata min y--%d  thirdkata amax--%d  thirdkata maxyyy--%d",ThirdKataMinX,ThirdKataMinY,ThirdKataMaxX,ThirdKataMaxY);
        
        //
        NSLog(@"forthkata minx--%d  forthkata min y--%d  forthkata amax--%d  forthkata maxyyy--%d",ForthKataMinX,ForthKataMinY,ForthKataMaxX,ForthKataMaxY);
        
        
        
        
        NSLog(@"fifthkata minx--%d  fifthkata min y--%d  fifthkata amax--%d  fifthkata maxyyy--%d",FifthKataMinX,FifthKataMinY,FifthKataMaxX,FifthKataMaxY);
        
        
        
        // float  angleInDegrees = arctan(deltaY / deltaX) * 180 / PI;
        
        
        
        
        
        
        //        float  firstkataAngle = atan2(30,-1) * 180 / 22*7;
        //        float  SecondkataAngle = atan2(30,-2) * 180 / 22*7;
        //        float  ThirdkataAngle = atan2(24,6) * 180 / 22*7;
        //        float  ForthkataAngle = atan2(-29,-3) * 180 / 22*7;
        //        float  FifthkataAngle = atan2(2,-31) * 180 / 22*7;
        
        NSMutableArray *arr =[[NSMutableArray alloc]init];
        for (int i=0; i<[SortedCircleArray count]; i++) {
            switch (i) {
                case 0:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(FirstKataMaxX+FirstKataMinX)/2],@"x",[NSNumber numberWithFloat:(FirstKataMaxY+FirstKataMinY)/2],@"y", nil]];
                }
                    
                    
                    break;
                    
                case 1:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(SecondKataMaxX+SecondKataMinX)/2],@"x",[NSNumber numberWithFloat:(SecondKataMaxY+SecondKataMinY)/2],@"y", nil]];
                    
                }
                    
                    break;
                    
                case 2:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(ThirdKataMaxX+ThirdKataMinX)/2],@"x",[NSNumber numberWithFloat:(ThirdKataMaxY+ThirdKataMinY)/2],@"y", nil]];
                }
                    
                    break;
                    
                case 3:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(ForthKataMaxX+ForthKataMinX)/2],@"x",[NSNumber numberWithFloat:(ForthKataMaxY+ForthKataMinY)/2],@"y", nil]];
                }
                    break;
                    
                case 4:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(FifthKataMaxX+FifthKataMinX)/2],@"x",[NSNumber numberWithFloat:(FifthKataMaxY+FifthKataMinY)/2],@"y", nil]];
                }
                    
                    break;
                    
                    
            }
            
            
        }
        
        //              NSArray *arr =[[NSArray alloc]initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(FirstKataMaxX+FirstKataMinX)/2],@"x",[NSNumber numberWithFloat:(FirstKataMaxY+FirstKataMinY)/2],@"y", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(SecondKataMaxX+SecondKataMinX)/2],@"x",[NSNumber numberWithFloat:(SecondKataMaxY+SecondKataMinY)/2],@"y", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(ThirdKataMaxX+ThirdKataMinX)/2],@"x",[NSNumber numberWithFloat:(ThirdKataMaxY+ThirdKataMinY)/2],@"y", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(ForthKataMaxX+ForthKataMinX)/2],@"x",[NSNumber numberWithFloat:(ForthKataMaxY+ForthKataMinY)/2],@"y", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(FifthKataMaxX+FifthKataMinX)/2],@"x",[NSNumber numberWithFloat:(FifthKataMaxY+FifthKataMinY)/2],@"y", nil], nil];
        
        
        //                NSArray *arr1 = @[
        //                                 @{@"count": @{@"x": @5,@"y": @5} },
        //                                 @{@"count": @{@"x": @9,@"y": @5} },
        //                                 @{@"count": @{@"x": @1,@"y": @5} },
        //                                 @{@"count": @{@"x": @100,@"y": @5} },
        //                                 ];
        //    NSLog(@"here in the arrrrrrrrrrrrrrrr11111--%@",arr1);
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"x" ascending:YES];
        
        NSArray *arr2 = [arr sortedArrayUsingDescriptors:@[sd]];
        //NSLog(@"the fffffffffffffffff---%@",arr2);
        float  firstkataAngle,SecondkataAngle,ThirdkataAngle,ForthkataAngle,FifthkataAngle;
        firstkataAngle=SecondkataAngle=ThirdkataAngle=ForthkataAngle=FifthkataAngle=0.0;
        NSMutableArray *AngleArray=[[NSMutableArray alloc]init];
        for (int i=0; i<[SortedCircleArray count]; i++) {
            switch (i) {
                case 0:
                {
                    firstkataAngle = atan2([[[SortedCircleArray objectAtIndex:0] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:0] objectForKey:@"y"] intValue],[[[SortedCircleArray objectAtIndex:0] objectForKey:@"x"] intValue]-[[[arr2 objectAtIndex:0] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    
                    [AngleArray addObject:[NSNumber numberWithFloat:firstkataAngle]];
                }
                    break;
                    
                case 1:
                {
                    SecondkataAngle = atan2([[[SortedCircleArray objectAtIndex:1] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:1] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:1] objectForKey:@"x"] intValue]-[[[SortedCircleArray objectAtIndex:1] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    [AngleArray addObject:[NSNumber numberWithFloat:SecondkataAngle]];
                }
                    break;
                case 2:
                {
                    ThirdkataAngle = atan2([[[SortedCircleArray objectAtIndex:2] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:2] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:2] objectForKey:@"x"] intValue]-[[[SortedCircleArray objectAtIndex:2] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    
                    [AngleArray addObject:[NSNumber numberWithFloat:ThirdkataAngle]];
                }
                    break;
                case 3:
                {
                    ForthkataAngle = atan2([[[SortedCircleArray objectAtIndex:3] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:3] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:3] objectForKey:@"x"] intValue]-[[[SortedCircleArray objectAtIndex:3] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    [AngleArray addObject:[NSNumber numberWithFloat:ForthkataAngle]];
                }
                    break;
                case 4:
                {
                    FifthkataAngle = atan2([[[SortedCircleArray objectAtIndex:4] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:4] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:4] objectForKey:@"x"] intValue]-[[[SortedCircleArray objectAtIndex:4] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    [AngleArray addObject:[NSNumber numberWithFloat:FifthkataAngle]];
                }
                    break;
                    
                    
                    
            }
        }
        
        
        
        
        
        
        
        
        
        //NSLog(@"-->%d  --->%d-->%d---%d",[[[SortedCircleArray objectAtIndex:4] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:4] objectForKey:@"y"] intValue],[[[SortedCircleArray objectAtIndex:4] objectForKey:@"x"] intValue],[[[arr2 objectAtIndex:4] objectForKey:@"x"] intValue]);
        
        
        //          NSLog(@"first average---xxx--%d  averageyyy--%d",(FirstKataMaxX+FirstKataMinX)/2,(FirstKataMaxY+FirstKataMinY)/2);
        //          NSLog(@"second  average---xxx--%d  averageyyy--%d",(SecondKataMaxX+SecondKataMinX)/2,(SecondKataMaxY+SecondKataMinY)/2);
        //          NSLog(@"third  average---xxx--%d  averageyyy--%d",(ThirdKataMaxX+ThirdKataMinX)/2,(ThirdKataMaxY+ThirdKataMinY)/2);
        //          NSLog(@"forth average---xxx--%d  averageyyy--%d",(ForthKataMaxX+ForthKataMinX)/2,(ForthKataMaxY+ForthKataMinY)/2);
        //          NSLog(@"fifth  average---xxx--%d  averageyyy--%d",(FifthKataMaxX+FifthKataMinX)/2,(FifthKataMaxY+FifthKataMinY)/2);
        // NSLog(@"firstkataAngle---->>%f SecondkataAngle-->%f ThirdkataAngle-->%f  ForthkataAngle-->%f  FifthkataAngle-->%f ",firstkataAngle,SecondkataAngle,ThirdkataAngle,ForthkataAngle,FifthkataAngle);
        
        //  NSMutableArray *AngleArray=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithFloat:firstkataAngle],[NSNumber numberWithFloat:SecondkataAngle],[NSNumber numberWithFloat:ThirdkataAngle],[NSNumber numberWithFloat:ForthkataAngle],[NSNumber numberWithFloat:FifthkataAngle], nil];
        
        
        for (int i=0; i<[AngleArray count]; i++) {
            
            
            
            
            
            switch (i)
            {
                case 0:
                case 2:
                case 4:
                    [self FindingTheRegionInClockWise:[[AngleArray objectAtIndex:i] floatValue] AndClockNo:i];
                    break;
                case 1:
                case 3:
                    [self FindingTheRegionInAntiClockWise:[[AngleArray objectAtIndex:i] floatValue] AndClockNo:i];
                    break;
                    
                    
                    
            }
            
        }
        
        
        
        
    } else {
        UIAlertView *Al=[[UIAlertView alloc]initWithTitle:@"message" message:@"scan again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [Al delegate];
        [Al show];
    }
    /////me
    
    
    
    
    // }
    
    
    
}
@end
