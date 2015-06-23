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

@interface MMUsageBudgetThermoViewController (){
    
    MMSideview *leftMenu;
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
    
    daysTable = [[UITableView alloc]initWithFrame:CGRectMake(3.0f, DollarIntLbl.frame.origin.y+DollarIntLbl.frame.size.height+40.0f, 135.0f, 245.0f)];
    daysTable.backgroundColor = [UIColor clearColor];
    daysTable.delegate = self;
    daysTable.dataSource = self;
    daysTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    daysTable.userInteractionEnabled = NO;
    [MainView addSubview:daysTable];
    
    UILabel *dayLabel = [[UILabel alloc]init];
    dayLabel.frame = CGRectMake(28.0f, daysTable.frame.origin.y+daysTable.frame.size.height+1.0f, 100.0f, 20.0f);
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.font = [UIFont systemFontOfSize:12.0f];
    dayLabel.text = [NSString stringWithFormat:@"Aug 12-18"];//,[days objectAtIndex:indexPath.row]];
    [MainView addSubview:dayLabel];
    
    //-------------Thermo Image------------//
    
    thermometer = [[UIImageView alloc]initWithFrame:CGRectMake(daysTable.frame.origin.x+daysTable.frame.size.width+20.0f, DollarIntLbl.frame.origin.y+DollarIntLbl.frame.size.height+85.0f, 30.0f, 160.0f)];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 7;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 35;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"CELL FOR row AT INDEX PATH");
    
    NSString *CellIndentifier=@"cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIndentifier];
    
    //    if (cell==nil) {
    
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIndentifier];
    
    cell.backgroundColor = [UIColor clearColor];
    
    NSMutableArray *days = [[NSMutableArray alloc]initWithObjects:@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT", nil];
    NSMutableArray *price = [[NSMutableArray alloc]initWithObjects:@"11",@"10",@"10",@"12",@"11",@"9",@"9", nil];
    
    UILabel *dayLabel = [[UILabel alloc]init];
    dayLabel.frame = CGRectMake(12.0f, 2.0f, 50.0f, 30.0f);
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.font = [UIFont systemFontOfSize:17.0f];
    dayLabel.text = [NSString stringWithFormat:@"%@",[days objectAtIndex:indexPath.row]];
    [cell addSubview:dayLabel];
    
    UILabel *dollar = [[UILabel alloc]initWithFrame:CGRectMake(dayLabel.frame.origin.x+dayLabel.frame.size.width+20.0f, 2.0f, 15.0f, 20.0f)];
    [dollar setText:@"$"];
    [dollar setTextAlignment:NSTextAlignmentLeft];
    [dollar setTextColor:[UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f]];//RGBCOLOR(182,206, 224, 1)];
    dollar.numberOfLines = 1;
    [dollar setBackgroundColor:[UIColor clearColor]];
    [dollar setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
    [cell addSubview:dollar];
    
    UILabel *priceLabel = [[UILabel alloc]init];
    priceLabel.frame = CGRectMake(dollar.frame.origin.x+dollar.frame.size.width+3.0f, 0.0f, 50.0f, 30.0f);
    priceLabel.textColor = [UIColor colorWithRed:(161.0f/255.0f) green:(250.0f/255.0f) blue:(248.0f/255.0f) alpha:1.0f];
    priceLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:27];
    priceLabel.text = [NSString stringWithFormat:@"%@",[price objectAtIndex:indexPath.row]];
    [cell addSubview:priceLabel];
    
    
    if ((indexPath.row % 2) == 0) {   //-----ODD
        
        NSLog(@"ODD CELL-------->");
        
        cell.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.3f];
        
    }else{      //--------EVEN
        
        NSLog(@"EVEN CELL-------->");
        
        cell.backgroundColor = [UIColor clearColor];
    }

    
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
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
    
    count = count + 1;
    
    NSLog(@"COUNT----------> %i",count);
    
    if (count == 2) {
        
        thermometer.image = [UIImage imageNamed:@"thermometer74"];
        
    }else if (count == 3){
        
        thermometer.image = [UIImage imageNamed:@"thermometer76"];
        
    }else if (count == 4){
        
        thermometer.image = [UIImage imageNamed:@"thermometer78"];
        
    }else if (count == 5){
        
        thermometer.image = [UIImage imageNamed:@"thermometer80"];
        
        upBtn.userInteractionEnabled = NO;
        downBtn.userInteractionEnabled = YES;
        
    }else{
        
//        thermometer.image = [UIImage imageNamed:@"thermometer72"];
    }
    
}
- (void)downButton:(UIButton *)sender{
    
    count = count - 1;
    
    NSLog(@"COUNT----------> %i",count);
    
    if (count == 2) {
        
        thermometer.image = [UIImage imageNamed:@"thermometer74"];
        
    }else if (count == 3){
        
        thermometer.image = [UIImage imageNamed:@"thermometer76"];
        
    }else if (count == 4){
        
        thermometer.image = [UIImage imageNamed:@"thermometer78"];
        
    }else if (count == 5){
        
        thermometer.image = [UIImage imageNamed:@"thermometer80"];
        
    }else if (count == 1){
        
        thermometer.image = [UIImage imageNamed:@"thermometer72"];
        
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
