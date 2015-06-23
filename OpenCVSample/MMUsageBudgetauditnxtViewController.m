//
//  MMUsageBudgetauditnxtViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 09/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMUsageBudgetauditnxtViewController.h"
#import "MMusagebillViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMBudgeViewController.h"


@interface MMUsageBudgetauditnxtViewController ()<UIGestureRecognizerDelegate>
{
    UIScrollView *ProductContainerScroll;
    BOOL WattSelected,ProductSelected;
    NSString *WattString;
    int SelectedProductTag;
    UIButton *footerBackbtn;
    UILabel *DollarLbl,*DollarIntLbl,*DollarFractionLbl,*DynamicMonthLbl;
}

@end

@implementation MMUsageBudgetauditnxtViewController

- (void)viewDidLoad

{
    [super viewDidLoad];
    
    NSLog(@"MMUsageBudgetauditnxtViewController");
    
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
    
    
    //phill button ..........
    
//    phillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [phillbtn setFrame:CGRectMake(255, 84.0f, 56/2, 78/2)];
//    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateNormal];
//    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateHighlighted];
//    //[phillbtn addTarget:self action:@selector(phill:) forControlEvents:UIControlEventTouchUpInside];
//    [MainView addSubview:phillbtn];
    
    
    /////////////////////////////////////////////////////////////////////
    
    //START DOLLAR LABEL
    
    
    
    DollarLbl = [[UILabel alloc]initWithFrame:CGRectMake(40.0f, 125.0f, 15.0f, 60.0f)];
    DollarLbl.backgroundColor=[UIColor redColor];
    [DollarLbl setText:@"$"];
    [DollarLbl setTextAlignment:NSTextAlignmentLeft];
    [DollarLbl setTextColor:RGBCOLOR(182,206, 224, 1)];
    DollarLbl.numberOfLines = 1;
    [DollarLbl setBackgroundColor:[UIColor clearColor]];
    [DollarLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25]];
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
    
    [DollarIntLbl setFrame:CGRectMake(DollarLbl.frame.size.width+DollarLbl.frame.origin.x+10,DollarLbl.frame.origin.y+10,frame72.size.width,frame72.size.height)];
    
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
    
    
    //START OF THE DYNAMIC MONTH LABEL
    
    DynamicMonthLbl = [[UILabel alloc]initWithFrame:CGRectMake(210.0f, 137.0f, 100.0f, 60.0f)];
    [DynamicMonthLbl setText:@"A u g u s t Estimate"];
    [DynamicMonthLbl setTextAlignment:NSTextAlignmentLeft];
    [DynamicMonthLbl setTextColor:RGBCOLOR(182,206, 224, 1)];
    DynamicMonthLbl.numberOfLines = 2;
    [DynamicMonthLbl setBackgroundColor:[UIColor clearColor]];
    [DynamicMonthLbl setFont:[UIFont systemFontOfSize:17]];
    
    [MainView addSubview:DynamicMonthLbl];
    
    ////end of dynamic month label
    
    
    
    
    ////////////////////////////////////////////
    
      
    UIImageView *questionmark = [[UIImageView alloc]initWithFrame:CGRectMake(150.0f, 270.0f, 19.0f, 19.0f)];
    [questionmark setImage:[UIImage imageNamed:@"Questionmarkimg"]];
    [MainView addSubview:questionmark];
    
    
    UILabel *wattage = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 290.0f, 100.0f, 40.0f)];
    [wattage setText:@"Wattage"];
    [wattage setTextAlignment:NSTextAlignmentCenter];
    [wattage setTextColor:[UIColor whiteColor]];
    [wattage setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20]];
    [wattage setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:wattage];
    
    
    UIView *scrollview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 330.0f, 320.0f, 60.0f)];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:scrollview];
    
    //scrollview................
    MainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 60.0f)];
    MainScroll.userInteractionEnabled=YES;
    MainScroll.scrollEnabled=YES;
    MainScroll.showsHorizontalScrollIndicator=YES;
    //MainScroll.contentSize=CGSizeMake(1500.0f, 6.0f);
    [scrollview addSubview:MainScroll];
    
    
    watarray = [[NSMutableArray alloc]init];
    //    watarraylbl = [[NSMutableArray alloc]init];
    
    
    z = 5;
    int j = 0;
    
    while (j<25) {
        
        
        j++;
        z = z+5;
        
        
        
        NSString *str = [NSString stringWithFormat:@"%d w",z];
        //NSString *str1 = [NSString stringWithFormat:@"w"];
        
        [watarray addObject:str];
        //[watarraylbl addObject:str1];
    }
    
    btnArrayNew = [[NSMutableArray alloc]init];
    
    
    
    //    int i = 0;
    //
    //    for (int y = 0 ; y <[watarray count]; y++) {
    //
    //        watvaluebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //        [watvaluebtn setFrame:CGRectMake(i, 0.0f, 81.0f, 51.0f)];
    //        [watvaluebtn setTitle:[NSString stringWithFormat:@"%@",[watarray objectAtIndex:y]] forState:UIControlStateNormal];
    //        [watvaluebtn setTitle:[NSString stringWithFormat:@"%@",[watarray objectAtIndex:y]] forState:UIControlStateHighlighted];
    //        [watvaluebtn setTitle:[NSString stringWithFormat:@"%@",[watarray objectAtIndex:y]] forState:UIControlStateSelected];
    //        [watvaluebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //        [watvaluebtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //        [watvaluebtn setBackgroundImage:[UIImage imageNamed:@"selectedwatview"] forState:UIControlStateHighlighted];
    //        [watvaluebtn setBackgroundImage:[UIImage imageNamed:@"selectedwatview"] forState:UIControlStateSelected];
    //        watvaluebtn.titleLabel.font = [UIFont fontWithName:@"HelveticaLTStd-Bold 2.otf" size:18];
    //        watvaluebtn.titleLabel.font = [UIFont systemFontOfSize:35];
    //        watvaluebtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    //        watvaluebtn.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    //        watvaluebtn.tag = y;
    //        [watvaluebtn addTarget:self action:@selector(watvalue:) forControlEvents:UIControlEventTouchUpInside];
    //        [MainScroll addSubview:watvaluebtn];
    //
    //
    //
    //
    //        watvaluelbl = [[UILabel alloc]initWithFrame:CGRectMake(i, 20.0f, 78.0f, 20.0f)];
    //        [watvaluelbl setText:[NSString stringWithFormat:@"%@",[watarraylbl objectAtIndex:y]]];
    //        [watvaluelbl setTextColor:[UIColor whiteColor]];
    //        [watvaluelbl setBackgroundColor:[UIColor clearColor]];
    //        [watvaluelbl setFont:[UIFont fontWithName:@"HelveticaLTStd-Bold 2.otf" size:12]];
    //        [watvaluelbl setFont:[UIFont boldSystemFontOfSize:15]];
    //        [watvaluelbl setTextAlignment:NSTextAlignmentRight];
    //        [MainScroll addSubview:watvaluelbl];
    //
    //        i=i+95;
    //
    //        [btnArrayNew addObject:watvaluebtn];
    //    }
    //    MainScroll.contentSize=CGSizeMake(i,2);
    
    CGFloat margin = 7.0f;
    CGFloat width = (self.view.bounds.size.width - (margin * 2.0f));
    CGFloat pickerHeight = 50.0f;
    CGFloat x = margin;
    CGFloat y = 325.0f;
    CGRect tmpFrame = CGRectMake(x, y, width, pickerHeight);
    
    _pickerView = [[V8HorizontalPickerView alloc] initWithFrame:tmpFrame];
    _pickerView.backgroundColor   = [UIColor clearColor];
    _pickerView.selectedTextColor = [UIColor whiteColor];
    _pickerView.textColor   = [UIColor grayColor];
    _pickerView.delegate    = self;
    _pickerView.dataSource  = self;
    _pickerView.tag = 1;
    _pickerView.elementFont = [UIFont boldSystemFontOfSize:14.0f];
    _pickerView.selectionPoint = CGPointMake(160, 0);
    
    
    
    UIImageView *indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"selectedwatview"]];
    _pickerView.selectionIndicatorView = indicator;
    [self.view addSubview:_pickerView];
    
    NSArray *ImageTitleArray=[[NSArray alloc]initWithObjects:_ImageUrlFromPreviuosPage,nil];
    CGRect PreFrame=CGRectMake(MainScreenWidth/2-50, 0, 0, 0);
    ProductContainerScroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, scrollview.frame.size.height+scrollview.frame.origin.y, MainScreenWidth, 120)];
    [ProductContainerScroll setBackgroundColor:[UIColor clearColor]];
    for (int i=0; i<[ImageTitleArray count]; i++) {
        
        UIView *ProductContainerView=[[UIView alloc]initWithFrame:CGRectMake(PreFrame.origin.x, 0, 100, ProductContainerScroll.frame.size.height-20)];
        [ProductContainerScroll addSubview:ProductContainerView];
        ProductContainerView.layer.cornerRadius=4.0;
        ProductContainerView.clipsToBounds=YES;
        ProductContainerView.backgroundColor=[UIColor clearColor];
        
        UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[ImageTitleArray objectAtIndex:i]]]];

        UIImageView *ContainerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,0, 80,80)];
        [ContainerImageView setImage:image];
        ContainerImageView.backgroundColor=[UIColor clearColor];
        //[ContainerImageView setUserInteractionEnabled:YES];
        ContainerImageView.tag=i;
        ProductContainerView.tag=i;
        UITapGestureRecognizer *Tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheProduct:)];
        Tap.numberOfTapsRequired=1;
        Tap.delegate=self;
        [ContainerImageView addGestureRecognizer:Tap];
        
        [ProductContainerView addSubview:ContainerImageView];
        
        UILabel *TitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(ContainerImageView.frame.origin.x-10, ContainerImageView.frame.origin.y+ContainerImageView.frame.size.height+2, ContainerImageView.frame.size.width+20, 20)];
        TitleLbl.textColor =[UIColor whiteColor];
        TitleLbl.textAlignment=NSTextAlignmentCenter;
        TitleLbl.adjustsFontSizeToFitWidth=YES;
        TitleLbl.font=[UIFont systemFontOfSize:15];
        [ProductContainerView addSubview:TitleLbl];
        [TitleLbl setText:_DeviceTitle];
        [ProductContainerView addSubview:TitleLbl];
        
        PreFrame=ProductContainerView.frame;
        
        PreFrame.origin.x=ProductContainerView.frame.size.width+ProductContainerView.frame.origin.x+5;
        
    }
    
    [ProductContainerScroll setContentSize:CGSizeMake(PreFrame.origin.x, ProductContainerScroll.frame.size.height)];
    [MainView addSubview:ProductContainerScroll];
    
    
    
    //footerview.........========..........=====.....//
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    
    footerbudgtbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerbudgtbtn setFrame:CGRectMake(20.0f, 4.0f, 31.5f, 35.0f)];
    [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerbudght"] forState:UIControlStateNormal];
    [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerbudght"] forState:UIControlStateHighlighted];
    [footerbudgtbtn addTarget:self action:@selector(footerbudght:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerbudgtbtn];
    
    
    footerauditbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerauditbtn setFrame:CGRectMake(105.0f, 5.0f, 23.0f, 33.0f)];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedauditbudht"] forState:UIControlStateNormal];
    [footerauditbtn setBackgroundImage:[UIImage imageNamed:@"footerselectedauditbudht"] forState:UIControlStateHighlighted];
    //[footerauditbtn addTarget:self action:@selector(footeraudit:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerauditbtn];
    
    
    footerBackbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerBackbtn setFrame:CGRectMake(190.0f, 3.0f, 54/2.0f, 70/2.0f)];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateNormal];
    [footerBackbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateHighlighted];
    [footerBackbtn addTarget:self action:@selector(footerBack:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footerBackbtn];
    
    
    footercontinuebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footercontinuebtn setFrame:CGRectMake(265.0f, 3.0f, 39.0f, 35.0f)];
    [footercontinuebtn setBackgroundImage:[UIImage imageNamed:@"continueimg"] forState:UIControlStateNormal];
    [footercontinuebtn setBackgroundImage:[UIImage imageNamed:@"continueimg"] forState:UIControlStateHighlighted];
    [footercontinuebtn addTarget:self action:@selector(footerContinue:) forControlEvents:UIControlEventTouchUpInside];
    [UsBackView8 addSubview:footercontinuebtn];
    
    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
    WattSelected=ProductSelected=NO;
    [_pickerView scrollToElement:0 animated:NO];
    
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

-(void)footerbudght:(UIButton *)sender{
    
    MMUsageBudgetViewController *model = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
}
-(void)selectedOne:(NSArray *)buttonarray selectedindex:(int)index{
    
    for(int i=0;i<[buttonarray count];i++){
        
        UIButton *button=(UIButton *)[buttonarray objectAtIndex:i];
        
        if(i==index){
            
            [button setBackgroundImage:[UIImage imageNamed:@"selectedwatview"] forState:UIControlStateNormal];
            
        }
        
        else{
            
            [button setBackgroundImage:nil forState:UIControlStateNormal];
            
        }
    }
}
-(void)deselect
{

    
    for (UIView *SubView in MainScroll.subviews) {
        if ([SubView isKindOfClass:NSClassFromString(@"UIButton")]) {
            UIButton *Get_Btn=(UIButton *)SubView;
            [Get_Btn setBackgroundImage:nil forState:UIControlStateNormal];
        }
    }
    
    
    for (UIView *SubView in ProductContainerScroll.subviews) {
        if ([SubView isKindOfClass:NSClassFromString(@"UIView")]) {
            UIView *Get_View=(UIView *)SubView;
            [Get_View setBackgroundColor:[UIColor clearColor]];
        }
    }
    
}
-(void)watvalue:(UIButton *)sender{
    

    WattSelected=YES;
    WattString=sender.titleLabel.text;
    [self selectedOne:btnArrayNew selectedindex:(int)sender.tag];
    
    
}

-(void)footerContinue:(UIButton *)sender
{

    if (WattSelected) {
        [self deselect];
        MMBudgeViewController *BudgetObj=[[MMBudgeViewController alloc]init];
        [BudgetObj setWattString:WattString];
        [BudgetObj setDeviceTitle:_DeviceTitle];
        [BudgetObj setSelectedImageUrlStrFromPreviousPage:_ImageUrlFromPreviuosPage];
        [BudgetObj setSelectedProductTag:_SelectedDeviceID];
        [[self navigationController] pushViewController:BudgetObj animated:NO];
        
    }
    else
    {
        UIAlertView *AlertView=[[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please select watt" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        AlertView.delegate=self;
        [AlertView show];
        
    }
    
}
-(void)footerBack:(UIButton *)sender
{
    [[self navigationController] popViewControllerAnimated:NO];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
    
}
- (NSInteger)numberOfElementsInHorizontalPickerView:(V8HorizontalPickerView *)picker {
    
    return [watarray count];
    
}

- (NSInteger) horizontalPickerView:(V8HorizontalPickerView *)picker widthForElementAtIndex:(NSInteger)index {
    
    
    
    CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSString *text = [watarray objectAtIndex:index];
    
    CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                       constrainedToSize:constrainedSize
                           lineBreakMode:UILineBreakModeCharacterWrap];
    return textSize.width + 40.0f;
}

- (void)horizontalPickerView:(V8HorizontalPickerView *)picker didSelectElementAtIndex:(NSInteger)index {
    
    WattSelected=YES;
    WattString=[NSString stringWithFormat:@"%@", [watarray objectAtIndex:index]];

    NSLog(@"wat...%@",WattString);
    
}

- (UIView *)horizontalPickerView:(V8HorizontalPickerView *)picker viewForElementAtIndex:(NSInteger)index;
{
    
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
    v.backgroundColor = [UIColor clearColor];
    CGSize constrainedSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    NSString *text = @"am";
    
    CGSize textSize = [text sizeWithFont:[UIFont boldSystemFontOfSize:14.0f]
                       constrainedToSize:constrainedSize
                           lineBreakMode:UILineBreakModeCharacterWrap];
    
    UILabel* l1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width + 40, 24)];
    l1.font = [UIFont systemFontOfSize:20]; // choose desired size
    l1.textColor = [UIColor whiteColor];
    l1.textAlignment = NSTextAlignmentCenter;
    l1.text = [watarray objectAtIndex:index];
    [v addSubview: l1];
    
    //        UILabel* l2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 24, textSize.width + 40, 16)];
    //        l2.font = [UIFont systemFontOfSize:14]; // choose desired size
    //        l2.tag = VIEWTAG_LINE2;
    //        l2.textColor = [UIColor whiteColor];
    //        l2.textAlignment = NSTextAlignmentCenter;
    //        l2.text= [_timeformatarray objectAtIndex:index];
    //        [v addSubview: l2];
    return v;
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
