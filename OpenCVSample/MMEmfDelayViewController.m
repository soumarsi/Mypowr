//
//  MMEmfDelayViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 13/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMEmfDelayViewController.h"

@interface MMEmfDelayViewController ()

@end

@implementation MMEmfDelayViewController

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
    
    NSLog(@"MMEmfDelayViewController");
    
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
    [HeaderLbl setText:@"EMF DELAY"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [MainView addSubview:HeaderLbl];
    
    UIView *twoBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 85.5/2)];
    twoBtnView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"twoBtnView"]];
    [MainView addSubview:twoBtnView];

    
    fstBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    fstBtn1.frame = CGRectMake(2, 2, (320/2)-2, (85.5/2)-4);
    fstBtn1.backgroundColor = [UIColor colorWithRed:(171.0f/255.0f) green:(200.0f/255.0f) blue:(219.0f/255.0f) alpha:1];
    [fstBtn1 setTitle:@"ON" forState:UIControlStateNormal];
    [fstBtn1 setTitle:@"ON" forState:UIControlStateSelected];
    [fstBtn1 setTitle:@"ON" forState:UIControlStateHighlighted];
    [fstBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [fstBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [fstBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    fstBtn1.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:15];
    [fstBtn1 addTarget:self action:@selector(on:) forControlEvents:UIControlEventTouchUpInside];
    [twoBtnView addSubview:fstBtn1];
    

    secndBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    secndBtn.frame = CGRectMake((320/2)+3, 2, (320/2)-3, (85.5/2)-4);
    secndBtn.backgroundColor = [UIColor clearColor];
    [secndBtn setTitle:@"OFF" forState:UIControlStateNormal];
    [secndBtn setTitle:@"OFF" forState:UIControlStateSelected];
    [secndBtn setTitle:@"OFF" forState:UIControlStateHighlighted];
    [secndBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [secndBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [secndBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    secndBtn.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:15];
    [secndBtn addTarget:self action:@selector(off:) forControlEvents:UIControlEventTouchUpInside];
    [twoBtnView addSubview:secndBtn];
    
    
    //bottom bar............
    
    UIView *UsBackView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 525.0f, 320, 85/2)];
    UsBackView9.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView9];
    
    //backbutton.........................
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 529.0f, 54/2, 33)];
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
    
    //save.........................
    
    Savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Savebtn setFrame:CGRectMake(270.0f, 529.0f, 22, 36)];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateNormal];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateHighlighted];
    [Savebtn addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Savebtn];
    
    // Do any additional setup after loading the view.
}

-(void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}

-(void)Save:(UIButton *)sender{
    
    
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

-(void)on:(UIButton *)sender{
    
    fstBtn1.backgroundColor = [UIColor colorWithRed:(171.0f/255.0f) green:(200.0f/255.0f) blue:(219.0f/255.0f) alpha:1];
    
    secndBtn.backgroundColor = [UIColor clearColor];
    
}

-(void)off:(UIButton *)sender{
    
    secndBtn.backgroundColor = [UIColor colorWithRed:(171.0f/255.0f) green:(200.0f/255.0f) blue:(219.0f/255.0f) alpha:1];
    
    fstBtn1.backgroundColor = [UIColor clearColor];
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
