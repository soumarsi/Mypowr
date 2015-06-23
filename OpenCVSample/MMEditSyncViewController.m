//
//  MMEditSyncViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 13/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMEditSyncViewController.h"

@interface MMEditSyncViewController ()

@end

@implementation MMEditSyncViewController

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
    
    NSLog(@"MMEditSyncViewController");
    
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
    [HeaderLbl setText:@"S Y N C"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [MainView addSubview:HeaderLbl];
    
    
    //user details........................
    //first name and last name labl............................
    
    Fullnamelbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 70.0f, 170,40)];
    Fullnamelbl.text = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"firstname"],[[NSUserDefaults standardUserDefaults]objectForKey:@"lastname"]];
    Fullnamelbl.backgroundColor = [UIColor clearColor];
    Fullnamelbl.textColor = [UIColor whiteColor];
    Fullnamelbl.numberOfLines = 2;
    Fullnamelbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    Fullnamelbl.textAlignment = NSTextAlignmentLeft;
    [MainView addSubview:Fullnamelbl];
    
    //user email labl............................
    
    UserEmail = [[UILabel alloc] initWithFrame:CGRectMake(40, 110.0f, 170,20)];
    UserEmail.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];
    UserEmail.textColor = [UIColor whiteColor];
    UserEmail.backgroundColor = [UIColor clearColor];
    UserEmail.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:14];
    UserEmail.textAlignment = NSTextAlignmentLeft;
    [MainView addSubview:UserEmail];
    
    
        //phone labl...........................
    
    phonelbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 130.0f, 170,20)];
    phonelbl.text = [NSString stringWithFormat:@"2412-124-324"];
    phonelbl.textColor = [UIColor whiteColor];
    phonelbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:14];
    phonelbl.textAlignment = NSTextAlignmentLeft;
    [MainView addSubview:phonelbl];
    
    
    //syc labl............................
    
    synclbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 150.0f, 170,20)];
    synclbl.text = [NSString stringWithFormat:@"Sync # 234-3455-234"];
    synclbl.textColor = [UIColor whiteColor];
    synclbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:14];
    synclbl.textAlignment = NSTextAlignmentLeft;
    [MainView addSubview:synclbl];
    

    //Edit button..........................
    
    
    Edit_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Edit_btn setFrame:CGRectMake(220.0f, 95.0f, 131/2, 88/2)];
    [Edit_btn setBackgroundImage:[UIImage imageNamed:@"Editsyncbtn"] forState:UIControlStateNormal];
    [Edit_btn setBackgroundImage:[UIImage imageNamed:@"Editsyncbtn"] forState:UIControlStateHighlighted];
   // [Edit_btn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Edit_btn];
    
    
    //user fullname and last name textfield....................
    
    UIView *UsBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, 320, 85/2)];
    UsBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fullnametxtfiled"]];
    [MainView addSubview:UsBackView];
    
    FullName = [[UITextField alloc] initWithFrame:CGRectMake(0, 180.0f, 160.0f, 85/2)];
    FullName.backgroundColor = [UIColor clearColor];
    FullName.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    FullName.placeholder = @"First Name";
    FullName.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"firstname"]];
    FullName.textColor = [UIColor whiteColor];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [FullName setLeftView:leftView3];
    [FullName setLeftViewMode:UITextFieldViewModeAlways];
    [FullName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [FullName setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [FullName setDelegate:self];
    [MainView addSubview:FullName];
    
    
    lastname = [[UITextField alloc] initWithFrame:CGRectMake(160, 180.0f, 160.0f, 85/2)];
    lastname.backgroundColor = [UIColor clearColor];
    lastname.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    lastname.placeholder = @"Last";
    lastname.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"lastname"]];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [lastname setLeftView:leftView];
    [lastname setLeftViewMode:UITextFieldViewModeAlways];
    lastname.textColor = [UIColor whiteColor];
    [lastname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [lastname setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [lastname setDelegate:self];
    [MainView addSubview:lastname];
    
    //email field............
    
    
    UIView *UsBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 223, 320, 85/2)];
    UsBackView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView1];
    
    Email = [[UITextField alloc] initWithFrame:CGRectMake(0, 223.0f, 320.0f, 85/2)];
    Email.backgroundColor = [UIColor clearColor];
    Email.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    Email.placeholder = @"Email";
    Email.text=[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];
    Email.textColor = [UIColor whiteColor];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [Email setLeftView:leftView1];
    [Email setLeftViewMode:UITextFieldViewModeAlways];
    [Email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [Email setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [Email setDelegate:self];
    [MainView addSubview:Email];
    
    // field............
    
    
    UIView *UsBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 266, 320, 85/2)];
    UsBackView2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView2];
    
    phone = [[UITextField alloc] initWithFrame:CGRectMake(0, 266.0f, 320.0f, 85/2)];
    phone.backgroundColor = [UIColor clearColor];
    phone.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    phone.text=@"143-342345-234";
    phone.textColor = [UIColor whiteColor];
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [phone setLeftView:leftView2];
    [phone setLeftViewMode:UITextFieldViewModeAlways];
    [phone setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [phone setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [phone setDelegate:self];
    [MainView addSubview:phone];
    
    

    
    //backbutton and resend button.........................
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 528.0f, 54/2, 33)];
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
    
    resendbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resendbtn setFrame:CGRectMake(260.0f, 528.0f, 68/2, 36)];
    [resendbtn setBackgroundImage:[UIImage imageNamed:@"Resendbtn"] forState:UIControlStateNormal];
    [resendbtn setBackgroundImage:[UIImage imageNamed:@"Resendbtn"] forState:UIControlStateHighlighted];
 //   [resendbtn addTarget:self action:@selector(resend:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:resendbtn];
    

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

-(void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:NO];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
