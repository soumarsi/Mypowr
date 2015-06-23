//
//  MMBudgetProductDayHourViewController.m
//  MeterMaid
//
//  Created by Iphone_1 on 09/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMBudgetProductDayHourViewController.h"
#import "MMProductBudgetListViewController.h"
#import "MMSideview.h"
#import "MMGlobalFunctionClass.h"
#import "MMUsageBudgetViewController.h"
#import "MMAppDelegate.h"
#import "UIImageView+WebCache.h"
#import "MMGlobalUrlClass.h"
#import "MMusagebillViewController.h"
#import "MMUsageTreeViewController.h"
@interface MMBudgetProductDayHourViewController ()<UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>
{
    UIView *MainView;
    MMSideview *leftMenu;
    UIButton *Menubtn,*budgetbtn,*billbtn,*usagebtn,*phillbtn;
    UILabel *HeaderLbl,*DollarLbl,*DollarIntLbl,*DollarFractionLbl,*DynamicMonthLbl,*BracketLbl,*CurrentDailyUsage,*NewDailyUsage;
    
    UILabel *CurrDollarLbl,*CurrDollarIntLbl,*CurrDollarFractionLbl,*NewDollarLbl,*NewDollarIntLbl,*NewDollarFractionLbl;
    BOOL menuOpened,IsImageChoosed,WattagePicked,SelectedToRemove;
    
    /// menu buttons
    UIButton *footerbudgtbtn,*footerauditbtn,*footerBackbtn,*footercontinuebtn,*FooterRemoveBtn;
    
    UIView *ContainerPopUpView;
    UIActivityIndicatorView *spinner;
    UIImage *ChoosedImage;
    UIPickerView *WattagePicker;
    UIView *DeviceAdditionPopUpView,*DevicePopUpBackView;
    NSString *PickerSelectDay;
    
    NSArray *PickerArray;
    UITextField *DeviceTitleField,*DeviceWattage;
    UIImageView *DeviceImageView;
    NSOperationQueue *reportQueue;
    UIScrollView *ContacinerScroll;
    NSInteger SelectedDeviceToRemoveTag;
}

@end

@implementation MMBudgetProductDayHourViewController
-(void)viewDidAppear:(BOOL)animated
{
    SelectedToRemove=NO;
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"MMBudgetProductDayHourViewController");
    
     IsImageChoosed=NO;
    WattagePicked=NO;
     PickerArray=[[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30", nil];
      //NSArray *ImageTitleArray=[[NSArray alloc]initWithObjects:@"plasmatvimg",@"heaterSmall",nil];
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
//    //[phillbtn addTarget:self action:@selector(phill:) forControlEvents:UIControlEventTouchUpInside];
//    [MainView addSubview:phillbtn];
    

    
    
    
    //START DOLLAR LABEL
    DollarLbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 125.0f, 15.0f, 60.0f)];
   
    [DollarLbl setText:@"$"];
    [DollarLbl setTextAlignment:NSTextAlignmentLeft];
    [DollarLbl setTextColor:[UIColor whiteColor]];
    DollarLbl.numberOfLines = 1;
    [DollarLbl setBackgroundColor:[UIColor clearColor]];
    [DollarLbl setFont:[UIFont fontWithName:@"Helvetica-LT-Light" size:14]];
    [DollarLbl setFont:[UIFont systemFontOfSize:25]];
    [MainView addSubview:DollarLbl];
    
    // END OF DOLLAR LABEL
    
    //  START OF DOLLAR VALUE LABEL
    CGRect frame72 =CGRectMake(0, 0, 0, 0);
    _DollarIntLblStr=@"110";
    
    DollarIntLbl=[[UILabel alloc]init];
    [DollarIntLbl setText:[NSString stringWithFormat:@"%@.",_DollarIntLblStr]];
    
    DollarIntLbl.textAlignment=NSTextAlignmentLeft;
    DollarIntLbl.textColor=[UIColor whiteColor];
    
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
    
    
    _DollarFractionLblStr=@"37";
    DollarFractionLbl=[[UILabel alloc]init];
    [DollarFractionLbl setText:[NSString stringWithFormat:@"%@",_DollarFractionLblStr]];
    
    DollarFractionLbl.textAlignment=NSTextAlignmentLeft;
    DollarFractionLbl.textColor=[UIColor whiteColor];
    
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
    [DynamicMonthLbl setTextColor:[UIColor whiteColor]];
    DynamicMonthLbl.numberOfLines = 2;
    [DynamicMonthLbl setBackgroundColor:[UIColor clearColor]];
    [DynamicMonthLbl setFont:[UIFont systemFontOfSize:17]];
    
    [MainView addSubview:DynamicMonthLbl];
    
    

    _DollarBracketStr=@"0.56";
    BracketLbl=[[UILabel alloc]init];
    [BracketLbl setText:[NSString stringWithFormat:@"($%@)",_DollarBracketStr]];
    
    BracketLbl.textAlignment=NSTextAlignmentLeft;
    BracketLbl.textColor=RGBCOLOR(164, 255, 248, 1);
    
    BracketLbl.font=[UIFont fontWithName:@"Arial" size:14];
    
    NSDictionary *BrackAttDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Arial" size:14], NSFontAttributeName,
                                           nil];
    
 CGRect   frame76 = [BracketLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:BrackAttDict
                                                   context:nil];
    
    BracketLbl.backgroundColor=[UIColor clearColor];
    
    [BracketLbl setFrame:CGRectMake(DollarIntLbl.frame.size.width+DollarIntLbl.frame.origin.x-15,DollarIntLbl.frame.origin.y+DollarIntLbl.frame.size.height+0,frame76.size.width,frame76.size.height)];
    
    [MainView addSubview:BracketLbl];
    
    
    
    ////START CURRENT DAILY USAGE LABEL
    
    CurrentDailyUsage = [[UILabel alloc]initWithFrame:CGRectMake(11.0f,240.0f, 100.0f, 26.0f)];
    [CurrentDailyUsage setText:@"Current"];
    [CurrentDailyUsage setTextAlignment:NSTextAlignmentCenter];
    [CurrentDailyUsage setTextColor:[UIColor whiteColor]];
    CurrentDailyUsage.numberOfLines = 1;
    [CurrentDailyUsage setBackgroundColor:[UIColor clearColor]];
    [CurrentDailyUsage setFont:[UIFont systemFontOfSize:17]];
    
    [MainView addSubview:CurrentDailyUsage];
    
    
    
    ///  END OF CURENT DAILY LABEL
    
    
    
    //// NEW DAILY USAGE LABEL
    
    NewDailyUsage = [[UILabel alloc]initWithFrame:CGRectMake(211.0f,240.0f, 100.0f, 26.0f)];
    [NewDailyUsage setText:@"New"];
    [NewDailyUsage setTextAlignment:NSTextAlignmentCenter];
    [NewDailyUsage setTextColor:[UIColor whiteColor]];
    NewDailyUsage.numberOfLines =1;
    [NewDailyUsage setBackgroundColor:[UIColor clearColor]];
    [NewDailyUsage setFont:[UIFont systemFontOfSize:17]];
    
    [MainView addSubview:NewDailyUsage];
    
    
    
    ///  END OF NEW DAILY LABEL
    
///////////////////////////////////////////////////////////////
    
    
    
    
    //START DOLLAR LABEL
    CurrDollarLbl = [[UILabel alloc]initWithFrame:CGRectMake(23.0f, CurrentDailyUsage.frame.origin.y+CurrentDailyUsage.frame.size.height, 15.0f, 40.0f)];
    CurrDollarLbl.backgroundColor=[UIColor clearColor];
    [CurrDollarLbl setText:@"$"];
    [CurrDollarLbl setTextAlignment:NSTextAlignmentLeft];
    [CurrDollarLbl setTextColor:[UIColor whiteColor]];
    CurrDollarLbl.numberOfLines = 1;
   
    [CurrDollarLbl setFont:[UIFont fontWithName:@"Arial" size:20]];
    
    [MainView addSubview:CurrDollarLbl];
    
    // END OF DOLLAR LABEL
    
    //  START OF DOLLAR VALUE LABEL
    CGRect frame85 =CGRectMake(0, 0, 0, 0);
    _CurrDollarIntLblStr=@"1";
    
    CurrDollarIntLbl=[[UILabel alloc]init];
    [CurrDollarIntLbl setText:[NSString stringWithFormat:@"%@.",_CurrDollarIntLblStr]];
    
    CurrDollarIntLbl.textAlignment=NSTextAlignmentLeft;
    CurrDollarIntLbl.textColor=[UIColor whiteColor];
    
    CurrDollarIntLbl.font=[UIFont fontWithName:@"Arial" size:36];
    
    NSDictionary *IntDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"Arial" size:36], NSFontAttributeName,
                                          nil];
    
    frame85 = [CurrDollarIntLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:IntDict
                                              context:nil];
    
    CurrDollarIntLbl.backgroundColor=[UIColor clearColor];
    
    [CurrDollarIntLbl setFrame:CGRectMake(CurrDollarLbl.frame.size.width+CurrDollarLbl.frame.origin.x,CurrDollarLbl.frame.origin.y+3,frame85.size.width,frame85.size.height)];
    
    [MainView addSubview:CurrDollarIntLbl];
    
    
    _CurrDollarFractionLblStr=@"08";
    CurrDollarFractionLbl=[[UILabel alloc]init];
    [CurrDollarFractionLbl setText:[NSString stringWithFormat:@"%@",_CurrDollarFractionLblStr]];
    
    CurrDollarFractionLbl.textAlignment=NSTextAlignmentLeft;
    CurrDollarFractionLbl.textColor=[UIColor whiteColor];
    
    CurrDollarFractionLbl.font=[UIFont fontWithName:@"Arial" size:18];
    
    NSDictionary *FracDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Arial" size:18], NSFontAttributeName,
                                           nil];
    
    frame85 = [CurrDollarFractionLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
                                                   options:NSStringDrawingUsesLineFragmentOrigin
                                                attributes:FracDict
                                                   context:nil];
    
    CurrDollarFractionLbl.backgroundColor=[UIColor clearColor];
    
    [CurrDollarFractionLbl setFrame:CGRectMake(CurrDollarIntLbl.frame.size.width+CurrDollarIntLbl.frame.origin.x+1,CurrDollarIntLbl.frame.origin.y+16,frame85.size.width,frame85.size.height)];
    
    [MainView addSubview:CurrDollarFractionLbl];
    
    
    
    /////////////////////////////////////////////////////////////
    
    
    
    
    //START DOLLAR LABEL
    NewDollarLbl = [[UILabel alloc]initWithFrame:CGRectMake(NewDailyUsage.frame.origin.x+10, NewDailyUsage.frame.origin.y+NewDailyUsage.frame.size.height, 15.0f, 40.0f)];
    NewDollarLbl.backgroundColor=[UIColor clearColor];
    [NewDollarLbl setText:@"$"];
    [NewDollarLbl setTextAlignment:NSTextAlignmentLeft];
    [NewDollarLbl setTextColor:RGBCOLOR(164, 255, 248, 1)];
    NewDollarLbl.numberOfLines = 1;
    
    [NewDollarLbl setFont:[UIFont fontWithName:@"Arial" size:20]];
    
    [MainView addSubview:NewDollarLbl];
    
    // END OF DOLLAR LABEL
    
    //  START OF DOLLAR VALUE LABEL
   frame85 =CGRectMake(0, 0, 0, 0);
    _NewDollarIntLblStr=@"0";
    
   NewDollarIntLbl=[[UILabel alloc]init];
    [NewDollarIntLbl setText:[NSString stringWithFormat:@"%@.",_NewDollarIntLblStr]];
    
    NewDollarIntLbl.textAlignment=NSTextAlignmentLeft;
    NewDollarIntLbl.textColor=RGBCOLOR(164, 255, 248, 1);;
    
    NewDollarIntLbl.font=[UIFont fontWithName:@"Arial" size:36];
    
    IntDict = [NSDictionary dictionaryWithObjectsAndKeys:
                             [UIFont fontWithName:@"Arial" size:36], NSFontAttributeName,
                             nil];
    
    frame85 = [NewDollarIntLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:IntDict
                                                  context:nil];
    
    NewDollarIntLbl.backgroundColor=[UIColor clearColor];
    
    [NewDollarIntLbl setFrame:CGRectMake(NewDollarLbl.frame.size.width+NewDollarLbl.frame.origin.x,NewDollarLbl.frame.origin.y+3,frame85.size.width,frame85.size.height)];
    
    [MainView addSubview:NewDollarIntLbl];
    
    
    _NewDollarFractionLblStr=@"56";
   NewDollarFractionLbl=[[UILabel alloc]init];
    [NewDollarFractionLbl setText:[NSString stringWithFormat:@"%@",_NewDollarFractionLblStr]];
    
    NewDollarFractionLbl.textAlignment=NSTextAlignmentLeft;
    NewDollarFractionLbl.textColor=RGBCOLOR(164, 255, 248, 1);;
    
    NewDollarFractionLbl.font=[UIFont fontWithName:@"Arial" size:18];
    
  FracDict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [UIFont fontWithName:@"Arial" size:18], NSFontAttributeName,
                              nil];
    
    frame85 = [NewDollarFractionLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                    attributes:FracDict
                                                       context:nil];
    
    NewDollarFractionLbl.backgroundColor=[UIColor clearColor];
    
    [NewDollarFractionLbl setFrame:CGRectMake(NewDollarIntLbl.frame.size.width+NewDollarIntLbl.frame.origin.x+1,NewDollarIntLbl.frame.origin.y+16,frame85.size.width,frame85.size.height)];
    
    [MainView addSubview:NewDollarFractionLbl];
    

//////////////////////////////////////////////////////////////////
    
    
    //START OF LEFT BACK LABEL
    
    UIImageView *LeftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, CurrDollarIntLbl.frame.origin.y+CurrDollarIntLbl.frame.size.height+1, 249/2, 90/2)];
    [LeftImageView setImage:[UIImage imageNamed:@"RightHourDayImage"]];
    [LeftImageView setUserInteractionEnabled:YES];
    [MainView addSubview:LeftImageView];
    
    
    //  END OF  LEFT BACK LABEL
    
    
    
    //START OF Right BACK LABEL
    
    RightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth-249/2, CurrDollarIntLbl.frame.origin.y+CurrDollarIntLbl.frame.size.height+1, 249/2, 90/2)];
    [RightImageView setImage:[UIImage imageNamed:@"LeftHourDayImage"]];
    [RightImageView setUserInteractionEnabled:YES];
    [MainView addSubview:RightImageView];
    
    
    //  END OF  Right BACK LABEL
    
    NSArray *HousDayTitle=[[NSArray alloc]initWithObjects:@"4",@"2", nil];
   
   
    PreFrame=CGRectMake(0, 0, 0, 0);
    for (int i=0; i<[HousDayTitle count]; i++) {
         UILabel *HourDayLbl=[[UILabel alloc]initWithFrame:CGRectMake(3, 0,RightImageView.frame.size.width-6,RightImageView.frame.size.height)];
        HourDayLbl.tag=i;
        if (i<1) {
            
            [LeftImageView addSubview:HourDayLbl];
            [HourDayLbl setText:[NSString stringWithFormat:@"%@ hours/day",_CurrUsageStrByDay]];
        }
        else
        {
            [RightImageView addSubview:HourDayLbl];
            [HourDayLbl setText:[NSString stringWithFormat:@"%@ hours/day",_NewUsageStrByDay]];
        }
        
        
        UITapGestureRecognizer *Tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnHourDay:)];
        [HourDayLbl addGestureRecognizer:Tap];
        Tap.numberOfTapsRequired=1;
        Tap.delegate=self;
        
        
        
        
        
        [HourDayLbl setFont:[UIFont fontWithName:@"Arial" size:17]];
        [HourDayLbl setTextColor: [UIColor whiteColor]];
        [HourDayLbl setTextAlignment:NSTextAlignmentCenter];
        
        
        
        [HourDayLbl setUserInteractionEnabled:YES];
       
        
        PreFrame=HourDayLbl.frame;
        PreFrame.origin.y=HourDayLbl.frame.origin.y+HourDayLbl.frame.size.height;
        if (i==3) {
            PreFrame.origin.y=0;
        }
        
    }
    
   
    
    /////  start of the middle image
    [self middleimagescroll];
    
    
    
    
    /////   end of the middle image
    
    //footerview.........========..........=====.....//
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    
    footerbudgtbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerbudgtbtn setFrame:CGRectMake(20.0f, 5.0f, 31.5f, 35.0f)];
    [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerbudght"] forState:UIControlStateNormal];
    [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerbudght"] forState:UIControlStateHighlighted];
    [footerbudgtbtn addTarget:self action:@selector(footerBudgetFunction:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerbudgtbtn];
    
    
    footerauditbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerauditbtn setFrame:CGRectMake(85.0f, 5.0f, 23.0f, 33.0f)];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedauditbudht"] forState:UIControlStateNormal];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedauditbudht"] forState:UIControlStateHighlighted];
    [footerauditbtn addTarget:self action:@selector(footerAuditFunction:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerauditbtn];
    
    
    FooterRemoveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [FooterRemoveBtn setFrame:CGRectMake(146.0f, 3.0f, 71.0f/2, 72/2.0f)];
    [FooterRemoveBtn setBackgroundImage:[UIImage imageNamed:@"FooterRemoveImage"] forState:UIControlStateNormal];
    [FooterRemoveBtn setBackgroundImage:[UIImage imageNamed:@"FooterRemoveImage"] forState:UIControlStateHighlighted];
    [FooterRemoveBtn addTarget:self action:@selector(footerRemoveFunction:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:FooterRemoveBtn];
    
    
    
    footercontinuebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [footercontinuebtn setFrame:CGRectMake(213.0f, 3.0f, 30.0f, 70/2.0f)];
    [footercontinuebtn setBackgroundImage:[UIImage imageNamed:@"FooterDeviceImage"] forState:UIControlStateNormal];
    [footercontinuebtn setBackgroundImage:[UIImage imageNamed:@"FooterDeviceImage"] forState:UIControlStateHighlighted];
    [footercontinuebtn addTarget:self action:@selector(footerDeviceFunction:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footercontinuebtn];
    
    
    
    
    
    footerBackbtn = [UIButton buttonWithType:UIButtonTypeCustom];
   
    [footerBackbtn setFrame:CGRectMake(274.0f, 3.0f,54/2 , 35.0f)];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateNormal];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateHighlighted];
    [footerBackbtn addTarget:self action:@selector(footerBackFunction:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerBackbtn];

    
    
    // Do any additional setup after loading the view.



    
    

    
    
    
    
    
    
    // Do any additional setup after loading the view.
}

-(void)tapToRemove:(UIGestureRecognizer *)Gesture
{
   
    for (UIView *SubViews in ContacinerScroll.subviews) {
        if ([SubViews isKindOfClass:NSClassFromString(@"UIView")] &&![SubViews isKindOfClass:NSClassFromString(@"UILabel")] &&![SubViews isKindOfClass:NSClassFromString(@"UIImageView")]) {
            UIView *Get_View=(UIView *)SubViews;
            Get_View.backgroundColor=[UIColor clearColor];
            if (Get_View.tag==Gesture.view.tag) {
                SelectedDeviceToRemoveTag=Gesture.view.tag;
                SelectedToRemove=YES;
                Get_View.backgroundColor=RGBCOLOR(150, 177, 200, 1);
                
                
            }
        }
    }
    
    
   
}

-(void)middleimagescroll
{
    MMAppDelegate *AppObj=[[UIApplication sharedApplication]delegate];
    for (NSDictionary *Dict in AppObj.ImageThumUrlArray) {
        
    }
    PreFrame=CGRectMake(0, 0, 0, 0);
    ContacinerScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, RightImageView.frame.size.height+RightImageView.frame.origin.y+10,MainScreenWidth, 140)];
    ContacinerScroll.backgroundColor=[UIColor clearColor];
    [MainView addSubview:ContacinerScroll];
    int count=0;
    
    NSLog(@"imagearray..... :%@",AppObj.ImageThumUrlArray);
    
    for (NSDictionary *Dict in AppObj.ImageThumUrlArray) {
        UIView *ContainerView=[[UIView alloc]initWithFrame:CGRectMake(PreFrame.origin.x, 0, 100, ContacinerScroll.frame.size.height)];
        [ContacinerScroll addSubview:ContainerView];
        ContainerView.layer.cornerRadius=4.0;
        ContainerView.clipsToBounds=YES;
        ContainerView.backgroundColor=[UIColor clearColor];
        ContainerView.tag=count;
        [ContainerView setUserInteractionEnabled:YES];
        UITapGestureRecognizer *Tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToRemove:)];
        Tap.delegate=self;
        Tap.numberOfTapsRequired=1;
        [ContainerView addGestureRecognizer:Tap];
        
        
        
        UIImageView *ProductImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,30, 80, 80)];
        [ContainerView addSubview:ProductImageView];
        //[ProductImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_SelectedImageUrl]]]];
        //[ProductImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[Dict objectForKey:@"device_image_thumb"]]]]];
        [ProductImageView sd_setImageWithURL:[NSURL URLWithString:[Dict objectForKey:@"device_image_thumb"]] placeholderImage:[UIImage imageNamed:@"NoImage.png"] options:count==0?SDWebImageRefreshCached:0];
        UILabel *TitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(ProductImageView.frame.origin.x-10, ProductImageView.frame.origin.y+ProductImageView.frame.size.height+2, ProductImageView.frame.size.width+20, 20)];
        TitleLbl.textColor =[UIColor whiteColor];
        TitleLbl.textAlignment=NSTextAlignmentCenter;
        TitleLbl.adjustsFontSizeToFitWidth=YES;
        TitleLbl.font=[UIFont systemFontOfSize:15];
        [ContainerView addSubview:TitleLbl];
        [TitleLbl setText:[Dict objectForKey:@"title"]];
        
        UILabel *WattLbl=[[UILabel alloc]initWithFrame:CGRectMake(ProductImageView.frame.origin.x-10, ProductImageView.frame.origin.y-30, ProductImageView.frame.size.width+20, 20)];
        WattLbl.textColor =[UIColor whiteColor];
        
        WattLbl.textAlignment=NSTextAlignmentCenter;
        WattLbl.adjustsFontSizeToFitWidth=YES;
        TitleLbl.font=[UIFont systemFontOfSize:17];
        [ContainerView addSubview:WattLbl];
        [WattLbl setText:[NSString stringWithFormat:@
                          "%@",[Dict objectForKey:@"wattage"]]];
        
        
        
        
        
        
        
        PreFrame.origin.x=ContainerView.frame.size.width+ContainerView.frame.origin.x+3;
        count++;
    }
    
    [ContacinerScroll setContentSize:CGSizeMake([AppObj.ImageThumUrlArray count]*100+100, ContacinerScroll.frame.size.height)];

}
-(void)tapOnHourDay:(UIGestureRecognizer *)Gesture
{
    
}
-(void)footerBudgetFunction:(UIButton *)sender
{
    MMUsageBudgetViewController *UsageBudgetObj=[[MMUsageBudgetViewController alloc]init];
    [[self navigationController]pushViewController:UsageBudgetObj animated:NO];
    
    
}
-(void)footerAuditFunction:(UIButton *)sender
{
   
    
}
-(void)footerRemoveFunction:(UIButton *)sender
{
    MMAppDelegate *AppObj=[[UIApplication sharedApplication]delegate];
    
    
    if (SelectedToRemove) {
        
        
        for (UIView *SubViews in ContacinerScroll.subviews) {
            if ([SubViews isKindOfClass:NSClassFromString(@"UIView")] &&![SubViews isKindOfClass:NSClassFromString(@"UILabel")] &&![SubViews isKindOfClass:NSClassFromString(@"UIImageView")]) {
                UIView *Get_View=(UIView *)SubViews;
               
                if (Get_View.tag==SelectedDeviceToRemoveTag) {
                    
                    SelectedToRemove=NO;
                  
                    [Get_View removeFromSuperview];
                    dispatch_queue_t Queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
                    dispatch_async(Queue, ^{
                       
                     NSString *Str=[[MMGlobalUrlClass GetInstance] GlobalUrlFireToGetResponseString:[NSString stringWithFormat:@"remove_device.php?id=%d",[[[AppObj.ImageThumUrlArray objectAtIndex:(int)Get_View.tag] objectForKey:@"id"] intValue]]];
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if ([Str  isEqualToString:@"success"]) {
                                
                                UIAlertView *alert=[[UIAlertView alloc
                                                     ]initWithTitle:@"Alert" message:@"device successfuly removed " delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                [alert show];
                                alert.delegate=self;

                                [ContacinerScroll setContentSize:CGSizeMake(ContacinerScroll.contentSize.width-100, ContacinerScroll.frame.size.height)];
                            } else {
                                UIAlertView *alert=[[UIAlertView alloc
                                                     ]initWithTitle:@"Error" message:@"device not removed" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                                [alert show];
                                alert.delegate=self;

                            }
                            
                            
                        });
                    });

                   
                    
                   
                }
                
                
                if (!SelectedToRemove) {
                    [Get_View setFrame:CGRectMake(Get_View.frame.origin.x-100, Get_View.frame.origin.y, Get_View.frame.size.width, Get_View.frame.size.height)];
                }
            }
        }

        
        
    }
    
    else
    
    {
        UIAlertView *alert=[[UIAlertView alloc
                             ]initWithTitle:@"Alert" message:@"Please select device to remove" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        alert.delegate=self;
    }
    
    
   
}
-(void)footerBackFunction:(UIButton *)sender
{
    
    
   
    [[self navigationController]popViewControllerAnimated:NO];
   
    
}
-(void)footerDeviceFunction:(UIButton *)sender
{
    
    
    
    DeviceAdditionPopUpView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,MainScreenWidth, MainScreenHeight)];
    
    DeviceAdditionPopUpView.backgroundColor=RGBCOLOR(0, 0, 0, .56);
    [self.view addSubview:DeviceAdditionPopUpView];
    DevicePopUpBackView=[[UIView alloc]initWithFrame:CGRectMake(30, 190, 260, 250)];
    [DeviceAdditionPopUpView addSubview:DevicePopUpBackView];
    DevicePopUpBackView.backgroundColor=RGBCOLOR(117, 157, 185,1);
    DevicePopUpBackView.layer.cornerRadius=2.0;
    DevicePopUpBackView.layer.borderWidth=1.5;
    DevicePopUpBackView.layer.borderColor=RGBCOLOR(156, 185, 207, 1).CGColor;
    
    DeviceTitleField=[[UITextField alloc]initWithFrame:CGRectMake(DevicePopUpBackView.frame.size.width/2-200/2, 10, 200, 30)];
    
    DeviceTitleField.delegate=self;

    DeviceTitleField.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Enter Device Name" attributes:@{NSForegroundColorAttributeName: RGBCOLOR(108, 108, 108, 1)}];
    DeviceTitleField.textAlignment=NSTextAlignmentCenter;
    DeviceTitleField.font=[UIFont systemFontOfSize:14];
    [DevicePopUpBackView addSubview:DeviceTitleField];
    //[DeviceTitle setBackgroundColor:RGBCOLOR(242, 242, 242, 1)];
    
    
    DeviceWattage=[[UITextField alloc]initWithFrame:CGRectMake(DevicePopUpBackView.frame.size.width/2-200/2, DeviceTitleField.frame.size.height+DeviceTitleField.frame.origin.y+5, 200, 30)];
    DeviceWattage.delegate=self;
    DeviceWattage.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Enter Device Wattage" attributes:@{NSForegroundColorAttributeName: RGBCOLOR(108, 108, 108, 1)}];
    DeviceWattage.font=[UIFont systemFontOfSize:14];
    [DevicePopUpBackView addSubview:DeviceWattage];
    DeviceWattage.backgroundColor=[UIColor clearColor];
    DeviceWattage.textAlignment=NSTextAlignmentCenter;
    
   DeviceImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, DeviceWattage.frame.size.height+DeviceWattage.frame.origin.y+15, 80, 80)];
    
    [DevicePopUpBackView  addSubview:DeviceImageView];
    DeviceImageView.backgroundColor=[UIColor clearColor];
 
    UIButton *CameraBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [CameraBtn setFrame:CGRectMake(DeviceImageView.frame.origin.x+20+DeviceImageView.frame.size.width,DeviceWattage.frame.origin.y+DeviceWattage.frame.size.height+15, 140, 40)];
    [CameraBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateNormal];
    [CameraBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateSelected];
    [CameraBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateHighlighted];
    [CameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [CameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [CameraBtn setTitle:@"Choose from camera" forState:UIControlStateHighlighted];
    [CameraBtn setTitle:@"Choose from camera" forState:UIControlStateSelected];
    [CameraBtn setTitle:@"Choose from camera" forState:UIControlStateNormal];
    CameraBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [DevicePopUpBackView addSubview:CameraBtn];
    [CameraBtn addTarget:self action:@selector(CameraOpen) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *LibraryBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [LibraryBtn setFrame:CGRectMake(CameraBtn.frame.origin.x,CameraBtn.frame.origin.y+CameraBtn.frame.size.height+5, 140, 40)];
    [LibraryBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateNormal];
    [LibraryBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateSelected];
    [LibraryBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateHighlighted];
    [LibraryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LibraryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [LibraryBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [LibraryBtn setTitle:@"Choose from gallery" forState:UIControlStateHighlighted];
    [LibraryBtn setTitle:@"Choose from gallery" forState:UIControlStateSelected];
    [LibraryBtn setTitle:@"Choose from gallery" forState:UIControlStateNormal];
    LibraryBtn.titleLabel.font=[UIFont systemFontOfSize:14];
    [DevicePopUpBackView addSubview:LibraryBtn];
    [LibraryBtn addTarget:self action:@selector(LibraryOptionChoosed) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    
    
   
    //[DeviceBtn addTarget:self action:@selector(CretingPopUpForEditUserImage) forControlEvents:UIControlEventTouchUpInside];

    UIButton *CancelBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    
    [CancelBtn setFrame:CGRectMake(DeviceImageView.frame.origin.x,DeviceImageView.frame.origin.y+DeviceImageView.frame.size.height+20, 110, 40)];
    [CancelBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateNormal];
    [CancelBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateSelected];
    [CancelBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateHighlighted];
    [CancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [CancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [CancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [CancelBtn setTitle:@"Cancel" forState:UIControlStateHighlighted];
    [CancelBtn setTitle:@"Cancel" forState:UIControlStateSelected];
    [CancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    
    [DevicePopUpBackView addSubview:CancelBtn];
    [CancelBtn addTarget:self action:@selector(Cancel) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *DeviceAddBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [DeviceAddBtn setFrame:CGRectMake(CancelBtn.frame.origin.x+20+CancelBtn.frame.size.width,DeviceImageView.frame.origin.y+DeviceImageView.frame.size.height+20, 110, 40)];
    [DeviceAddBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateNormal];
    [DeviceAddBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateSelected];
    [DeviceAddBtn setBackgroundImage:[[MMGlobalFunctionClass GetInstance] imageFromColor:RGBCOLOR(156, 185, 207, 1)] forState:UIControlStateHighlighted];
    [DeviceAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [DeviceAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [DeviceAddBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [DeviceAddBtn setTitle:@"Done" forState:UIControlStateHighlighted];
    [DeviceAddBtn setTitle:@"Done" forState:UIControlStateSelected];
    [DeviceAddBtn setTitle:@"Done" forState:UIControlStateNormal];
   
    [DevicePopUpBackView addSubview:DeviceAddBtn];
   
    [DeviceAddBtn addTarget:self action:@selector(saveImageToServer) forControlEvents:UIControlEventTouchUpInside];
    
   
    
}
-(void)Cancel
{
    [DeviceAdditionPopUpView removeFromSuperview];
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







- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    IsImageChoosed=YES;
    
    [self dismissViewControllerAnimated:NO completion:^{

        ChoosedImage=chosenImage;
        [DeviceImageView setImage:ChoosedImage];

        
        //[self saveImageToServer];
    }];
    
}

-(void)LibraryOptionChoosed
{

    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
        
        [[UIApplication sharedApplication]setStatusBarHidden:YES];

        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id)self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        [self presentViewController:picker animated:YES completion:nil];
        
        
        
    }
    else
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Do  not have access!"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
    }
    
    
    
    
}
-(void)CameraOpen
{
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [[UIApplication sharedApplication]setStatusBarHidden:YES];

        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = (id)self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
  
    }
    else
    {
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
}
-(void)saveImageToServer
{
    
    NSString *testString = [NSString string];
    NSScanner *scanner = [NSScanner scannerWithString:[NSString stringWithFormat:@"%@",DeviceWattage.text]];
    NSCharacterSet *skips = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
    [scanner scanCharactersFromSet:skips intoString:&testString];
    
    
    if ([DeviceTitleField.text length]==0) {
        UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Choose device title" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        Alert.delegate=self;
        return;
    }
   else if ([DeviceWattage.text length]==0) {
        UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Select Wattage" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        Alert.delegate=self;
        return;
    }
    else if ([[NSString stringWithFormat:@"%@",DeviceWattage.text] length] != [testString length]) {
        UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Please enter numeric value" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        Alert.delegate=self;
        return;
    }
    
   else if(!IsImageChoosed){
        UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Choose device image" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [Alert show];
        Alert.delegate=self;
        return;
    }
   else{
       
       spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
       spinner.center = CGPointMake(130, 215);
       spinner.hidesWhenStopped = YES;
       [DevicePopUpBackView addSubview:spinner];
       [spinner startAnimating];
       
       CGSize size = ChoosedImage.size;
       CGFloat ratio = 0;
       if (size.width > size.height) {
           ratio = 100.0 / size.width;
       }
       else {
           ratio = 100.0 / size.height;
       }
       CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
       
       UIGraphicsBeginImageContext(rect.size);
       [ChoosedImage drawInRect:rect];
       UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
       UIGraphicsEndImageContext();
       
    reportQueue = [[NSOperationQueue alloc]init];
    
    [reportQueue addOperationWithBlock:^{
        
    
    NSString *ReportPoleStr = [[NSString alloc]init];
    
    ReportPoleStr = [NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myPower/add_device.php?user_id=%@&title=%@&wattage=%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],DeviceTitleField.text,DeviceWattage.text];
    

    NSString* urlTextEscaped = [ReportPoleStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:urlTextEscaped]];
    [request setTimeoutInterval:10];
    [request setHTTPMethod:@"POST"];

    NSData *imageData=[NSData dataWithData:UIImageJPEGRepresentation(thumbnail, 1)];
    
    if ( [imageData length] > 0)
        //   if (pic_send ==1)
    {
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"deviceimage\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
    }
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *returnData1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error)
    {
        return ;
    }

        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
                 NSString *responseString = [[NSString alloc] initWithData:returnData1 encoding:NSUTF8StringEncoding];
                 
                 if ([responseString isEqualToString:@"success"])
                 {
                     UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Message" message:@"Device successfully added" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                     [Alert show];
                     Alert.delegate=self;
                     
                     
                     [self loadimage];
                 }
                 else {
                     UIAlertView *Alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Device has not been added" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                     [Alert show];
                     Alert.delegate=self;
                 }

            
            [spinner stopAnimating];
        }];
        
    }];
   }
}
-(void)bill:(UIButton *)sender
{
    
    MMusagebillViewController *bill = [[MMusagebillViewController alloc]init];
    [self.navigationController pushViewController:bill animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)usage:(UIButton *)sender
{
    MMUsageTreeViewController *view = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
}

-(void)loadimage
{
    [DeviceAdditionPopUpView removeFromSuperview];
    


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
