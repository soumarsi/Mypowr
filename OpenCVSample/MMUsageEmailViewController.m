//
//  MMUsageEmailViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMUsageEmailViewController.h"
#import "MMusagesharebillViewController.h"
#import "MMUsageBudgetViewController.h"
#import "MMUsageTreeViewController.h"

@interface MMUsageEmailViewController ()

@end

@implementation MMUsageEmailViewController

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
    
    NSLog(@"MMUsageEmailViewController");
    
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
    [billbtn setFrame:CGRectMake(153, 82.0f, 50/2, 79/2)];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateNormal];
    [billbtn setBackgroundImage:[UIImage imageNamed:@"billimgbtn"] forState:UIControlStateHighlighted];
    //[billbtn addTarget:self action:@selector(bill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:billbtn];
    
    
    //usage button ..........
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(251, 89.0f, 74/2, 65/2)];
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
    
    
    //=======///=====////=====
    
    
    UIImageView *questionmark = [[UIImageView alloc]initWithFrame:CGRectMake(20.0f, 190.0f, 19.0f, 19.0f)];
    [questionmark setImage:[UIImage imageNamed:@"Questionmarkimg"]];
    [MainView addSubview:questionmark];
    
    
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
    
    //=================//////////==========
    
    UILabel *labl = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, 310.0f, 280.0f, 40.0f)];
    [labl setText:@"Share your bill with someone else"];
    [labl setTextAlignment:NSTextAlignmentCenter];
    [labl setTextColor:[UIColor whiteColor]];
    [labl setFont:[UIFont fontWithName:GLOBALTEXTFONT size:18]];
    [labl setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:labl];
    
    
    UILabel *labl1 = [[UILabel alloc]initWithFrame:CGRectMake(30.0f, 340.0f, 260.0f, 40.0f)];
    [labl1 setText:@"How would you like to contact them?"];
    [labl1 setTextAlignment:NSTextAlignmentCenter];
    [labl1 setTextColor:[UIColor whiteColor]];
    [labl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT size:14]];
    [labl1 setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:labl1];
    
    ///===========//////////===================/////////==========
    
    //email and text field............
    
    
    UIImageView *linetext = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 380.0f, 320.0f, 0.5f)];
    [linetext setImage:[UIImage imageNamed:@"divideimg"]];
    [MainView addSubview:linetext];
    
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(159.5f, 380.0f, 0.5f, 50.0f)];
    [lineview setBackgroundColor:[UIColor whiteColor]];
    [MainView addSubview:lineview];
    
    UIImageView *linetext1 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 430.0f, 320.0f, 0.5f)];
    [linetext1 setImage:[UIImage imageNamed:@"divideimg"]];
    [MainView addSubview:linetext1];
    
    emailbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [emailbtn setFrame:CGRectMake(2.0f, 382.0f, 156.0f, 46.0f)];
    [emailbtn setBackgroundColor:[UIColor colorWithRed:(171.0f/255.0f) green:(200.0f/255.0f) blue:(219.0f/255.0f) alpha:1]];
    [emailbtn setTitle:@"Email" forState:UIControlStateNormal];
    [emailbtn setTitle:@"Email" forState:UIControlStateHighlighted];
    [emailbtn setTitle:@"Email" forState:UIControlStateSelected];
    [emailbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    emailbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    emailbtn.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:25];
    [emailbtn addTarget:self action:@selector(email:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:emailbtn];
    
    
    textbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [textbtn setFrame:CGRectMake(162.0f, 382.0f, 156.0f, 46.0f)];
    [textbtn setBackgroundColor:[UIColor colorWithRed:(171.0f/255.0f) green:(200.0f/255.0f) blue:(219.0f/255.0f) alpha:1]];
    [textbtn setTitle:@"Text" forState:UIControlStateNormal];
    [textbtn setTitle:@"Text" forState:UIControlStateHighlighted];
    [textbtn setTitle:@"Text" forState:UIControlStateSelected];
    [textbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    textbtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    textbtn.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:25];
    [textbtn addTarget:self action:@selector(text:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:textbtn];
    
    BlackView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 568.0f)];
    [BlackView setBackgroundColor:[UIColor blackColor]];
    [BlackView setAlpha:0.8f];
    [MainView addSubview:BlackView];
    [BlackView setHidden:YES];
    
    crossbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    crossbtn.frame = CGRectMake(255, 150, 90/2, 90/2);
    crossbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"crossBtn"]];
    [crossbtn addTarget:self action:@selector(cross:) forControlEvents:UIControlEventTouchUpInside];
    [BlackView addSubview:crossbtn];
    
    
    
    
    
    ////==============//////////////////=============
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    //paymethod button ..........
    
    
    paymethod = [UIButton buttonWithType:UIButtonTypeCustom];
    [paymethod setFrame:CGRectMake(275.0f, 530.0f, 20.0f, 36.5f)];
    [paymethod setBackgroundImage:[UIImage imageNamed:@"paybtnimg"] forState:UIControlStateNormal];
    [paymethod setBackgroundImage:[UIImage imageNamed:@"paybtnimg"] forState:UIControlStateHighlighted];
    //[paymethod addTarget:self action:@selector(paymethod:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:paymethod];
    
    
    //share bill button ..........
    
    
    Sharebillbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Sharebillbtn setFrame:CGRectMake(180.0f, 530.0f, 40.5f, 34.5f)];
    [Sharebillbtn setBackgroundImage:[UIImage imageNamed:@"sharebillbtnimg"] forState:UIControlStateNormal];
    [Sharebillbtn setBackgroundImage:[UIImage imageNamed:@"sharebillbtnimg"] forState:UIControlStateHighlighted];
    [Sharebillbtn addTarget:self action:@selector(sharebill:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Sharebillbtn];
    
    
    
    Savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Savebtn setFrame:CGRectMake(100.0f, 530.0f, 54/2, 64/2)];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"emailbtnimg"] forState:UIControlStateNormal];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"emailbtnimg"] forState:UIControlStateHighlighted];
    [Savebtn addTarget:self action:@selector(Saveemail:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Savebtn];
    
    //cancel button......
    
    
    cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelbtn setFrame:CGRectMake(15.0f, 530.0f, 30.5f, 32.5f)];
    [cancelbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateNormal];
    [cancelbtn setBackgroundImage:[UIImage imageNamed:@"BackFooterImage"] forState:UIControlStateHighlighted];
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
//textfield return function...............

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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


-(void)email:(UIButton *)sender{
    
    [BlackView setHidden:NO];
    
    
    backview = [[UIView alloc]initWithFrame:CGRectMake(20.0f, 190.0f, 280.0f, 120.0f)];
    [backview setBackgroundColor:[UIColor whiteColor]];
    backview.layer.cornerRadius = 5.0f;
    [MainView addSubview:backview];
    
    email = [[UITextField alloc] initWithFrame:CGRectMake(10,20.0f, 260.0f, 40)];
    email.backgroundColor = [UIColor clearColor];
    email.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    email.placeholder = @"Email";
    email.text=@"";
    email.textColor = [UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f];
    email.layer.borderWidth = 1.0f;
    email.layer.borderColor = [[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f]CGColor];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 3)];
    [email setLeftView:leftView3];
    [email setLeftViewMode:UITextFieldViewModeAlways];
    [email setValue:[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f] forKeyPath:@"_placeholderLabel.textColor"];
    [email setValue:[UIFont fontWithName:GLOBALTEXTFONT size:25]  forKeyPath:@"_placeholderLabel.font"];
    [email setDelegate:self];
    email.keyboardType = UIKeyboardTypeEmailAddress;
    [backview addSubview:email];
    
    UIButton *savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [savebtn setFrame:CGRectMake(50.0f, 70.0f, 180.0f, 35.0f)];
    [savebtn setTitle:@"Save" forState:UIControlStateNormal];
    [savebtn setTitle:@"Save" forState:UIControlStateHighlighted];
    [savebtn setTitle:@"Save" forState:UIControlStateSelected];
    [savebtn setBackgroundColor:[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f]];
    savebtn.titleLabel.textColor = [UIColor whiteColor];
    savebtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    savebtn.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:20];
    [savebtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:savebtn];
    
}
-(void)text:(UIButton *)sender{
    
    [BlackView setHidden:NO];
    
    backview = [[UIView alloc]initWithFrame:CGRectMake(20.0f, 190.0f, 280.0f, 120.0f)];
    [backview setBackgroundColor:[UIColor whiteColor]];
    backview.layer.cornerRadius = 5.0f;
    [MainView addSubview:backview];
    
    textviw = [[UITextView alloc] initWithFrame:CGRectMake(10,20.0f, 260.0f, 40)];
    textviw.backgroundColor = [UIColor clearColor];
    textviw.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    textviw.text=@"";
    textviw.textColor = [UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f];
    textviw.layer.borderWidth = 1.0f;
    textviw.layer.borderColor = [[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f]CGColor];
    [textviw setDelegate:self];
    [backview addSubview:textviw];
    
    
    placelabl=[[UILabel alloc]initWithFrame:CGRectMake(6.0f, 8.0f, 200.0f, 20.0f)];
    placelabl.text=@"Text";
    placelabl.font=[UIFont fontWithName:GLOBALTEXTFONT size:17];
    placelabl.textAlignment=NSTextAlignmentLeft;
    //[placelabl setHidden:YES];
    placelabl.textColor=[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f];
    [textviw addSubview:placelabl];
    
    UIButton *savebtexttn = [UIButton buttonWithType:UIButtonTypeCustom];
    [savebtexttn setFrame:CGRectMake(50.0f, 70.0f, 180.0f, 35.0f)];
    [savebtexttn setTitle:@"Save" forState:UIControlStateNormal];
    [savebtexttn setTitle:@"Save" forState:UIControlStateHighlighted];
    [savebtexttn setTitle:@"Save" forState:UIControlStateSelected];
    [savebtexttn setBackgroundColor:[UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f]];
    savebtexttn.titleLabel.textColor = [UIColor whiteColor];
    savebtexttn.titleLabel.textAlignment = NSTextAlignmentCenter;
    savebtexttn.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:20];
    [savebtexttn addTarget:self action:@selector(savetext:) forControlEvents:UIControlEventTouchUpInside];
    [backview addSubview:savebtexttn];
}

-(void)cross:(UIButton *)sender{
    
    [textviw resignFirstResponder];
    [email resignFirstResponder];
    [BlackView setHidden:YES];
    [backview setHidden:YES];
}


-(void)save:(UIButton *)sender{
    
    [email resignFirstResponder];
    
    if ([email.text isEqualToString:@""]) {
        
        email.text = @"";
        email.placeholder = @"Please enter valid email";
        return;
    }
    else if ([email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length <1){
        
        email.text = @"";
        email.placeholder = @"Please enter valid email";
        return;
    }
    else if (![self NSStringIsValidEmail:email.text]){
        
        email.text = @"";
        email.placeholder = @"Please enter valid email";
        return;
    }
    else{
        emailstring = [NSString stringWithFormat:@"%@",email.text];
        
        
        [BlackView setHidden:YES];
        [backview setHidden:YES];
    }
}

-(void)savetext:(UIButton *)sender{
    
    [textviw resignFirstResponder];
    
    if ([textviw.text isEqualToString:@""]) {
        
        email.text = @"";
        email.placeholder = @"Please enter email";
        return;
    }
    else if ([textviw.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length <1){
        
        email.text = @"";
        email.placeholder = @"Please enter email";
        return;
    }
    
    else{
        textstring = [NSString stringWithFormat:@"%@",textviw.text];
        
        
        [BlackView setHidden:YES];
        [backview setHidden:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//email validation function...........
-(BOOL) NSStringIsValidEmail:(NSString *)checkString

{
    
    BOOL stricterFilter = YES;
    
    NSString *stricterFilterString = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:checkString];
    
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    //    commentbox.text = @"";
    placelabl.hidden=YES;
    textviw.textColor = [UIColor colorWithRed:(137.0f/255.0f) green:(177.0f/255.0f) blue:(204.0f/255.0f) alpha:1.0f];
    return YES;
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if ([textviw.text isEqualToString:@""]) {
        
        placelabl.hidden=NO;
        
    }
    else{
        
        
    }
    return YES;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    
    if([text isEqualToString:@"\n"]) {
        
        [textviw resignFirstResponder];
        
        return NO;
        
    }
    
    return YES;
    
}
-(void)Saveemail:(UIButton *)sender{
    
    if ([emailstring length] == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please enter email" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        
    }
    else{
        NSString *emailsaveStr = [[NSString alloc]init];
        
        emailsaveStr = [NSString stringWithFormat:@"%@/share_bill.php?user_id=%@&email=%@&text=%@&month_tot=%@&grand_tot=%@",DOMAIN_APP_URL,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],emailstring,[textviw.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[NSString stringWithFormat:@"22.34"],[NSString stringWithFormat:@"122.34"]];
        
        
        NSError *error=nil;
        
        
        NSData *EmailSaveData=[NSData dataWithContentsOfURL:[NSURL URLWithString:emailsaveStr]options:NSDataReadingUncached error:&error];
        NSString *EmailSavestr = [[NSString alloc]initWithData:EmailSaveData encoding:NSUTF8StringEncoding];
        
        if ([EmailSavestr isEqualToString:@"success"]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you" message:@"Email send successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alert show];
        }
    }
    
}
-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *model = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
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
