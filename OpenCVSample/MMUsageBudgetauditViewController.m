//
//  MMUsageBudgetauditViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 08/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMUsageBudgetauditViewController.h"
#import "MMusagebillViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMUsageBudgetauditnxtViewController.h"
#import "MMGlobalUrlClass.h"
#import "UIImageView+WebCache.h"
#import "MMAppDelegate.h"
#import "MMUsageBudgetThermoViewController.h"

@interface MMUsageBudgetauditViewController ()<UIScrollViewDelegate>
{
    UILabel *DollarLbl,*DollarIntLbl,*DollarFractionLbl,*DynamicMonthLbl;
    
    UIView *loader_shadow_View;
    NSMutableArray* ReturnArray;
    BOOL FirstTimeScroll;
    NSMutableArray *staticItemImage, *staticItemName, *staticItemWatt;
}
@end

@implementation MMUsageBudgetauditViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (!FirstTimeScroll) {
        FirstTimeScroll=YES;
        [MainScroll setFrame:CGRectMake(0,MainScroll.frame.origin.y, MainScroll.frame.size.width, MainScroll.frame.size.height)];
    }
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSLog(@"MMUsageBudgetauditViewController");
    
    for (UIViewController *Vc in self.navigationController.viewControllers) {
 
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
    [billbtn setFrame:CGRectMake(budgetbtn.frame.origin.x+budgetbtn.frame.size.width+30.0f,83.0f,70/2,84/2)];//148.0f, 82.0f, 70/2, 84/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"Billselectedbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"Billselectedbtn"] forState:UIControlStateHighlighted];
    [billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(billbtn.frame.origin.x+billbtn.frame.size.width+40.0f,83.0f, 74/2, 65/2)];//251, 83.0f, 74/2, 65/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    //phill button ..........
    
    phillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phillbtn setFrame:CGRectMake(usagebtn.frame.origin.x+usagebtn.frame.size.width+35.0f,83.0f, 56/2, 78/2)];//255, 83.0f, 56/2, 78/2)];
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
    [DollarLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:26]];
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
    [DynamicMonthLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:17]];
    
    [MainView addSubview:DynamicMonthLbl];
    
  ////end of dynamic month label
    
    
    //------------PK
    
    //==========THERMO BUTTON===========//
    
    UILabel *tempLabel = [[UILabel alloc]initWithFrame:CGRectMake(36.0f, DollarLbl.frame.origin.y+DollarLbl.frame.size.height+20.0f, 50.0f, 50.0f)];
    tempLabel.backgroundColor = [UIColor clearColor];
    tempLabel.text = @"72°";
    tempLabel.textColor = [UIColor whiteColor];
    tempLabel.font= [UIFont boldSystemFontOfSize:33.0f];
    [MainView addSubview:tempLabel];
    
    UIButton *thermoButton = [[UIButton alloc]initWithFrame:CGRectMake(36.0f, tempLabel.frame.origin.y+tempLabel.frame.size.height+10.0f, 40.0f, 70.0f)];
//    thermoButton.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"miniThermo"]];
    [thermoButton setImage:[UIImage imageNamed:@"miniThermo"] forState:UIControlStateNormal];
    [thermoButton setImage:[UIImage imageNamed:@"miniThermo"] forState:UIControlStateSelected];
    [thermoButton addTarget:self action:@selector(thermoButton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:thermoButton];
    
    UILabel *thermoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15.0f, thermoButton.frame.origin.y+thermoButton.frame.size.height+21.0f, 80.0f, 30.0f)];
    thermoLabel.backgroundColor = [UIColor clearColor];
    thermoLabel.text = @"Thermostat";
    thermoLabel.textColor = [UIColor whiteColor];
    thermoLabel.font= [UIFont boldSystemFontOfSize:14.0f];
    [MainView addSubview:thermoLabel];
    
    CGFloat margin = 7.0f;
    CGFloat width = (self.view.bounds.size.width - (margin * 2.0f));
    CGFloat pickerHeight = 50.0f;
    CGFloat x = margin;
    CGFloat y = DynamicMonthLbl.frame.origin.y+DynamicMonthLbl.frame.size.height+5.0f;
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
    [MainView addSubview:_pickerView];
    
    
    UIView *scrollview = [[UIView alloc]initWithFrame:CGRectMake(125.0f, _pickerView.frame.origin.y+_pickerView.frame.size.height-40.0f, 320.0f, 170.0f)];
    [scrollview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:scrollview];
    
    
    //scrollview................
    MainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 200.0f, 170.0f)];
    MainScroll.userInteractionEnabled=YES;
    MainScroll.scrollEnabled=YES;
    MainScroll.delegate=self;
    MainScroll.bounces=YES;
    MainScroll.showsHorizontalScrollIndicator=NO;
    MainScroll.backgroundColor = [UIColor clearColor];
    //MainScroll.contentSize=CGSizeMake(500.0f, 2.0f);
    [scrollview addSubview:MainScroll];
    
    UIImageView *deviceIndicator = [[UIImageView alloc]initWithFrame:CGRectMake(100.0f, scrollview.frame.origin.y+scrollview.frame.size.height-28.0f, 130.0f, 40.0f)];
    deviceIndicator.image = [UIImage imageNamed:@"selectedwatview"];
    [MainView addSubview:deviceIndicator];
    
    ///===============/////============////=====
    
    
    UIImageView *textimg = [[UIImageView alloc]initWithFrame:CGRectMake(60.0f, deviceIndicator.frame.origin.y+deviceIndicator.frame.size.height+10.0f, 200.0f, 92.0f)];
    [textimg setImage:[UIImage imageNamed:@"croptxt"]];
    [MainView addSubview:textimg];
    
    ///=========////==============

    
//    startbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [startbutton setFrame:CGRectMake(0.0f, 0.0f, 77.5f, 81.5f)];
//    [startbutton setBackgroundImage:[UIImage imageNamed:@"Startauditbtn"] forState:UIControlStateNormal];
//    [startbutton setBackgroundImage:[UIImage imageNamed:@"Startauditbtn"] forState:UIControlStateNormal];
////    [startbutton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
//    [MainScroll addSubview:startbutton];
    
    
//    plasmatvimg = [[UIImageView alloc]initWithFrame:CGRectMake(215.0f, 420.0f, 52.5f, 53.0f)];
//    [plasmatvimg setImage:[UIImage imageNamed:@"plasmatvimg"]];
//    [MainView addSubview:plasmatvimg];
//    
//    heaterimg = [[UIImageView alloc]initWithFrame:CGRectMake(290.0f, 420.0f, 52.5f, 53.0f)];
//    [heaterimg setImage:[UIImage imageNamed:@"plasmatvimg"]];
//    [MainView addSubview:heaterimg];
    
    //footerview.........========..........=====.....//
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    
//    footerbudgtbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [footerbudgtbtn setFrame:CGRectMake(20.0f, 4.0f, 31.5f, 35.0f)];
//    [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerbudght"] forState:UIControlStateNormal];
//    [footerbudgtbtn setBackgroundImage:[UIImage imageNamed:@"footerbudght"] forState:UIControlStateHighlighted];
//    [footerbudgtbtn addTarget:self action:@selector(footerbudght:) forControlEvents:UIControlEventTouchUpInside];
//    [UsBackView8 addSubview:footerbudgtbtn];
    
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
    
    
     // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
    FirstTimeScroll=NO;
    dispatch_queue_t Queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(Queue, ^{
        
        ReturnArray=[[MMGlobalUrlClass GetInstance] GlobalUrlFire:@"device_list.php"];
        
        NSLog(@"RETURN ARRAY-----> %@",ReturnArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            MMAppDelegate *AppObj=[[UIApplication sharedApplication]delegate];
            AppObj.ImageThumUrlArray=[ReturnArray copy];
            
            //------------------Temporary array for static images and name. Remove when original item is fetched from API---------------//
            
            staticItemImage = [[NSMutableArray alloc]init];
            staticItemName = [[NSMutableArray alloc] init];
            staticItemWatt = [[NSMutableArray alloc]init];
            
            for (int i = 0; i<20; i++) {
                
                //WithObjects:[UIImage imageNamed:@"PlasmaTV"], nil];
                [staticItemImage addObject:[UIImage imageNamed:@"PlasmaTV"]];
                [staticItemName addObject:@"Plasma TV"];
                [staticItemWatt addObject:@"100W"];
            }
            
            NSLog(@"STATIC IMAGE COUNT %lu------ NAME------ %@",(unsigned long)staticItemName.count,staticItemImage);
            
            ///----------------------------------------END------------------------------------------//
            
            
            
            if (staticItemImage.count > 0) {
            //if ([ReturnArray count]>0) {  ------------Delete comment out when deleting the above code for static images and name
                
                
                UILabel *wattLabel = [[UILabel alloc]initWithFrame:CGRectMake(13.0f, 5.0f, 75.0f, 20.0f)];
                wattLabel.backgroundColor = [UIColor clearColor];
                wattLabel.text = @"Wattage";
                wattLabel.font = [UIFont boldSystemFontOfSize:15.0f];
                wattLabel.textColor = [UIColor whiteColor];
                [MainScroll addSubview:wattLabel];
                
                startbutton = [UIButton buttonWithType:UIButtonTypeCustom];
                [startbutton setFrame:CGRectMake(0.0f, 48.0f, 80.5f, 85.5f)];
                [startbutton setBackgroundImage:[UIImage imageNamed:@"Startauditbtn"] forState:UIControlStateNormal];
                //    [startbutton addTarget:self action:@selector(start:) forControlEvents:UIControlEventTouchUpInside];
                [MainScroll addSubview:startbutton];
                
                UILabel *deviceNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, startbutton.frame.origin.y+startbutton.frame.size.height+18.0f, 95.0f, 20.0f)];
                deviceNameLabel.backgroundColor = [UIColor clearColor];
                deviceNameLabel.text = @"Device Name";
                deviceNameLabel.font = [UIFont boldSystemFontOfSize:15.0f];
                deviceNameLabel.textColor = [UIColor whiteColor];
                [MainScroll addSubview:deviceNameLabel];
                
                //-----------FOR ITEM IMAGES---------//
                
                int j = 110.0f;
                
                for (int i = 0; i<[staticItemImage count]; i++){ //for (int i = 0; i<[ReturnArray count]; i++) { //--------------Remove code comment
                    
                    UILabel *wattLabel = [[UILabel alloc]initWithFrame:CGRectMake(j+27.0f, 7.0f, 50.0f, 20.0f)];
                    wattLabel.backgroundColor = [UIColor clearColor];
                    wattLabel.text = [NSString stringWithFormat:@"%@",[staticItemWatt objectAtIndex:i]];
                    
                    //---------Remove code comment------/
//                    wattLabel.text = [NSString stringWithFormat:@"%@",[[ReturnArray objectAtIndex:i] objectForKey:@"wattage"]];
                    wattLabel.font = [UIFont systemFontOfSize:12.0f];
                    wattLabel.textColor = [UIColor whiteColor];
                    [MainScroll addSubview:wattLabel];
                    
                    
                    plasmatvimg = [[UIImageView alloc]initWithFrame:CGRectMake(j, 55.0f, 75.5f, 70.0f)];
                    plasmatvimg.backgroundColor=[UIColor clearColor];
                    [plasmatvimg setImage:[staticItemImage objectAtIndex:i]];
                    
                    
                    //---------Remove code comment------/
                    
//                    [plasmatvimg sd_setImageWithURL:[NSURL URLWithString:[[ReturnArray objectAtIndex:i] objectForKey:@"device_image_thumb"]] placeholderImage:[UIImage imageNamed:@"NoImage.png"] options:i==0?SDWebImageRefreshCached:0];
                    [MainScroll addSubview:plasmatvimg];
                    
                    
                    UILabel *TitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(plasmatvimg.frame.origin.x-10, plasmatvimg.frame.origin.y+plasmatvimg.frame.size.height+23, plasmatvimg.frame.size.width+15, 20)];
                    TitleLbl.textColor =[UIColor whiteColor];
                    TitleLbl.textAlignment=NSTextAlignmentCenter;
                    TitleLbl.adjustsFontSizeToFitWidth=YES;
                    TitleLbl.font=[UIFont systemFontOfSize:13];
                    [TitleLbl setText:[staticItemName objectAtIndex:i]];
                    
                    //---------Remove code comment------/
//                    [TitleLbl setText:[[ReturnArray objectAtIndex:i] objectForKey:@"title"]];
                    [MainScroll addSubview:TitleLbl];
                    
                    plasmatvimg.tag = i;
                    
                    UITapGestureRecognizer *imagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagetap:)];
                    [plasmatvimg addGestureRecognizer:imagetap];
                    plasmatvimg.userInteractionEnabled = YES;
                    
                    j = j+90.5f;
                }
                //  } completion:^(BOOL finished) {
                
                
                [MainScroll setContentSize:CGSizeMake(plasmatvimg.frame.size.width*[ReturnArray count]+[ReturnArray count]*23.0f, MainScroll.frame.size.height)];
                
                
            } else {
                UIAlertView *ChangePassAlert=[[UIAlertView  alloc]initWithTitle:@"Alert!" message:@"check your internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                ChangePassAlert.delegate=self;
                [ChangePassAlert show];
                
                
            }
            
            
        });
    });
}
- (NSInteger)numberOfElementsInHorizontalPickerView:(V8HorizontalPickerView *)picker {
    
    return [ReturnArray count];
}

-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *view = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
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

-(void)startFetchingImageToSwipe
{
    //kk
}


//-(void)start:(UIButton *)sender{
//    
//    [startbutton removeFromSuperview];
//    [plasmatvimg removeFromSuperview];
//    [heaterimg removeFromSuperview];
//    
//    
//            if ([ReturnArray count]>0) {
//
//                
//               
//                [UIView animateWithDuration:1.0 animations:^{
//                    
//                    [MainScroll setFrame:CGRectMake(10,MainScroll.frame.origin.y, MainScroll.frame.size.width, MainScroll.frame.size.height)];
//                    int j = 10.0f;
//                    
//                    for (int i = 0; i<[ReturnArray count]; i++) {
//                        
//                        
//                        plasmatvimg = [[UIImageView alloc]initWithFrame:CGRectMake(j, 5.0f, 52.5f, 53.0f)];
//                        plasmatvimg.backgroundColor=[UIColor clearColor];
//                       
//                       // [plasmatvimg setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[ReturnArray objectAtIndex:i] objectForKey:@"device_image_thumb"]]]]];
//                        
//                        
////                        [plasmatvimg setImageWithURL:[NSURL URLWithString:[[ReturnArray objectAtIndex:i] objectForKey:@"device_image_thumb"]]
////                                      placeholderImage:[UIImage imageNamed:@"NoImage.png"] options:i== 0 ? SDWebImageRefreshCached : 0];
//
//                        [plasmatvimg sd_setImageWithURL:[NSURL URLWithString:[[ReturnArray objectAtIndex:i] objectForKey:@"device_image_thumb"]] placeholderImage:[UIImage imageNamed:@"NoImage.png"] options:i==0?SDWebImageRefreshCached:0];
//                        [MainScroll addSubview:plasmatvimg];
//                        
//                        UILabel *TitleLbl=[[UILabel alloc]initWithFrame:CGRectMake(plasmatvimg.frame.origin.x-10, plasmatvimg.frame.origin.y+plasmatvimg.frame.size.height+2, plasmatvimg.frame.size.width+20, 20)];
//                        TitleLbl.textColor =[UIColor whiteColor];
//                        TitleLbl.textAlignment=NSTextAlignmentCenter;
//                        TitleLbl.adjustsFontSizeToFitWidth=YES;
//                        TitleLbl.font=[UIFont systemFontOfSize:15];
//                        [MainScroll addSubview:TitleLbl];
//                        [TitleLbl setText:[[ReturnArray objectAtIndex:i] objectForKey:@"title"]];
//                        
//                        plasmatvimg.tag = i;
//                        
//                        UITapGestureRecognizer *imagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagetap:)];
//                        [plasmatvimg addGestureRecognizer:imagetap];
//                        plasmatvimg.userInteractionEnabled = YES;
//                        
//                        j = j+90.5f;
//                    }
//                } completion:^(BOOL finished) {
//                    
//                    
//                    [MainScroll setContentSize:CGSizeMake(plasmatvimg.frame.size.width*[ReturnArray count]+[ReturnArray count]*40, MainScroll.frame.size.height)];
//                    
//                    
//                }];
//                
//
//            } else {
//                UIAlertView *ChangePassAlert=[[UIAlertView  alloc]initWithTitle:@"Alert!" message:@"check your internet connection" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//                    ChangePassAlert.delegate=self;
//                    [ChangePassAlert show];
//                
//                
//            }
//            
//            //[self checkLoader];
//            
//           
//    
//    
//
//}



-(void)imagetap:(UITapGestureRecognizer *)sender{

    
    
    MMUsageBudgetauditnxtViewController *model = [[MMUsageBudgetauditnxtViewController alloc]init];
    
    //------------Remove comment out later-----PK-----//
    
//    [model setSelectedDeviceID:[[[ReturnArray objectAtIndex:sender.view.tag] objectForKey:@"id"] intValue]];
//    [model setDeviceTitle:[[ReturnArray objectAtIndex:sender.view.tag] objectForKey:@"title"]];
//    [model setImageUrlFromPreviuosPage:[[ReturnArray objectAtIndex:sender.view.tag] objectForKey:@"device_image_thumb"]];
    
    [model setSelectedDeviceID:[[staticItemName objectAtIndex:sender.view.tag] intValue]];
    [model setDeviceTitle:[staticItemName objectAtIndex:sender.view.tag]];
    [model setImageUrlFromPreviuosPage:[staticItemImage objectAtIndex:sender.view.tag]];

    
    [self.navigationController pushViewController:model animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)checkLoader
{
    
    if([self.view.subviews containsObject:loader_shadow_View])
    {

        
        [loader_shadow_View removeFromSuperview];
        [self.view setUserInteractionEnabled:YES];
    }
    else
    {

        loader_shadow_View = [[UIView alloc] initWithFrame:self.view.frame];
        [loader_shadow_View setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.56f]];
        
        [loader_shadow_View setUserInteractionEnabled:NO];
        [[loader_shadow_View layer] setZPosition:2];
        [self.view setUserInteractionEnabled:NO];
        UIActivityIndicatorView *loader =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        [loader setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
        
        [loader startAnimating];
        
        
        [loader_shadow_View addSubview:loader];
        [self.view addSubview:loader_shadow_View];
    }
}
-(void)footerBack:(UIButton *)sender
{
    [[self navigationController] popViewControllerAnimated:NO];
    
}

- (void)thermoButton:(UIButton *)sender{
    
    MMUsageBudgetThermoViewController *navto = [[MMUsageBudgetThermoViewController alloc]init];
    [self.navigationController pushViewController:navto animated:NO];
    
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
