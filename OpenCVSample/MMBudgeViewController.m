//
//  MMBudgeViewController.m
//  MeterMaid
//
//  Created by Iphone_1 on 09/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMBudgeViewController.h"
#import "MMSideview.h"
#import "MMBudgetProductDayHourViewController.h"
#import "MMGlobalUrlClass.h"
#import "MMusagebillViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMUsageTreeViewController.h"
@interface MMBudgeViewController ()<UIGestureRecognizerDelegate>
{
    UIView *MainView;
    BOOL menuOpened,CurrentSelect,NewSelected;
    MMSideview *leftMenu;
    UIButton *Menubtn,*budgetbtn,*billbtn,*usagebtn,*phillbtn;
    UILabel *HeaderLbl;
    
    ///custom content labels
    
    UILabel *DynamicMonthLbl,*DollarLbl,*DollarIntLbl,*DollarFractionLbl;
    
    UIButton *CurrentDailyUsage,*monthlyDailyUsage, *weeklyDailyUsage;
    UILabel *dayLabel;
    UIButton *footerbudgtbtn,*footerauditbtn,*footercontinuebtn,*footerBackbtn;
    NSString *CurrUsageByDay,*NewUsageByDay;
    NSArray *IntTitle;
    NSArray *FracTitle;
    UIImageView *LeftImageView;
    UIImageView *RightImageView;
    NSArray *ImageTitleArray;
    UILabel *money;
    UISlider *leftSlide, *rightSlide;
    
    
}

@end

@implementation MMBudgeViewController
-(void)viewDidAppear:(BOOL)animated
{
    CurrentSelect=NewSelected=NO;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"MMBudgeViewController");
    
    ImageTitleArray =[[NSArray alloc]initWithObjects:_SelectedImageUrlStrFromPreviousPage,nil];
    
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
    
    HeaderLbl = [[UILabel alloc]init];
    
    [HeaderLbl setText:@"U S A G E"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:@"Arial" size:22.0f]];
    
    
    NSDictionary *HeaderAttDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [UIFont fontWithName:@"Arial" size:22], NSFontAttributeName,
                                   nil];
    
    CGRect  frame22 = [HeaderLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:HeaderAttDict
                                                   context:nil];
    
    HeaderLbl.backgroundColor=[UIColor clearColor];
    
    [HeaderLbl setFrame:CGRectMake(MainScreenWidth/2-frame22.size.width/2,23,frame22.size.width,frame22.size.height)];
    
    [MainView addSubview:HeaderLbl];
    
    
    
    
    //budget button ..........
    
    budgetbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [budgetbtn setFrame:CGRectMake(25.0f, 83.0f, 104/2, 85/2)];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"budgetselectedimg"] forState:UIControlStateNormal];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"budgetselectedimg"] forState:UIControlStateHighlighted];
    //[budgetbtn addTarget:self action:@selector(budget:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:budgetbtn];
    
    
    //bill button ..........
    
    billbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billbtn setFrame:CGRectMake(105.0f, 82.0f, 70/2, 84/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"Billselectedbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"Billselectedbtn"] forState:UIControlStateHighlighted];
    [billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(180.0f, 91.0f, 74/2, 65/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    //phill button ..........
    
    phillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phillbtn setFrame:CGRectMake(255, 84.0f, 56/2, 78/2)];
    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateNormal];
    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateHighlighted];
    //[phillbtn addTarget:self action:@selector(phill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:phillbtn];
    
    
    //START DOLLAR LABEL
    DollarLbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 125.0f, 15.0f, 60.0f)];
    DollarLbl.backgroundColor=[UIColor redColor];
    [DollarLbl setText:@"$"];
    [DollarLbl setTextAlignment:NSTextAlignmentLeft];
    [DollarLbl setTextColor:RGBCOLOR(182,206, 224, 1)];
    DollarLbl.numberOfLines = 1;
    [DollarLbl setBackgroundColor:[UIColor clearColor]];
    [DollarLbl setFont:[UIFont fontWithName:@"Helvetica-LT-Light" size:14]];
    [DollarLbl setFont:[UIFont systemFontOfSize:25]];
    [MainView addSubview:DollarLbl];
    
    // END OF DOLLAR LABEL
    
    //  START OF DOLLAR VALUE LABEL
    CGRect frame72 =CGRectMake(0, 0, 0, 0);
    _DollarIntLblStr=@"111";
    _DollarFractionLblStr=@"93";
    DollarIntLbl=[[UILabel alloc]init];
    [DollarIntLbl setText:[NSString stringWithFormat:@"%@.",_DollarIntLblStr]];
    
    DollarIntLbl.textAlignment=NSTextAlignmentLeft;
    //DollarIntLbl.textColor=RGBCOLOR(162, 190, 211, 1);
    
    
    DollarIntLbl.textColor=RGBCOLOR(182,206, 224, 1);
    DollarIntLbl.font=[UIFont fontWithName:@"Arial" size:54];
    
    NSDictionary *attributesDicCompTag = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"Arial" size:54], NSFontAttributeName,
                                          nil];
    
    frame72 = [DollarIntLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributesDicCompTag
                                              context:nil];
    
    DollarIntLbl.backgroundColor=[UIColor clearColor];
    
    [DollarIntLbl setFrame:CGRectMake(DollarLbl.frame.size.width+DollarLbl.frame.origin.x+5,DollarLbl.frame.origin.y+10,frame72.size.width,frame72.size.height)];
    
    [MainView addSubview:DollarIntLbl];
    
    
    _DollarFractionLblStr=@"93";
    DollarFractionLbl=[[UILabel alloc]init];
    [DollarFractionLbl setText:[NSString stringWithFormat:@"%@",_DollarFractionLblStr]];
    
    DollarFractionLbl.textAlignment=NSTextAlignmentLeft;
    DollarFractionLbl.textColor=RGBCOLOR(182,206, 224, 1);
    
    DollarFractionLbl.font=[UIFont fontWithName:@"Arial" size:24];
    
    NSDictionary *attributesDicCompTag1 = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Arial" size:24], NSFontAttributeName,
                                           nil];
    
    frame72 = [DollarFractionLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:attributesDicCompTag1
                                                   context:nil];
    
    DollarFractionLbl.backgroundColor=[UIColor clearColor];
    
    [DollarFractionLbl setFrame:CGRectMake(DollarIntLbl.frame.size.width+DollarIntLbl.frame.origin.x+5,DollarIntLbl.frame.origin.y+28,frame72.size.width,frame72.size.height)];
    
    [MainView addSubview:DollarFractionLbl];
    
    
    //    DollarIntLbl = [[UILabel alloc]initWithFrame:CGRectMake(DollarLbl.frame.size.width+DollarLbl.frame.origin.x, 133.0f, 100.0f, 100.0f)];
    //
    //    [DollarIntLbl setTextAlignment:NSTextAlignmentLeft];
    //    [DollarIntLbl setTextColor:RGBCOLOR(162, 190, 211, 1)];
    //    DollarIntLbl.numberOfLines = 1;
    //    [DollarIntLbl setBackgroundColor:[UIColor clearColor]];
    //    [DollarIntLbl setFont:[UIFont fontWithName:@"Helvetica-LT-Light" size:24]];
    //    [DollarIntLbl setFont:[UIFont systemFontOfSize:25]];
    //    [MainView addSubview:DollarIntLbl];
    
    
    
    ///    END OF DOLLAR VALUELABEL
    
    
    
    
    //START OF THE DYNAMIC MONTH LABEL
    
    DynamicMonthLbl = [[UILabel alloc]initWithFrame:CGRectMake(210.0f, 137.0f, 100.0f, 60.0f)];
    [DynamicMonthLbl setText:@"August Estimate"];
    [DynamicMonthLbl setTextAlignment:NSTextAlignmentLeft];
    [DynamicMonthLbl setTextColor:RGBCOLOR(182,206, 224, 1)];
    DynamicMonthLbl.numberOfLines = 2;
    [DynamicMonthLbl setBackgroundColor:[UIColor clearColor]];
    [DynamicMonthLbl setFont:[UIFont systemFontOfSize:17]];
    
    [MainView addSubview:DynamicMonthLbl];
    
    
    ///  END OF DYNAMIC MONTH LABEL VIEW
    
    money = [[UILabel alloc]initWithFrame:CGRectMake((MainView.frame.size.width/2.0f)-(50.0f/2.0f), DollarIntLbl.frame.origin.y+DollarIntLbl.frame.size.height+2.0f, 50.0f, 20.0f)];
    money.backgroundColor = [UIColor clearColor];
    money.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
    money.text = [NSString stringWithFormat:@"$0.23"];
    [MainView addSubview:money];
    
    UIImageView *dayView = [[UIImageView alloc]initWithFrame:CGRectMake((MainView.frame.size.width/2.0f)-(240.0f/2.0f),money.frame.origin.y+money.frame.size.height+2.0f, 240.0f, 40.0f)];
    [dayView setImage:[UIImage imageNamed:@"dayBack"]];
    dayView.backgroundColor = [UIColor clearColor];
    [MainView addSubview:dayView];
    
    
    //    //// -------------CURRENT WEEK MONTH BUTTON--------------
    
    dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f,0.0f, 240.0f, 40.0f)];
    [dayLabel setText:@"   Daily       Weekly     Monthly"];
    [dayLabel setTextAlignment:NSTextAlignmentCenter];
    [dayLabel setTextColor:[UIColor whiteColor]];
    dayLabel.numberOfLines = 1;
    [dayLabel setBackgroundColor:[UIColor clearColor]];
    [dayLabel setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
    [dayView addSubview:dayLabel];
    
    CurrentDailyUsage = [[UIButton alloc]initWithFrame:CGRectMake((MainView.frame.size.width/2.0f)-(240.0f/2.0f),money.frame.origin.y+money.frame.size.height+2.0f, 80.0f, 40.0f)];
    CurrentDailyUsage.backgroundColor = [UIColor clearColor];
    [CurrentDailyUsage setImage:[UIImage imageNamed:@"daySelectionBack"] forState:UIControlStateNormal];
    [CurrentDailyUsage setImage:[UIImage imageNamed:@"daySelectionBack"] forState:UIControlStateHighlighted];
    [CurrentDailyUsage addTarget:self action:@selector(currentUsage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:CurrentDailyUsage];
    
    weeklyDailyUsage = [[UIButton alloc]initWithFrame:CGRectMake(CurrentDailyUsage.frame.origin.x+CurrentDailyUsage.frame.size.width, money.frame.origin.y+money.frame.size.height+2.0f, 80.0f, 40.0f)];
    weeklyDailyUsage.backgroundColor = [UIColor clearColor];
    //    [weeklyDailyUsage setImage:[UIImage imageNamed:@"daySelectionBack"] forState:UIControlStateNormal];
    [weeklyDailyUsage setImage:[UIImage imageNamed:@"daySelectionBack"] forState:UIControlStateHighlighted];
    [weeklyDailyUsage addTarget:self action:@selector(weeklyUsage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weeklyDailyUsage];
    
    monthlyDailyUsage = [[UIButton alloc]initWithFrame:CGRectMake(weeklyDailyUsage.frame.origin.x+weeklyDailyUsage.frame.size.width, money.frame.origin.y+money.frame.size.height+2.0f, 80.0f, 40.0f)];
    monthlyDailyUsage.backgroundColor = [UIColor clearColor];
    //    [monthlyDailyUsage setImage:[UIImage imageNamed:@"daySelectionBack"] forState:UIControlStateNormal];
    [monthlyDailyUsage setImage:[UIImage imageNamed:@"daySelectionBack"] forState:UIControlStateHighlighted];
    [monthlyDailyUsage addTarget:self action:@selector(monthlyUsage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:monthlyDailyUsage];
    
    
    //
    //    CurrentDailyUsage = [[UILabel alloc]initWithFrame:CGRectMake(11.0f,186.0f, 100.0f, 60.0f)];
    //    [CurrentDailyUsage setText:@"Current\n Daily Usage"];
    //    [CurrentDailyUsage setTextAlignment:NSTextAlignmentCenter];
    //    [CurrentDailyUsage setTextColor:[UIColor whiteColor]];
    //    CurrentDailyUsage.numberOfLines = 2;
    //    [CurrentDailyUsage setBackgroundColor:[UIColor clearColor]];
    //    [CurrentDailyUsage setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
    //
    //    [MainView addSubview:CurrentDailyUsage];
    //
    //
    //
    //    ///  END OF CURENT DAILY LABEL
    //
    //
    //
    //    //// NEW DAILY USAGE LABEL
    //
    //    NewDailyUsage = [[UILabel alloc]initWithFrame:CGRectMake(208.0f,186.0f, 100.0f, 60.0f)];
    //    [NewDailyUsage setText:@"New\n Daily Usage"];
    //    [NewDailyUsage setTextAlignment:NSTextAlignmentCenter];
    //    [NewDailyUsage setTextColor:[UIColor whiteColor]];
    //    NewDailyUsage.numberOfLines = 2;
    //    [NewDailyUsage setBackgroundColor:[UIColor clearColor]];
    //    [NewDailyUsage setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
    //
    //    [MainView addSubview:NewDailyUsage];
    
    
    
    ///  END OF CURENT DAILY LABEL
    
    //START OF LEFT BACK LABEL
    
    LeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, dayView.frame.origin.y+dayView.frame.size.height+6, 211/2, 503/2)];
    [LeftImageView setImage:[UIImage imageNamed:@"LeftBackImage"]];
    [LeftImageView setUserInteractionEnabled:YES];
    [MainView addSubview:LeftImageView];
    
    
    //  END OF  LEFT BACK LABEL
    
    UILabel *labelMiddle = [[UILabel alloc]init];
    labelMiddle.frame = CGRectMake(LeftImageView.frame.origin.x+LeftImageView.frame.size.width+3.0f, dayView.frame.origin.y+dayView.frame.size.height+10.0f, 90.0f, 120.0f);
    labelMiddle.numberOfLines = 2;
    labelMiddle.text = @"Hours Of Device Use";
    labelMiddle.textColor = [UIColor whiteColor];
    labelMiddle.textAlignment = NSTextAlignmentCenter;
    labelMiddle.font = [UIFont fontWithName:GLOBALTEXTFONT size:15.0f];
    [MainView addSubview:labelMiddle];
    
    //START OF Right BACK LABEL
    
    RightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth-211/2, dayView.frame.origin.y+dayView.frame.size.height+6, 211/2, 503/2)];
    [RightImageView setImage:[UIImage imageNamed:@"RightBackImage"]];
    [RightImageView setUserInteractionEnabled:YES];
    [MainView addSubview:RightImageView];
    
    
    //  END OF  Right BACK LABEL
    
    
    /////  start of the middle image
    
    
    UIImage *IMg=[UIImage imageNamed:@"PlasmaTV"];//[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_SelectedImageUrlStrFromPreviousPage]]];  //------PK
    
    
    UIImageView *ProductImageView=[[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth/2-155/4, LeftImageView.frame.origin.y+130, 155/2, 155/2)];
    [MainView addSubview:ProductImageView];
    [ProductImageView setImage:IMg];
    
    /////   end of the middle image
    
    UILabel *TitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(ProductImageView.frame.origin.x-10, ProductImageView.frame.origin.y+ProductImageView.frame.size.height+2, ProductImageView.frame.size.width+20, 20)];
    TitleLbl.textColor =[UIColor whiteColor];
    TitleLbl.textAlignment=NSTextAlignmentCenter;
    TitleLbl.adjustsFontSizeToFitWidth=YES;
    TitleLbl.font=[UIFont systemFontOfSize:15];
    [MainView addSubview:TitleLbl];
    [TitleLbl setText:_DeviceTitle];
    
    UILabel *WattLbl=[[UILabel alloc]initWithFrame:CGRectMake(ProductImageView.frame.origin.x-10, ProductImageView.frame.origin.y-25, ProductImageView.frame.size.width+20, 20)];
    WattLbl.textColor =[UIColor whiteColor];
    WattLbl.textAlignment=NSTextAlignmentCenter;
    WattLbl.adjustsFontSizeToFitWidth=YES;
    WattLbl.font=[UIFont systemFontOfSize:19];
    [MainView addSubview:WattLbl];
    [WattLbl setText:[NSString stringWithFormat:@"%@",_WattString]];
    
    
    
    
    IntTitle=[[NSArray alloc]initWithObjects:@"5",@"4",@"4",@"3",@"3",@"3",@"2",@"2", nil];
    FracTitle=[[NSArray alloc]initWithObjects:@"",@".5",@"",@".5",@".5",@"",@".5",@"", nil];
    
    //    CGRect PreFrame=CGRectMake(0, 0, 0, 0);
    //    for (int i=0; i<8; i++) {
    //
    //        UIView *ContainerView=[[UIView alloc] initWithFrame:CGRectMake(0, PreFrame.origin.y,LeftImageView.frame.size.width,  LeftImageView.frame.size.height/4)];
    //        ContainerView.tag=i;
    //        if (i<=3) {
    //
    //             [LeftImageView addSubview:ContainerView];
    //        }
    //        else
    //        {
    //             [RightImageView addSubview:ContainerView];
    //        }
    //
    //        ContainerView.backgroundColor=[UIColor clearColor];
    //        UITapGestureRecognizer *Tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnHour:)];
    //        [ContainerView addGestureRecognizer:Tap];
    //        Tap.numberOfTapsRequired=1;
    //        Tap.delegate=self;
    //
    //
    //
    //        UILabel *FracLbl=[[UILabel alloc]init];
    //        [FracLbl setFont:[UIFont fontWithName:@"Arial" size:13]];
    //        [FracLbl setTextColor: [UIColor whiteColor]];
    //
    //        [FracLbl setTextAlignment:NSTextAlignmentRight];
    //        [FracLbl setText:[NSString stringWithFormat:@"%@ hours",[FracTitle objectAtIndex:i]]];
    //
    //
    //        NSDictionary *HeaderAttDict = [NSDictionary dictionaryWithObjectsAndKeys:
    //                                       [UIFont fontWithName:@"Arial" size:13], NSFontAttributeName,
    //                                       nil];
    //
    //        CGRect  frame22 = [FracLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
    //                                                       options:NSStringDrawingUsesLineFragmentOrigin
    //                                                    attributes:HeaderAttDict
    //                                                       context:nil];
    //
    //       [FracLbl setBackgroundColor:[UIColor clearColor]];
    //
    //        [FracLbl setFrame:CGRectMake(ContainerView.frame.size.width/2-4+6+(ContainerView.frame.size.width/2-6-frame22.size.width), 0, frame22.size.width, ContainerView.frame.size.height)];
    //        [ContainerView addSubview:FracLbl];
    //
    //        UILabel *IntLbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, ContainerView.frame.size.width-FracLbl.frame.size.width-4, ContainerView.frame.size.height)];
    //        [IntLbl setFont:[UIFont fontWithName:@"Arial" size:17]];
    //        [IntLbl setTextColor: [UIColor whiteColor]];
    //        [IntLbl setTextAlignment:NSTextAlignmentRight];
    //        [IntLbl setText:[NSString stringWithFormat:@"%@",[IntTitle objectAtIndex:i]]];
    //        [ContainerView addSubview:IntLbl];
    //
    //        [IntLbl setUserInteractionEnabled:YES];
    //        [FracLbl setUserInteractionEnabled:YES];
    //
    //        PreFrame=ContainerView.frame;
    //        PreFrame.origin.y=ContainerView.frame.origin.y+ContainerView.frame.size.height;
    //        if (i==3) {
    //            PreFrame.origin.y=0;
    //        }
    //
    //    }
    
    //----------PK SLIDER------------//
    
    leftSlide = [[UISlider alloc]init];
    leftSlide.tag=1;
    leftSlide.frame = CGRectMake(LeftImageView.frame.origin.x-90, LeftImageView.frame.size.height-130.0f, 240.0f, 10.0f);
    leftSlide.backgroundColor = [UIColor clearColor];
    [leftSlide setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [leftSlide setThumbImage:[UIImage imageNamed:@"slideThumb"] forState:UIControlStateNormal];
    [leftSlide setMinimumTrackTintColor:[UIColor redColor]];
    leftSlide.minimumValue = 3.5f;
    leftSlide.maximumValue = 5.0f;
    [leftSlide addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [LeftImageView addSubview:leftSlide];
    
    rightSlide = [[UISlider alloc]init];
    rightSlide.tag=2;
    rightSlide.frame = CGRectMake(RightImageView.frame.size.width-150.0f, RightImageView.frame.size.height-130.0f, 240.0f, 10.0f);
    rightSlide.backgroundColor = [UIColor clearColor];
    [rightSlide setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
    [rightSlide setThumbImage:[UIImage imageNamed:@"slideThumb"] forState:UIControlStateNormal];
    [rightSlide setMinimumTrackTintColor:[UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f]];
    rightSlide.minimumValue = 2.0f;
    rightSlide.maximumValue = 3.5f;
    [rightSlide addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventTouchUpInside];
    [RightImageView addSubview:rightSlide];
    
    
    //------------PK LEFT LABEL------------//
    
    //    self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftSlide.frame.origin.x+leftSlide.frame.size.width+5.0f, 0.0f, 40.0f, 30.0f)];
    
    self.leftLabel =[[UILabel alloc]init];
    [self.leftLabel setFrame:CGRectMake(50,205,30,50)];
    self.leftLabel.text = @"Now 3.5";
    [self.leftLabel setTextAlignment:NSTextAlignmentCenter];
    CurrUsageByDay=@"3.5";
    self.leftLabel.backgroundColor = [UIColor clearColor];
    self.leftLabel.textColor = [UIColor whiteColor];
    self.leftLabel.numberOfLines = 2;
    self.leftLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:12.0f];
    [LeftImageView addSubview:self.leftLabel];
    
    
    //--------------RIGHT LABEL---------------//
    
    self.rightLabel=[[UILabel alloc]init];
    [self.rightLabel setFrame:CGRectMake(25,205,30,50)];
    self.rightLabel.text = @"New 2.0";
    [self.rightLabel setTextAlignment:NSTextAlignmentCenter ];
    self.rightLabel.backgroundColor = [UIColor clearColor];
    self.rightLabel.textColor = [UIColor whiteColor];
    self.rightLabel.numberOfLines = 2;
    self.rightLabel.textColor=[UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1];
    NewUsageByDay=@"2.0";
    self.rightLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:12.0f];
    [RightImageView addSubview:self.rightLabel];
    
    
    //footerview.........========..........=====.....//
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    
    //    footerbudgtbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [footerbudgtbtn setFrame:CGRectMake(20.0f, 4.0f, 31.5f, 35.0f)];
    //    [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerbudght"] forState:UIControlStateNormal];
    //    [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerbudght"] forState:UIControlStateHighlighted];
    //    [footerbudgtbtn addTarget:self action:@selector(footerbudget:) forControlEvents:UIControlEventTouchUpInside];
    //    [UsBackView8 addSubview:footerbudgtbtn];
    
    footerBackbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerBackbtn setFrame:CGRectMake(20.0f, 4.0f, 30.5f, 35.0f)];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateNormal];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateHighlighted];
    [footerBackbtn addTarget:self action:@selector(footerBack:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerBackbtn];
    
    
    footerauditbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerauditbtn setFrame:CGRectMake(100.0f, 5.0f, 23.0f, 33.0f)];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedauditbudht"] forState:UIControlStateNormal];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedauditbudht"] forState:UIControlStateHighlighted];
    [footerauditbtn addTarget:self action:@selector(footeraudit:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerauditbtn];
    
    
    
    
    //    footerBackbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [footerBackbtn setFrame:CGRectMake(190.0f, 3.0f, 54/2.0f, 70/2.0f)];
    //    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateNormal];
    //    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateHighlighted];
    //    [footerBackbtn addTarget:self action:@selector(footerBack:) forControlEvents:UIControlEventTouchUpInside];
    //    [UsBackView8 addSubview:footerBackbtn];
    
    
    footercontinuebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footercontinuebtn setFrame:CGRectMake(265.0f, -6.0f, 55.0f, 55.0f)];
    [footercontinuebtn setBackgroundImage:[UIImage imageNamed:@"saveButton"] forState:UIControlStateNormal];
    [footercontinuebtn setBackgroundImage:[UIImage imageNamed:@"saveButton"] forState:UIControlStateHighlighted];
    [footercontinuebtn addTarget:self action:@selector(footerAddFunction:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footercontinuebtn];
    
    // Do any additional setup after loading the view.
}

-(void)sliderValueChanged:(UISlider *)sender    //-----------------PK
{
    // depending on the value
    // if value is 1 {
    NSLog(@"SLIDERRRR CHANGE----> %2f",(float)sender.value);
    //    NSString *str = [NSString stringWithFormat:@"%f",sender.value];
    //    str = [str substringWithRange:NSMakeRange(0,3)];
    //    NSLog(@"######## %@",str);
    //    self.getSliderValue=str;
    
    if(sender.tag==1)
    {
        if ((float)sender.value >= 3.500000 && (float)sender.value < 4.000000)
        {
            
            [self.leftLabel setFrame:CGRectMake(50,205,30,50)];
            self.leftLabel.text = @"Now 3.5";
            CurrUsageByDay=@"3.5";
            
        }
        
        else if ((float)sender.value >= 4.000000 && (float)sender.value < 4.500000)
        {
            [self.leftLabel setFrame:CGRectMake(50,132,30,50)];
            self.leftLabel.text = @"Now 4.0";
            CurrUsageByDay=@"4.0";
            
            
        }
        else if ((float)sender.value >= 4.500000 && (float)sender.value < 5.000000 )
        {
            [self.leftLabel setFrame:CGRectMake(50,60,30,50)];
            self.leftLabel.text = @"Now 4.5";
            CurrUsageByDay=@"4.5";
            
            
        }
        else if((float)sender.value == 5.000000)
        {  // if ((float)sender.value >= 5.000000){
            [self.leftLabel setFrame:CGRectMake(50,0,30,50)];
            self.leftLabel.text = @"Now 5.0";
            CurrUsageByDay=@"5.0";
            
            
        }
    }
    
    else
    {
        if ((float)sender.value >= 2.000000 && (float)sender.value < 2.50000)
        {
            
            [self.rightLabel setFrame:CGRectMake(25,205,30,50)];
            self.rightLabel.text = @"New 2.0";
            NewUsageByDay=@"2.0";
            
            
        }
        
        else if ((float)sender.value >= 2.500000 && (float)sender.value < 3.000000)
        {
            [self.rightLabel setFrame:CGRectMake(25,132,30,50)];
            self.rightLabel.text = @"New 2.5";
            NewUsageByDay=@"2.5";
            
        }
        else if ((float)sender.value >= 3.000000 && (float)sender.value < 3.500000 )
        {
            [self.rightLabel setFrame:CGRectMake(25,60,30,50)];
            self.rightLabel.text = @"New 3.0";
            NewUsageByDay=@"3.0";
            
            
        }
        else if((float)sender.value == 3.500000)
        {  // if ((float)sender.value >= 5.000000){
            [self.rightLabel setFrame:CGRectMake(25,0,30,50)];
            self.rightLabel.text = @"New 3.5";
            NewUsageByDay=@"3.5";
            
        }
        
    }
    
    
}

-(void)footerbudget:(UIButton *)sender
{
    
    MMUsageBudgetViewController *UsageBudgetObj=[[MMUsageBudgetViewController alloc]init];
    [[self navigationController]pushViewController:UsageBudgetObj animated:NO];
}
-(void)footerBack:(UIButton *)sender
{
    
    
    [[self navigationController]popViewControllerAnimated:NO];
    
}
-(void)footeraudit:(UIButton *)sender
{
    
    
}

-(void)deselect
{
    for (UIView *Subview in LeftImageView.subviews) {
        if ([Subview isKindOfClass:NSClassFromString(@"UIView")]) {
            UIView *GetView=(UIView *)Subview;
            [GetView setBackgroundColor:[UIColor clearColor]];
            
        }
    }
    
    
    for (UIView *Subview in RightImageView.subviews) {
        if ([Subview isKindOfClass:NSClassFromString(@"UIView")]) {
            UIView *GetView=(UIView *)Subview;
            [GetView setBackgroundColor:[UIColor clearColor]];
        }
    }
}

-(void)footerAddFunction:(UIButton *)sender
{
    //NewUsageByDay=@"2.5";
    
    NSLog(@"CURRUSAGE.....%@",CurrUsageByDay);
    //    if (CurrentSelect && NewSelected) {
    
    //        dispatch_queue_t Queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    //        dispatch_async(Queue, ^{
    
    //            NSString *ResponseStr=[[MMGlobalUrlClass GetInstance] GlobalUrlFireToGetResponseString:[ NSString stringWithFormat:@"budget_details.php?user_id=%@&device_id=%d&wattage=%@&current_daily_usage=%@&new_daily_usage=%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"id"],_SelectedProductTag,_WattString,CurrUsageByDay,NewUsageByDay]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *ResponseStr = [[NSString alloc]init];
        
        ResponseStr = [NSString stringWithFormat:@"%@/budget_details.php?user_id=%@&device_id=%d&wattage=%@&current_daily_usage=%@&new_daily_usage=%@",DOMAIN_APP_URL,[[NSUserDefaults standardUserDefaults] objectForKey:@"id"],_SelectedProductTag,[_WattString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],CurrUsageByDay,NewUsageByDay];
        
        NSLog(@"%@",ResponseStr);
        
        NSError *error=nil;
        
        
        NSData *ResponceData=[NSData dataWithContentsOfURL:[NSURL URLWithString:ResponseStr]options:NSDataReadingUncached error:&error];
        
        
        
        NSString *success = [[NSString alloc] initWithData:ResponceData encoding:NSASCIIStringEncoding];
        
        
        
        if ([success isEqualToString:@"success"]) {
            [self deselect];
            
            
            MMBudgetProductDayHourViewController *BudgetProductObj=[[MMBudgetProductDayHourViewController alloc]init];
            [BudgetProductObj setNewUsageStrByDay:NewUsageByDay];
            [BudgetProductObj setCurrUsageStrByDay:CurrUsageByDay];
            [BudgetProductObj setDeviceTitle:_DeviceTitle];
            [BudgetProductObj setWattString:_WattString];
            [BudgetProductObj setSelectedImageUrl:_SelectedImageUrlStrFromPreviousPage];
            [[self navigationController] pushViewController:BudgetProductObj animated:NO];
            
        } else {
            UIAlertView *ChangePassAlert=[[UIAlertView  alloc]initWithTitle:@"Alert!" message:@"check your internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            ChangePassAlert.delegate=self;
            [ChangePassAlert show];
        }
        
        //[self checkLoader];
        
        
        
    });
    
    
    
    
    
    
    //
    //    } else {
    //        UIAlertView *AlertView=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select current and daily usage" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    //        AlertView.delegate=self;
    //        [AlertView show];
    //
    //    }
    
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
-(void)tapOnHour:(UIGestureRecognizer *)Gesture
{
    
    
    
    if (Gesture.view.tag<=3) {
        CurrentSelect=YES;
        for (UIView *Subview in LeftImageView.subviews) {
            if ([Subview isKindOfClass:NSClassFromString(@"UIView")]) {
                UIView *GetView=(UIView *)Subview;
                if (GetView.tag==Gesture.view.tag) {
                    [GetView setBackgroundColor:RGBCOLOR(116, 154, 186, 1)];
                }
                else
                {
                    [GetView setBackgroundColor:[UIColor clearColor]];
                    
                }
                
                
                
            }
        }
        
        CurrUsageByDay=[NSString stringWithFormat:@"%@%@",[IntTitle objectAtIndex:Gesture.view.tag],[FracTitle objectAtIndex:Gesture.view.tag]];
    }
    else
    {
        NewSelected=YES;
        
        for (UIView *Subview in RightImageView.subviews) {
            if ([Subview isKindOfClass:NSClassFromString(@"UIView")]) {
                UIView *GetView=(UIView *)Subview;
                if (GetView.tag==Gesture.view.tag) {
                    [GetView setBackgroundColor:RGBCOLOR(116, 154, 186, 1)];
                }
                else
                {
                    [GetView setBackgroundColor:[UIColor clearColor]];
                    
                }
                
            }
            
            
        }
        NewUsageByDay=[NSString stringWithFormat:@"%@%@",[IntTitle objectAtIndex:Gesture.view.tag],[FracTitle objectAtIndex:Gesture.view.tag]];
    }
    
}
-(void)bill:(UIButton *)sender{
    
    MMusagebillViewController *bill = [[MMusagebillViewController alloc]init];
    [self.navigationController pushViewController:bill animated:NO];
    
}
-(void)currentUsage:(UIButton *)sender{
    
    NSLog(@"CURRENT USAGE");
    [CurrentDailyUsage setImage:[UIImage imageNamed:@"daySelectionBack"] forState:UIControlStateNormal];
    [monthlyDailyUsage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [weeklyDailyUsage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}
-(void)weeklyUsage:(UIButton *)sender{
    
    NSLog(@"weekly USAGE");
    [weeklyDailyUsage setImage:[UIImage imageNamed:@"daySelectionBack"] forState:UIControlStateNormal];
    [CurrentDailyUsage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [monthlyDailyUsage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
}
-(void)monthlyUsage:(UIButton *)sender{
    
    NSLog(@"monthly USAGE");
    [monthlyDailyUsage setImage:[UIImage imageNamed:@"daySelectionBack"] forState:UIControlStateNormal];
    [CurrentDailyUsage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [weeklyDailyUsage setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}

-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *view = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
