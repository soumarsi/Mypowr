//
//  MMusagesharebillViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 07/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMusagesharebillViewController.h"
#import "MMusagebillViewController.h"
#define kOFFSET_FOR_KEYBOARD 120.0
#import "MMUsageBudgetViewController.h"
#import "MMUsageTreeViewController.h"
#import "MMBillPayDetailsViewController.h"

@interface MMusagesharebillViewController ()

@end

@implementation MMusagesharebillViewController

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
    
    NSLog(@"MMusagesharebillViewController");
    
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
    
    
    UIImageView *linetext = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 390.0f, 320.0f, 0.5f)];
    [linetext setImage:[UIImage imageNamed:@"divideimg"]];
    [MainView addSubview:linetext];
    
    mobileno = [[UITextField alloc]initWithFrame:CGRectMake(0.0f, 390.0f, 320.0f, 50.0f)];
    [mobileno setBackgroundColor:[UIColor clearColor]];
    mobileno.placeholder = @"Enter Mobile Phone";
    mobileno.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    mobileno.text = @"";
    mobileno.textColor = [UIColor whiteColor];
    UIView *leftView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 43, 6)];
    [mobileno setLeftView:leftView5];
    [mobileno setLeftViewMode:UITextFieldViewModeAlways];
    [mobileno setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [mobileno setValue:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:25.0f]  forKeyPath:@"_placeholderLabel.font"];
    [mobileno setDelegate:self];
    mobileno.autocorrectionType = UITextAutocorrectionTypeNo;
    mobileno.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    [MainView addSubview:mobileno];
    
    UIImageView *linetext1 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 440.0f, 320.0f, 0.5f)];
    [linetext1 setImage:[UIImage imageNamed:@"divideimg"]];
    [MainView addSubview:linetext1];
    
    ///===========//////////===================/////////==========
    
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 530.0f, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Backbtn];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 526.0f, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    
    
    
    Savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Savebtn setFrame:CGRectMake(270.0f, 528.0f, 22, 36)];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateNormal];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateHighlighted];
    [Savebtn addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Savebtn];
    
    
    UIView *saveview = [[UIView alloc]initWithFrame:CGRectMake(260.0f, 526.0f, 42.0f, 40.0f)];
    [saveview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:saveview];
    
    
    UITapGestureRecognizer *savetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Save:)];
    [saveview addGestureRecognizer:savetap];
    saveview.userInteractionEnabled = YES;
    
    // Do any additional setup after loading the view.
}

-(void)detailstap:(UITapGestureRecognizer *)sender{
    
    NSLog(@"DETAILS TAP");
    
    MMBillPayDetailsViewController *details = [[MMBillPayDetailsViewController alloc]init];
    [self.navigationController pushViewController:details animated:NO];
    
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

-(void)back:(UIButton *)sender{
    
    MMusagebillViewController *bill = [[MMusagebillViewController alloc]init];
    [self.navigationController pushViewController:bill animated:NO];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    // register for keyboard notifications
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
}


- (void)viewWillDisappear:(BOOL)animated

{
    // unregister for keyboard notifications while not visible.
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification  object:nil];
    
}

-(void)keyboardWillShow {
    
    [self setViewMovedUp:YES];
    
    
}





-(void)keyboardWillHide {
    
    [self setViewMovedUp:NO];
    
}


-(void)setViewMovedUp:(BOOL)movedUp

{
    
    [UIView beginAnimations:nil context:NULL];
    
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = MainView.frame;
    
    
    
    if (movedUp)
    {
              if(rect.origin.y != -120.000000){
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
              }
        
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    
    MainView.frame = rect;
    
    [UIView commitAnimations];
    
}
-(void)budget:(UIButton *)sender{
    
    MMUsageBudgetViewController *model = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
    
}

-(void)Save:(UIButton *)sender{
    
    if ([mobileno.text isEqualToString:@""]) {
        
        mobileno.text = @"";
        mobileno.placeholder = @"Please enter mobile no";
        return;
    }
    else if ([mobileno.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length <1){
        
        mobileno.text = @"";
        mobileno.placeholder = @"Please enter mobile no";
        return;
    }
    else{
        UIDevice *device = [UIDevice currentDevice];
        if ([[device model] isEqualToString:@"iPhone"] ) {
            
            MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
            
            if([MFMessageComposeViewController canSendText]) {
                
                controller.body = [NSString stringWithFormat:@"%f%f",22.33,123.34];
                controller.recipients = [NSArray arrayWithObjects:mobileno.text, nil];
                controller.messageComposeDelegate = self;
                [self.navigationController presentViewController:controller animated:YES completion:nil];
            }
        }
        else
        {
            UIAlertView *notPermitted=[[UIAlertView alloc] initWithTitle:@"Alert" message:@"Your device doesn't support this feature." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [notPermitted show];
        }
        
        
    }
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    if (result == MessageComposeResultCancelled) {
        

        
    } else if (result == MessageComposeResultSent) {
        

    }
    
}

-(void)usage:(UIButton *)sender{
    
    MMUsageTreeViewController *model = [[MMUsageTreeViewController alloc]init];
    [self.navigationController pushViewController:model animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
