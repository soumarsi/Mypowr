//
//  MMUsagePayViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMUsagePayViewController.h"
#import "MMusagesharebillViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMUsageTreeViewController.h"
#import "MMBillPayDetailsViewController.h"

@interface MMUsagePayViewController ()

@end

@implementation MMUsagePayViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"MMUsagePayViewController");

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
    [budgetbtn setFrame:CGRectMake(30.0f, 80.0f, 90/2, 83/2)];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateNormal];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateHighlighted];
    [budgetbtn addTarget:self action:@selector(budget:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:budgetbtn];
    
    
    //bill button ..........
    
    billbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billbtn setFrame:CGRectMake(budgetbtn.frame.origin.x+budgetbtn.frame.size.width+35.0f,83.0f,50/2, 79/2)];//148.0f, 82.0f, 70/2, 84/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateHighlighted];
//    [billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(billbtn.frame.origin.x+billbtn.frame.size.width+40.0f,90.0f, 74/2, 65/2)];//251, 83.0f, 74/2, 65/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    //phill button ..........
    
    phillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [phillbtn setFrame:CGRectMake(usagebtn.frame.origin.x+usagebtn.frame.size.width+40.0f,83.0f, 56/2, 78/2)];//255, 83.0f, 56/2, 78/2)];
    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateNormal];
    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateHighlighted];
    //[phillbtn addTarget:self action:@selector(phill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:phillbtn];


    //============////////================
    
    UILabel *dollerimg = [[UILabel alloc]initWithFrame:CGRectMake(110.0f, 160.0f, 30.0f, 30.0f)];
    [dollerimg setText:@"$"];
    [dollerimg setTextAlignment:NSTextAlignmentLeft];
    [dollerimg setTextColor:[UIColor whiteColor]];
    [dollerimg setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20.0f]];
    [MainView addSubview:dollerimg];
    
    UILabel *amoutlbl = [[UILabel alloc]initWithFrame:CGRectMake(dollerimg.frame.origin.x+dollerimg.frame.size.width-16.0f, 150.0f, 100.0f, 60.0f)];
    [amoutlbl setText:@"92.01"];
    [amoutlbl setTextAlignment:NSTextAlignmentLeft];
    [amoutlbl setTextColor:[UIColor whiteColor]];
    [amoutlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:38]];
    [MainView addSubview:amoutlbl];
    
    UILabel *datelbl = [[UILabel alloc]initWithFrame:CGRectMake(amoutlbl.frame.origin.x+amoutlbl.frame.size.width-10.0f, 150.0f, 80.0f, 60.0f)];
    [datelbl setText:@"July \nTotal"];
    datelbl.numberOfLines = 2;
    datelbl.lineBreakMode = NSLineBreakByWordWrapping;
    [datelbl setTextAlignment:NSTextAlignmentCenter];
    [datelbl setTextColor:[UIColor whiteColor]];
    [datelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [MainView addSubview:datelbl];
    
    //------------------//
    
    UIImageView *divideimg = [[UIImageView alloc]initWithFrame:CGRectMake(dollerimg.frame.origin.x, datelbl.frame.origin.y+datelbl.frame.size.height-7.0f, 341/2, 0.5f)];
    [divideimg setImage:[UIImage imageNamed:@"divideimg"]];
    [MainView addSubview:divideimg];
    
    
    //=======///=====////=====
    
    
    UILabel *dueLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 152.0f, 55.0f, 30.0f)];
    dueLabel.text = @"DUE";
    dueLabel.backgroundColor = [UIColor clearColor];
    dueLabel.textAlignment = NSTextAlignmentCenter;
    dueLabel.textColor = [UIColor whiteColor];
    dueLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:13.0f];
    [MainView addSubview:dueLabel];
    
    UIView *dateBack = [[UIView alloc]initWithFrame:CGRectMake(20.0f, 180.0f, 55.0f, 50.0f)];
    dateBack.backgroundColor = [UIColor colorWithRed:(156.0f/255.0f) green:(186.0f/255.0f) blue:(209.0f/255.0f) alpha:1.0f];
    [MainView addSubview:dateBack];

    
    
    //===========////=======//========
    
    
    UILabel *dollerimg1 = [[UILabel alloc]initWithFrame:CGRectMake(92.0f, 200.0f, 30.0f, 40.0f)];
    [dollerimg1 setText:@"$"];
    [dollerimg1 setTextAlignment:NSTextAlignmentLeft];
    [dollerimg1 setTextColor:[UIColor whiteColor]];
    [dollerimg1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20.0f]];
    [MainView addSubview:dollerimg1];
    
    UILabel *amoutlbl1 = [[UILabel alloc]initWithFrame:CGRectMake(dollerimg1.frame.origin.x+dollerimg1.frame.size.width-17.0f, 195.0f, 120.0f, 60.0f)];
    [amoutlbl1 setText:@"178.73"];
    [amoutlbl1 setTextAlignment:NSTextAlignmentLeft];
    [amoutlbl1 setTextColor:[UIColor whiteColor]];
    [amoutlbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:38.0f]];
    [MainView addSubview:amoutlbl1];
    
    UILabel *datelbl1 = [[UILabel alloc]initWithFrame:CGRectMake(amoutlbl1.frame.origin.x+amoutlbl1.frame.size.width-9.0f, 195.0f, 80.0f, 60.0f)];
    [datelbl1 setText:@"Grand Total"];
    datelbl1.numberOfLines = 2;
    datelbl1.lineBreakMode = NSLineBreakByWordWrapping;
    [datelbl1 setTextAlignment:NSTextAlignmentCenter];
    [datelbl1 setTextColor:[UIColor whiteColor]];
    [datelbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [MainView addSubview:datelbl1];
    
    ///=============/////////==============//////
    
    UIImageView *detailsdivideimg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 280.0f, 320.0f, 32.0f)];
    [detailsdivideimg setImage:[UIImage imageNamed:@"detailsdivideimg"]];
    [MainView addSubview:detailsdivideimg];
    
    
    UIView *detailsview = [[UIView alloc]initWithFrame:CGRectMake(210.0f, 274.0f, 70.0f, 50.0f)];
    [detailsview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:detailsview];
    
    UITapGestureRecognizer *detailstap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailstap:)];
    [detailsview addGestureRecognizer:detailstap];
    detailsview.userInteractionEnabled = YES;
    
    //pay bill button.................
    
    
    UserName = [[UILabel alloc] initWithFrame:CGRectMake(10, 380.0f, 180,40)];
    UserName.text = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"firstname"],[[NSUserDefaults standardUserDefaults]objectForKey:@"lastname"]];
    UserName.textColor = [UIColor whiteColor];
    UserName.backgroundColor = [UIColor clearColor];
    UserName.numberOfLines = 2;
    UserName.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    UserName.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:UserName];
    
    UserVisa = [[UILabel alloc] initWithFrame:CGRectMake(35, 415.0f, 130,40)];
    UserVisa.text = [NSString stringWithFormat:@"Visa....3892"];
    UserVisa.textColor = [UIColor whiteColor];
    UserVisa.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
    UserVisa.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:UserVisa];
    
    
    UserAcct = [[UILabel alloc] initWithFrame:CGRectMake(40, 430.0f, 130,40)];
    UserAcct.text = [NSString stringWithFormat:@"Acct# :12345678"];
    UserAcct.textColor = [UIColor whiteColor];
    UserAcct.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
    UserAcct.textAlignment = NSTextAlignmentCenter;
    [MainView addSubview:UserAcct];
    
    
    paybillbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [paybillbutton setFrame:CGRectMake(206.0f, 390.0f, 90.0f, 43.5f)];
    [paybillbutton setBackgroundImage:[UIImage imageNamed:@"paybillbutton"] forState:UIControlStateNormal];
    [paybillbutton setBackgroundImage:[UIImage imageNamed:@"paybillbutton"] forState:UIControlStateHighlighted];
   // [paybillbutton addTarget:self action:@selector(paybill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:paybillbutton];
    
    ////==============//////////////////=============
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    //paymethod button ..........
    
    
    paymethod = [UIButton buttonWithType:UIButtonTypeCustom];
    [paymethod setFrame:CGRectMake(15.0f, 530.0f, 51.0f, 36.5f)];
    [paymethod setBackgroundImage:[UIImage imageNamed:@"paymethod"] forState:UIControlStateNormal];
    [paymethod setBackgroundImage:[UIImage imageNamed:@"paymethod"] forState:UIControlStateHighlighted];
    //[paymethod addTarget:self action:@selector(paymethod:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:paymethod];
    
    
    //share bill button ..........
    
    
    Sharebillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Sharebillbtn setFrame:CGRectMake(152.0f, 522.0f, 50.0f, 50.0f)];
    [Sharebillbtn setBackgroundImage:[UIImage imageNamed:@"sharebillbtnimg"] forState:UIControlStateNormal];
    [Sharebillbtn setBackgroundImage:[UIImage imageNamed:@"sharebillbtnimg"] forState:UIControlStateHighlighted];
    [Sharebillbtn addTarget:self action:@selector(sharebill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Sharebillbtn];
    
    
    //cancel button......
    
    
    cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelbtn setFrame:CGRectMake(275.0f, 531.0f, 30.5f, 32.5f)];
    [cancelbtn setBackgroundImage:[UIImage imageNamed:@"cancelbtn"] forState:UIControlStateNormal];
    [cancelbtn setBackgroundImage:[UIImage imageNamed:@"cancelbtn"] forState:UIControlStateHighlighted];
    [cancelbtn addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:cancelbtn];


    // Do any additional setup after loading the view.
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
//cancel function............

-(void)cancel:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:NO];
}
//share bill function............

-(void)sharebill:(UIButton *)sender{
    
    MMusagesharebillViewController *sharebill = [[MMusagesharebillViewController alloc]init];
    [self.navigationController pushViewController:sharebill animated:NO];
}
-(void)budget:(UIButton *)sender{
    
    MMUsageBudgetViewController *model = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *model = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
}


-(void)detailstap:(UIButton *)sender{
    
    MMBillPayDetailsViewController *view = [[MMBillPayDetailsViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
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
