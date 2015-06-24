//
//  MMUsageBudgetThermoViewController.m
//  OpenCVSample
//
//  Created by Prosenjit Kolay on 19/06/15.
//
//

#import "MMUsageBudgetThermoViewController.h"
#import "MMSideview.h"
#import "MMusagebillViewController.h"
#import "MMDaysAndPrice.h"

@interface MMUsageBudgetThermoViewController (){
    
    MMSideview *leftMenu;
    MMDaysAndPrice *dAP;
    UIView *MainView;
    UIButton *Menubtn;
    UILabel *HeaderLbl;
    UIButton *budgetbtn;
    UIButton *billbtn;
    UIButton *usagebtn;
    UILabel *DollarLbl;
    UILabel *DollarIntLbl;
    UILabel *DollarFractionLbl;
    UILabel *DynamicMonthLbl;
    UIButton *footerprofilebtn, *footerauditbtn, *footerBackbtn, *footermorebtn;
    UIImageView *thermometer;
    UIButton *upBtn, *downBtn;
    UILabel *tempLabel;
    int count;
    BOOL menuOpened;
    
}
@end

@implementation MMUsageBudgetThermoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    NSLog(@"MMUsageBudgetThermoViewViewController");
    
    self.str =0;
    self.rts = 0;
    count = 1;
    
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
    [billbtn setFrame:CGRectMake(148, 82.0f, 70/2, 84/2)];
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
    
    
    //START DOLLAR LABEL
    
    
    
    DollarLbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 125.0f, 15.0f, 60.0f)];
    DollarLbl.backgroundColor=[UIColor redColor];
    [DollarLbl setText:@"$"];
    [DollarLbl setTextAlignment:NSTextAlignmentLeft];
    [DollarLbl setTextColor:[UIColor whiteColor]];//RGBCOLOR(182,206, 224, 1)];
    DollarLbl.numberOfLines = 1;
    [DollarLbl setBackgroundColor:[UIColor clearColor]];
    [DollarLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:26]];
    [MainView addSubview:DollarLbl];
    
    // END OF DOLLAR LABEL
    
    //  START OF DOLLAR VALUE LABEL
    CGRect frame72 =CGRectMake(0, 0, 0, 0);
    _DollarIntLblStr=@"111";
//    _DollarFractionLblStr=@"93";
    DollarIntLbl=[[UILabel alloc]init];
    [DollarIntLbl setText:[NSString stringWithFormat:@"%@.",_DollarIntLblStr]];
    DollarIntLbl.textAlignment=NSTextAlignmentLeft;
    //DollarIntLbl.textColor=RGBCOLOR(162, 190, 211, 1);
    DollarIntLbl.textColor=[UIColor whiteColor];//RGBCOLOR(182,206, 224, 1);
    DollarIntLbl.font=[UIFont fontWithName:@"Arial" size:54];
    
    NSDictionary *attributesDicCompTag = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIFont fontWithName:@"Arial" size:54], NSFontAttributeName,
                                          nil];
    
    frame72 = [DollarIntLbl.text boundingRectWithSize:CGSizeMake(263, 2000.0)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:attributesDicCompTag
                                              context:nil];
    
    DollarIntLbl.backgroundColor=[UIColor clearColor];
    
    [DollarIntLbl setFrame:CGRectMake(DollarLbl.frame.size.width+DollarLbl.frame.origin.x+10,DollarLbl.frame.origin.y+10,frame72.size.width,frame72.size.height)];
    
    [MainView addSubview:DollarIntLbl];
    
    
    _DollarFractionLblStr=@"93";
    DollarFractionLbl=[[UILabel alloc]init];
    [DollarFractionLbl setText:[NSString stringWithFormat:@"%@",_DollarFractionLblStr]];
    
    DollarFractionLbl.textAlignment=NSTextAlignmentLeft;
    DollarFractionLbl.textColor=[UIColor whiteColor];//RGBCOLOR(182,206, 224, 1);
    
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
    
    
    //START OF THE DYNAMIC MONTH LABEL
    
    DynamicMonthLbl = [[UILabel alloc]initWithFrame:CGRectMake(210.0f, 137.0f, 100.0f, 60.0f)];
    [DynamicMonthLbl setText:@"A u g u s t Estimate"];
    [DynamicMonthLbl setTextAlignment:NSTextAlignmentLeft];
    [DynamicMonthLbl setTextColor:[UIColor whiteColor]];//RGBCOLOR(182,206, 224, 1)];
    DynamicMonthLbl.numberOfLines = 2;
    [DynamicMonthLbl setBackgroundColor:[UIColor clearColor]];
    [DynamicMonthLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
    
    [MainView addSubview:DynamicMonthLbl];
    
    ////end of dynamic month label
    
    /////-------------PK
    
//    daysTable = [[UITableView alloc]initWithFrame:CGRectMake(3.0f, DollarIntLbl.frame.origin.y+DollarIntLbl.frame.size.height+40.0f, 135.0f, 245.0f)];
//    daysTable.backgroundColor = [UIColor clearColor];
//    daysTable.delegate = self;
//    daysTable.dataSource = self;
//    daysTable.separatorStyle = UITableViewCellSeparatorStyleNone;
//    daysTable.userInteractionEnabled = NO;
//    [MainView addSubview:daysTable];
    
    //////////------------PK
    
    dAP = [[MMDaysAndPrice alloc]init];
    [MainView addSubview:dAP];
    
    //-------Current date-------//
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM"];
    NSString *myMonthString = [[NSString alloc]init];
    myMonthString = [df stringFromDate:[NSDate date]];
    
    NSLog(@"MONTH------> %@",myMonthString);
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    
    NSInteger day = [components day];
//    NSInteger week = [components month];
//    NSInteger year = [components year];
    
    
    UILabel *dayLabel = [[UILabel alloc]init];
    dayLabel.frame = CGRectMake(28.0f, [UIScreen mainScreen].bounds.size.height-90.0f, 100.0f, 20.0f);
    dayLabel.backgroundColor = [UIColor clearColor];
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.font = [UIFont systemFontOfSize:12.0f];
    dayLabel.text = [NSString stringWithFormat:@"%@  %ld-%ld",myMonthString,day-6,day];//,[days objectAtIndex:indexPath.row]];
    [MainView addSubview:dayLabel];
    
    //-------------Thermo Image------------//
    
    thermometer = [[UIImageView alloc]initWithFrame:CGRectMake(dAP.frame.origin.x+dAP.frame.size.width+160.0f, DollarIntLbl.frame.origin.y+DollarIntLbl.frame.size.height+85.0f, 34.0f, 165.0f)];
    thermometer.backgroundColor = [UIColor clearColor];
    thermometer.image = [UIImage imageNamed:@"thermometer72"];
    [MainView addSubview:thermometer];
    
    //------------Up Button-----------//
    
    upBtn = [[UIButton alloc]initWithFrame:CGRectMake(thermometer.frame.origin.x+thermometer.frame.size.width+10.0f, thermometer.frame.origin.y,90.0f, 50.0f)];
    [upBtn setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateNormal];
    [upBtn setImage:[UIImage imageNamed:@"upArrow"] forState:UIControlStateSelected];
    upBtn.backgroundColor = [UIColor clearColor];
    [upBtn addTarget:self action:@selector(upButton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:upBtn];
    
    //------------Temp Label----------//
    
    tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(upBtn.frame.origin.x, upBtn.frame.origin.y+upBtn.frame.size.height+5.0f, 100.0f, 50.0f)];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.text = @"72°";
    tempLabel.textColor = [UIColor whiteColor];
    [tempLabel setTextAlignment:NSTextAlignmentCenter];
    tempLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:60.0f];
    [MainView addSubview:tempLabel];
    
    //------------Down Button-----------//
    
    downBtn = [[UIButton alloc]initWithFrame:CGRectMake(upBtn.frame.origin.x, tempLabel.frame.origin.y+tempLabel.frame.size.height+5.0f, 90.0f, 50.0f)];
    [downBtn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateNormal];
    [downBtn setImage:[UIImage imageNamed:@"downArrow"] forState:UIControlStateSelected];
    downBtn.backgroundColor = [UIColor clearColor];
    downBtn.userInteractionEnabled=NO;
    [downBtn addTarget:self action:@selector(downButton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:downBtn];
    
    //footerview.........========..........=====.....//
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    footerBackbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerBackbtn setFrame:CGRectMake(20.0f, 4.0f, 31.5f, 35.0f)];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateNormal];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateHighlighted];
    [footerBackbtn addTarget:self action:@selector(footerBack:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerBackbtn];
    
    footerauditbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerauditbtn setFrame:CGRectMake(105.0f, 5.0f, 23.0f, 33.0f)];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedauditbudht"] forState:UIControlStateNormal];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedauditbudht"] forState:UIControlStateHighlighted];
    //[footerauditbtn addTarget:self action:@selector(footeraudit:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerauditbtn];
    
    footerprofilebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerprofilebtn setFrame:CGRectMake(190.0f, -5.0f, 54.0f, 54.0f)];
    [footerprofilebtn setBackgroundImage:[UIImage imageNamed:@"profile"] forState:UIControlStateNormal];
    [footerprofilebtn setBackgroundImage:[UIImage imageNamed:@"profile"] forState:UIControlStateHighlighted];
//    [footerprofilebtn addTarget:self action:@selector(footerprofile:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerprofilebtn];
    
    footermorebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footermorebtn setFrame:CGRectMake(265.0f, -5.0f, 54.0f, 54.0f)];
    footermorebtn.backgroundColor = [UIColor clearColor];
    [footermorebtn setBackgroundImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    [footermorebtn setBackgroundImage:[UIImage imageNamed:@"more"] forState:UIControlStateHighlighted];
//    [footermorebtn addTarget:self action:@selector(footermore:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footermorebtn];

    
    
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
-(void)bill:(UIButton *)sender{
    
    MMusagebillViewController *model = [[MMusagebillViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
}
-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *view = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
}
-(void)footerBack:(UIButton *)sender
{
    [[self navigationController] popViewControllerAnimated:NO];
    
}
- (void)upButton:(UIButton *)sender{
    
    self.rts = 0;
    self.str ++;
    
    if (sunpricedec != 0)
    {
        dAP.sunPrice = sunpricedec;
    }
    
    
    dAP.sunP.text = [NSString stringWithFormat:@"%d",dAP.sunPrice+self.str];
    dAP.monP.text = [NSString stringWithFormat:@"%d",dAP.monPrice+self.str];
    dAP.tueP.text = [NSString stringWithFormat:@"%d",dAP.tuePrice+self.str];
    dAP.wedP.text = [NSString stringWithFormat:@"%d",dAP.wedPrice+self.str];
    dAP.thuP.text = [NSString stringWithFormat:@"%d",dAP.thuPrice+self.str];
    dAP.friP.text = [NSString stringWithFormat:@"%d",dAP.friPrice+self.str];
    dAP.satP.text = [NSString stringWithFormat:@"%d",dAP.satPrice+self.str];
    
    sunpricesave = [dAP.sunP.text intValue];
    monpricesave = [dAP.monP.text intValue];
    tuepricesave = [dAP.tueP.text intValue];
    wedpricesave = [dAP.wedP.text intValue];
    thupricesave = [dAP.thuP.text intValue];
    fripricesave = [dAP.friP.text intValue];
    satpricesave = [dAP.satP.text intValue];
    
    
    count = count + 1;
    
    NSLog(@"COUNT----------> %i",count);
    
    if (count == 2) {
        
        thermometer.image = [UIImage imageNamed:@"thermometer74"];
        tempLabel.text = @"74°";
        downBtn.userInteractionEnabled = YES;
        
    }else if (count == 3){
        
        thermometer.image = [UIImage imageNamed:@"thermometer76"];
        tempLabel.text = @"76°";
        downBtn.userInteractionEnabled = YES;
        
    }else if (count == 4){
        
        thermometer.image = [UIImage imageNamed:@"thermometer78"];
        tempLabel.text = @"78°";
        
    }else if (count == 5){
        
        thermometer.image = [UIImage imageNamed:@"thermometer80"];
        tempLabel.text = @"80°";
        upBtn.userInteractionEnabled = NO;
        downBtn.userInteractionEnabled = YES;
        
    }else{
        
//        thermometer.image = [UIImage imageNamed:@"thermometer72"];
    }
    
}
- (void)downButton:(UIButton *)sender{
    
    self.str = 0;
     self.rts --;
    
    NSLog(@"SUNPrice-----> %d RTS------> %d",dAP.sunPrice,self.rts);
    
    if (sunpricesave == 0)
    {
        dAP.sunP.text = [NSString stringWithFormat:@"%d",dAP.sunPrice];
        dAP.monP.text = [NSString stringWithFormat:@"%d",dAP.monPrice];
        dAP.tueP.text = [NSString stringWithFormat:@"%d",dAP.tuePrice];
        dAP.wedP.text = [NSString stringWithFormat:@"%d",dAP.wedPrice];
        dAP.thuP.text = [NSString stringWithFormat:@"%d",dAP.thuPrice];
        dAP.friP.text = [NSString stringWithFormat:@"%d",dAP.friPrice];
        dAP.satP.text = [NSString stringWithFormat:@"%d",dAP.satPrice];
    }
    else
    {
        dAP.sunP.text = [NSString stringWithFormat:@"%d",sunpricesave+self.rts];
        dAP.monP.text = [NSString stringWithFormat:@"%d",monpricesave+self.rts];
        dAP.tueP.text = [NSString stringWithFormat:@"%d",tuepricesave+self.rts];
        dAP.wedP.text = [NSString stringWithFormat:@"%d",wedpricesave+self.rts];
        dAP.thuP.text = [NSString stringWithFormat:@"%d",thupricesave+self.rts];
        dAP.friP.text = [NSString stringWithFormat:@"%d",fripricesave+self.rts];
        dAP.satP.text = [NSString stringWithFormat:@"%d",satpricesave+self.rts];
    }
    
    
    sunpricedec = [dAP.sunP.text intValue];
    monpricedec = [dAP.monP.text intValue];
    tuepricedec = [dAP.tueP.text intValue];
    wedpricedec = [dAP.wedP.text intValue];
    thupricedec = [dAP.thuP.text intValue];
    fripricedec = [dAP.friP.text intValue];
    satpricedec = [dAP.satP.text intValue];
    
    
    count = count - 1;
    
    NSLog(@"COUNT----------> %i",count);
    
    if (count == 2) {
        
        thermometer.image = [UIImage imageNamed:@"thermometer74"];
        tempLabel.text = @"74°";
        
    }else if (count == 3){
        
        thermometer.image = [UIImage imageNamed:@"thermometer76"];
        tempLabel.text = @"76°";
        upBtn.userInteractionEnabled = YES;
        
    }else if (count == 4){
        
        thermometer.image = [UIImage imageNamed:@"thermometer78"];
        tempLabel.text = @"78°";
        upBtn.userInteractionEnabled = YES;
        
    }else if (count == 1){
        
        thermometer.image = [UIImage imageNamed:@"thermometer72"];
        tempLabel.text = @"72°";
        downBtn.userInteractionEnabled = NO;
        upBtn.userInteractionEnabled = YES;
    }

    
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
