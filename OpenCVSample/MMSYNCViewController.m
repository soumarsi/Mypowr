//
//  MMSYNCViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 13/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMSYNCViewController.h"
#import "MMSettingsViewController.h"
#import "MMEditSyncViewController.h"

@interface MMSYNCViewController ()

@end

@implementation MMSYNCViewController

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
    
    NSLog(@"MMSYNCViewController");
    
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
    
    //user details..............................
    
    //first name and last name labl............................
    
    Fullnamelbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 105.0f, 150,40)];
    Fullnamelbl.text = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults]objectForKey:@"firstname"],[[NSUserDefaults standardUserDefaults]objectForKey:@"lastname"]];
    Fullnamelbl.textColor = [UIColor whiteColor];
    [Fullnamelbl setBackgroundColor:[UIColor clearColor]];
    [Fullnamelbl setNumberOfLines:2];
    Fullnamelbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    Fullnamelbl.textAlignment = NSTextAlignmentLeft;
    [MainView addSubview:Fullnamelbl];
    
    //user email labl............................
    
    UserEmail = [[UILabel alloc] initWithFrame:CGRectMake(40, 140.0f, 150,40)];
    UserEmail.text = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];
    UserEmail.textColor = [UIColor whiteColor];
    UserEmail.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:16];
    UserEmail.numberOfLines = 2;
    UserEmail.textAlignment = NSTextAlignmentLeft;
    [MainView addSubview:UserEmail];
    
    
    //syc labl............................
    
    synclbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 180.0f, 300,20)];
    synclbl.text = [NSString stringWithFormat:@"Sync # 234-3455-234"];
    synclbl.textColor = [UIColor whiteColor];
    synclbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:16];
    synclbl.textAlignment = NSTextAlignmentLeft;
    [MainView addSubview:synclbl];
    
    
    //Edit button..........................
    

    Edit_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Edit_btn setFrame:CGRectMake(220.0f, 125.0f, 107/2, 87/2)];
    [Edit_btn setBackgroundImage:[UIImage imageNamed:@"Editbtn"] forState:UIControlStateNormal];
    [Edit_btn setBackgroundImage:[UIImage imageNamed:@"Editbtn"] forState:UIControlStateHighlighted];
    [Edit_btn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Edit_btn];
    
    //backbutton.........................
    
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
    
    MMSettingsViewController *sync = [[MMSettingsViewController alloc]init];
    [self.navigationController pushViewController:sync animated:NO];
}

//edit function................

-(void)edit:(UIButton *)sender{
    
    MMEditSyncViewController *editsync = [[MMEditSyncViewController alloc]init];
    [self.navigationController pushViewController:editsync animated:NO];
    
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
