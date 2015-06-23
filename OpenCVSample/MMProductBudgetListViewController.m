//
//  MMProductBudgetListViewController.m
//  MeterMaid
//
//  Created by Iphone_1 on 10/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMProductBudgetListViewController.h"
#import "MMSideview.h"
#import "MMUsageTreeViewController.h"
@interface MMProductBudgetListViewController ()
{
    UIView *MainView;
    MMSideview *leftMenu;
    UIButton *Menubtn,*budgetbtn,*billbtn,*usagebtn,*phillbtn;
    UILabel *HeaderLbl,*DollarLbl,*DollarIntLbl,*DollarFractionLbl,*DynamicMonthLbl,*BracketLbl,*CurrentDailyUsage,*NewDailyUsage;
    
    UILabel *CurrDollarLbl,*CurrDollarIntLbl,*CurrDollarFractionLbl,*NewDollarLbl,*NewDollarIntLbl,*NewDollarFractionLbl;
    BOOL menuOpened;
    

}

@end

@implementation MMProductBudgetListViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [budgetbtn setFrame:CGRectMake(35.0f, 70.0f, 90/2, 83/2)];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"SelectedBudget"] forState:UIControlStateNormal];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"SelectedBudget"] forState:UIControlStateHighlighted];
    //[budgetbtn addTarget:self action:@selector(budget:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:budgetbtn];
    
    
    //bill button ..........
    
    billbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billbtn setFrame:CGRectMake(150.0f, 72.0f, 50/2, 79/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"SelectedDollar"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"SelectedDollar"] forState:UIControlStateHighlighted];
    // [billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(250,79.0f, 74/2, 65/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    //phill button ..........
    
//    phillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [phillbtn setFrame:CGRectMake(255, 72.0f, 56/2, 78/2)];
//    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateNormal];
//    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateHighlighted];
//    //[phillbtn addTarget:self action:@selector(phill:) forControlEvents:UIControlEventTouchUpInside];
//    [MainView addSubview:phillbtn];
    
    
    
    
    
    //START DOLLAR LABEL
    DollarLbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 125.0f, 15.0f, 60.0f)];
    DollarLbl.backgroundColor=[UIColor redColor];
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
    
    UIImageView *RightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(MainScreenWidth-249/2, CurrDollarIntLbl.frame.origin.y+CurrDollarIntLbl.frame.size.height+1, 249/2, 90/2)];
    [RightImageView setImage:[UIImage imageNamed:@"LeftHourDayImage"]];
    [RightImageView setUserInteractionEnabled:YES];
    [MainView addSubview:RightImageView];
    
    
    //  END OF  Right BACK LABEL
    
    NSArray *HousDayTitle=[[NSArray alloc]initWithObjects:@"4",@"2", nil];
    
    
    CGRect PreFrame=CGRectMake(0, 0, 0, 0);
    for (int i=0; i<[HousDayTitle count]; i++) {
        UILabel *HourDayLbl=[[UILabel alloc]initWithFrame:CGRectMake(3, 0,RightImageView.frame.size.width-6,RightImageView.frame.size.height)];
        HourDayLbl.tag=i;
        if (i<1) {
            
            [LeftImageView addSubview:HourDayLbl];
        }
        else
        {
            [RightImageView addSubview:HourDayLbl];
        }
        
        
        UITapGestureRecognizer *Tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapOnHourDay:)];
        [HourDayLbl addGestureRecognizer:Tap];
        Tap.numberOfTapsRequired=1;
        Tap.delegate=self;
        
        
        
        
        
        [HourDayLbl setFont:[UIFont fontWithName:@"Arial" size:17]];
        [HourDayLbl setTextColor: [UIColor whiteColor]];
        [HourDayLbl setTextAlignment:NSTextAlignmentCenter];
        [HourDayLbl setText:[NSString stringWithFormat:@"%@ hours/day",[HousDayTitle objectAtIndex:i]]];
        
        
        [HourDayLbl setUserInteractionEnabled:YES];
        
        
        PreFrame=HourDayLbl.frame;
        PreFrame.origin.y=HourDayLbl.frame.origin.y+HourDayLbl.frame.size.height;
        if (i==3) {
            PreFrame.origin.y=0;
        }
        
    }
    
    

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *view = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
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
