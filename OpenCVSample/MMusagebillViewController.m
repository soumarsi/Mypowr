//
//  MMusagebillViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMusagebillViewController.h"
#import "MMusagesharebillViewController.h"
#import "MMUsageEmailViewController.h"
#import "MMUsagePayViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMBillPayDetailsViewController.h"

@interface MMusagebillViewController ()

@end

@implementation MMusagebillViewController

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
    [super viewDidLoad];
   
    
    NSLog(@"MMusagebillViewController");
    
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
    [budgetbtn setFrame:CGRectMake(37.0f, 80.0f, 90/2, 83/2)];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateNormal];
    [budgetbtn setBackgroundImage:[UIImage imageNamed:@"Budgetimg"] forState:UIControlStateHighlighted];
    [budgetbtn addTarget:self action:@selector(budget:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:budgetbtn];
    
    
    //bill button ..........
    
    billbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billbtn setFrame:CGRectMake(153.0f, 82.0f, 50/2, 79/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateHighlighted];
    //[billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(251.0f, 89.0f, 74/2, 65/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usageimgbtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usage:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    //phill button ..........
    
//    phillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [phillbtn setFrame:CGRectMake(255, 82.0f, 56/2, 78/2)];
//    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateNormal];
//    [phillbtn setBackgroundImage:[UIImage imageNamed:@"phillimgbtn"] forState:UIControlStateHighlighted];
//    //[phillbtn addTarget:self action:@selector(phill:) forControlEvents:UIControlEventTouchUpInside];
//    [MainView addSubview:phillbtn];
    
    
    UIImageView *divideimg = [[UIImageView alloc]initWithFrame:CGRectMake(75.0f, 200.0f, 341/2, 0.5f)];
    [divideimg setImage:[UIImage imageNamed:@"divideimg"]];
    [MainView addSubview:divideimg];
    
    //============////////================
    
    UILabel *dollerimg = [[UILabel alloc]initWithFrame:CGRectMake(75.0f, 160.0f, 30.0f, 30.0f)];
    [dollerimg setText:@"$"];
    [dollerimg setTextAlignment:NSTextAlignmentLeft];
    [dollerimg setTextColor:[UIColor whiteColor]];
    [dollerimg setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20.0f]];
    [MainView addSubview:dollerimg];
    
    UILabel *amoutlbl = [[UILabel alloc]initWithFrame:CGRectMake(87.0f, 150.0f, 100.0f, 60.0f)];
    [amoutlbl setText:@"92.01"];
    [amoutlbl setTextAlignment:NSTextAlignmentLeft];
    [amoutlbl setTextColor:[UIColor whiteColor]];
    [amoutlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:38]];
    [MainView addSubview:amoutlbl];
    
    UILabel *datelbl = [[UILabel alloc]initWithFrame:CGRectMake(195.0f, 150.0f, 80.0f, 60.0f)];
    [datelbl setText:@"J u l y Total"];
    datelbl.numberOfLines = 2;
    [datelbl setTextAlignment:NSTextAlignmentLeft];
    [datelbl setTextColor:[UIColor whiteColor]];
    [datelbl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18.0f]];
    [MainView addSubview:datelbl];
    
    //===========////=======//========
    
    
    UILabel *dollerimg1 = [[UILabel alloc]initWithFrame:CGRectMake(65.0f, 205.0f, 30.0f, 40.0f)];
    [dollerimg1 setText:@"$"];
    [dollerimg1 setTextAlignment:NSTextAlignmentLeft];
    [dollerimg1 setTextColor:[UIColor whiteColor]];
    [dollerimg1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:20.0f]];
    [MainView addSubview:dollerimg1];
    
    UILabel *amoutlbl1 = [[UILabel alloc]initWithFrame:CGRectMake(77.0f, 200.0f, 120.0f, 60.0f)];
    [amoutlbl1 setText:@"178.73"];
    [amoutlbl1 setTextAlignment:NSTextAlignmentLeft];
    [amoutlbl1 setTextColor:[UIColor whiteColor]];
    [amoutlbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:38.0f]];
    [MainView addSubview:amoutlbl1];
    
    UILabel *datelbl1 = [[UILabel alloc]initWithFrame:CGRectMake(205.0f, 200.0f, 80.0f, 60.0f)];
    [datelbl1 setText:@"Grand Total"];
    datelbl1.numberOfLines = 2;
    [datelbl1 setTextAlignment:NSTextAlignmentLeft];
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
    
    
    //graph portion...................
    
    
    UIImageView *graphimg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 350.f, 310.0f, 106)];
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
    [MainView addSubview:img];
    
    ///===========//////////===================/////////==========
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    //email button ..........
    
    
    Emailbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Emailbtn setFrame:CGRectMake(15.0f, 532.3f, 27.0f, 32.0f)];
    [Emailbtn setBackgroundImage:[UIImage imageNamed:@"emailbtnimg"] forState:UIControlStateNormal];
    [Emailbtn setBackgroundImage:[UIImage imageNamed:@"emailbtnimg"] forState:UIControlStateHighlighted];
    [Emailbtn addTarget:self action:@selector(email:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Emailbtn];
    
    
    //share bill button ..........
    
    
    Sharebillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Sharebillbtn setFrame:CGRectMake(85.0f, 530.0f, 40.5f, 34.5f)];
    [Sharebillbtn setBackgroundImage:[UIImage imageNamed:@"sharebillbtnimg"] forState:UIControlStateNormal];
    [Sharebillbtn setBackgroundImage:[UIImage imageNamed:@"sharebillbtnimg"] forState:UIControlStateHighlighted];
    [Sharebillbtn addTarget:self action:@selector(sharebill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Sharebillbtn];
    
    
    //pay button......
    
    
    paybtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [paybtn setFrame:CGRectMake(285.0f, 531.0f, 19.5f, 34.5f)];
    [paybtn setBackgroundImage:[UIImage imageNamed:@"paybtnimg"] forState:UIControlStateNormal];
    [paybtn setBackgroundImage:[UIImage imageNamed:@"paybtnimg"] forState:UIControlStateHighlighted];
    [paybtn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:paybtn];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
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


//sharebill function...../////

-(void)sharebill:(UIButton *)sender{
    
    MMusagesharebillViewController *share = [[MMusagesharebillViewController alloc]init];
    [self.navigationController pushViewController:share animated:NO];
    
}

//Email function.........

-(void)email:(UIButton *)sender{
    
    MMUsageEmailViewController *share = [[MMUsageEmailViewController alloc]init];
    [self.navigationController pushViewController:share animated:NO];
    
}

//pay button function................
-(void)pay:(UIButton *)sender{
    
    MMUsagePayViewController *pay = [[MMUsagePayViewController alloc]init];
    [self.navigationController pushViewController:pay animated:NO];
    
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

///details tap function..........


-(void)detailstap:(UITapGestureRecognizer *)sender{
    
    MMBillPayDetailsViewController *details = [[MMBillPayDetailsViewController alloc]init];
    [self.navigationController pushViewController:details animated:NO];
    
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
