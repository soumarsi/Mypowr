//
//  MMPaymentViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 06/10/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMPaymentViewController.h"
#define kOFFSET_FOR_KEYBOARD 130.0

@interface MMPaymentViewController ()

@end

@implementation MMPaymentViewController

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
    
    NSLog(@"MMPaymentViewController");
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];
    
    
    //backgroundView...................
    
    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [self.view addSubview:MainView];
    
    //scrollview................
    MainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 90.0f, 320.0f, 438.0f)];
    MainScroll.userInteractionEnabled=YES;
    MainScroll.scrollEnabled=YES;
    [MainScroll setBackgroundColor:[UIColor clearColor]];
    MainScroll.showsVerticalScrollIndicator=YES;
    MainScroll.contentSize=CGSizeMake(300.0f, 490.0f);
    [MainView addSubview:MainScroll];
    
    
    
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
    
    
    //header portion..........
    
    paymentimg = [[UIImageView alloc]initWithFrame:CGRectMake(60.0f, 30.0f, 53/2, 38/2)];
    [paymentimg setImage:[UIImage imageNamed:@"paymentimage"]];
    [MainView addSubview:paymentimg];
    
    
    HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(100.0f, 20.0f,200.0f, 40.0f)];
    [HeaderLbl setBackgroundColor:[UIColor clearColor]];
    [HeaderLbl setText:@"Payment Method"];
    [HeaderLbl setTextAlignment:NSTextAlignmentLeft];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:22.0f]];
    [MainView addSubview:HeaderLbl];
    
    lockimg = [[UIImageView alloc]initWithFrame:CGRectMake(25.0f, 70.0f, 26/2, 31/2)];
    [lockimg setImage:[UIImage imageNamed:@"lockimg"]];
    [MainView addSubview:lockimg];
    
    
    HeaderTextlbl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 70.0f,260.0f, 16.0f)];
    [HeaderTextlbl setBackgroundColor:[UIColor clearColor]];
    [HeaderTextlbl setText:@"A secure connection is used to send your information"];
    [HeaderTextlbl setTextAlignment:NSTextAlignmentLeft];
    [HeaderTextlbl setTextColor:[UIColor whiteColor]];
    [HeaderTextlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:10.0f]];
    [MainView addSubview:HeaderTextlbl];
    
    
    //Scan card field.............
    
    UIImageView *textfieldview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 100-90, 320, 42.5)];
    textfieldview.image=[UIImage imageNamed:@"textfieldimg1"];
    [MainScroll addSubview:textfieldview];
    
//    UITapGestureRecognizer *alerttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alerttap:)];
//    [textfieldview addGestureRecognizer:alerttap];
//    textfieldview.userInteractionEnabled = YES;
    
    UIImageView *scancardimgview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 83/2, 44/2)];
    scancardimgview.image=[UIImage imageNamed:@"scancardimg"];
    [textfieldview addSubview:scancardimgview];
    
    
    UILabel *Scancardlbl = [[UILabel alloc]initWithFrame:CGRectMake(60, 11, 260, 22)];
    [Scancardlbl setBackgroundColor:[UIColor clearColor]];
    [Scancardlbl setText:@"Scan Your Card"];
    [Scancardlbl setTextAlignment:NSTextAlignmentLeft];
    [Scancardlbl setTextColor:[UIColor whiteColor]];
    [Scancardlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [textfieldview addSubview:Scancardlbl];
    
    /////====================///////=================
    
    //payment info label.......
    
    UILabel *Paymentinfolbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 150-90, 310, 22)];
    [Paymentinfolbl setBackgroundColor:[UIColor clearColor]];
    [Paymentinfolbl setText:@"Payment Info"];
    [Paymentinfolbl setTextAlignment:NSTextAlignmentLeft];
    [Paymentinfolbl setTextColor:[UIColor whiteColor]];
    [Paymentinfolbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18]];
    [MainScroll addSubview:Paymentinfolbl];
    
    //Fullname textfileld...................
    
    UIView *UsBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 185-90, 320, 85/2)];
    UsBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fullnametxtfiled"]];
    [MainScroll addSubview:UsBackView];
    
    FullName = [[UITextField alloc] initWithFrame:CGRectMake(0, 185-90, 160.0f, 85/2)];
    FullName.backgroundColor = [UIColor clearColor];
    FullName.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    FullName.placeholder = @"First Name";
    FullName.text=@"";
    FullName.textColor = [UIColor whiteColor];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [FullName setLeftView:leftView3];
    [FullName setLeftViewMode:UITextFieldViewModeAlways];
    [FullName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [FullName setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [FullName setDelegate:self];
    [MainScroll addSubview:FullName];
    
    
    lastname = [[UITextField alloc] initWithFrame:CGRectMake(160, 185-90, 160.0f, 85/2)];
    lastname.backgroundColor = [UIColor clearColor];
    lastname.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:15];
    lastname.placeholder = @"Last";
    lastname.text=@"";
    lastname.font = [UIFont systemFontOfSize:17.0f];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [lastname setLeftView:leftView];
    [lastname setLeftViewMode:UITextFieldViewModeAlways];
    lastname.textColor = [UIColor whiteColor];
    [lastname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [lastname setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [lastname setDelegate:self];
    [MainScroll addSubview:lastname];
    
    //cardnumber field............
    
    
    UIView *UsBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 228-90, 320, 85/2)];
    UsBackView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView1];
    
    cardnumber = [[UITextField alloc] initWithFrame:CGRectMake(0, 228-90, 320.0f, 85/2)];
    cardnumber.backgroundColor = [UIColor clearColor];
    cardnumber.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    cardnumber.placeholder = @"Card Number";
    cardnumber.text=@"";
    cardnumber.textColor = [UIColor whiteColor];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [cardnumber setLeftView:leftView1];
    [cardnumber setLeftViewMode:UITextFieldViewModeAlways];
    [cardnumber setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [cardnumber setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [cardnumber setDelegate:self];
    [MainScroll addSubview:cardnumber];
    
    
    //expiredate and cvv textfileld...................
    
    UIView *UsBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 271-90, 320, 85/2)];
    UsBackView2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fullnametxtfiled"]];
    [MainScroll addSubview:UsBackView2];
    
    expiratindate = [[UITextField alloc] initWithFrame:CGRectMake(0, 271-90, 160.0f, 85/2)];
    expiratindate.backgroundColor = [UIColor clearColor];
    expiratindate.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    expiratindate.placeholder = @"Expiration Date";
    expiratindate.text=@"";
    expiratindate.textColor = [UIColor whiteColor];
    UIView *leftView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [expiratindate setLeftView:leftView4];
    [expiratindate setLeftViewMode:UITextFieldViewModeAlways];
    [expiratindate setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [expiratindate setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [expiratindate setDelegate:self];
    [MainScroll addSubview:expiratindate];
    
    
    cvv = [[UITextField alloc] initWithFrame:CGRectMake(160, 271-90, 160.0f, 85/2)];
    cvv.backgroundColor = [UIColor clearColor];
    cvv.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:15];
    cvv.placeholder = @"CVV";
    cvv.text=@"";
    cvv.font = [UIFont systemFontOfSize:17.0f];
    UIView *leftView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [cvv setLeftView:leftView5];
    [cvv setLeftViewMode:UITextFieldViewModeAlways];
    cvv.textColor = [UIColor whiteColor];
    [cvv setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [cvv setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [cvv setDelegate:self];
    [MainScroll addSubview:cvv];
    
    
    ///===============/////////=============
    
    
    
    //billing address label.......
    
    UILabel *billinglbl = [[UILabel alloc]initWithFrame:CGRectMake(10, 320-90, 310, 22)];
    [billinglbl setBackgroundColor:[UIColor clearColor]];
    [billinglbl setText:@"Billing Address"];
    [billinglbl setTextAlignment:NSTextAlignmentLeft];
    [billinglbl setTextColor:[UIColor whiteColor]];
    [billinglbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18.0f]];
    [MainScroll addSubview:billinglbl];
    
    
    //address field............
    
    
    UIView *UsBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 350-90, 320, 85/2)];
    UsBackView3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView3];
    
    address = [[UITextField alloc] initWithFrame:CGRectMake(0, 350-90, 320.0f, 85/2)];
    address.backgroundColor = [UIColor clearColor];
    address.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    address.placeholder = @"Address";
    address.text=@"";
    address.textColor = [UIColor whiteColor];
    UIView *leftView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [address setLeftView:leftView6];
    [address setLeftViewMode:UITextFieldViewModeAlways];
    [address setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [address setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [address setDelegate:self];
    [MainScroll addSubview:address];
    
    
    //city field............
    
    
    UIView *UsBackView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 393-90, 320, 85/2)];
    UsBackView4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView4];
    
    city = [[UITextField alloc] initWithFrame:CGRectMake(0, 393-90, 320.0f, 85/2)];
    city.backgroundColor = [UIColor clearColor];
    city.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    city.font = [UIFont boldSystemFontOfSize:17.0f];
    city.placeholder = @"City";
    city.text=@"";
    city.textColor = [UIColor whiteColor];
    UIView *leftView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [city setLeftView:leftView7];
    [city setLeftViewMode:UITextFieldViewModeAlways];
    [city setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [city setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [city setDelegate:self];
    [MainScroll addSubview:city];
    
    //state field............
    
    
    UIView *UsBackView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 436-90, 320, 85/2)];
    UsBackView5.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView5];
    
    state = [[UITextField alloc] initWithFrame:CGRectMake(0, 436-90, 320.0f, 85/2)];
    state.backgroundColor = [UIColor clearColor];
    state.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    state.font = [UIFont boldSystemFontOfSize:17.0f];
    state.placeholder = @"State";
    state.text=@"";
    state.textColor = [UIColor whiteColor];
    UIView *leftView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [state setLeftView:leftView8];
    [state setLeftViewMode:UITextFieldViewModeAlways];
    [state setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [state setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [state setDelegate:self];
    [MainScroll addSubview:state];
    
    //zipcode field............
    
    
    UIView *UsBackView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 479-90, 320, 85/2)];
    UsBackView6.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView6];
    
    zipcode = [[UITextField alloc] initWithFrame:CGRectMake(0, 479-90, 320.0f, 85/2)];
    zipcode.backgroundColor = [UIColor clearColor];
    zipcode.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    zipcode.placeholder = @"Zipcode";
    zipcode.text=@"";
    zipcode.textColor = [UIColor whiteColor];
    UIView *leftView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [zipcode setLeftView:leftView9];
    [zipcode setLeftViewMode:UITextFieldViewModeAlways];
    [zipcode setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [zipcode setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [zipcode setDelegate:self];
    [MainScroll addSubview:zipcode];
    
    //country field............
    
    
    UIView *UsBackView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 522-90, 320, 85/2)];
    UsBackView7.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView7];
    
    country = [[UITextField alloc] initWithFrame:CGRectMake(0, 522-90, 320.0f, 85/2)];
    country.backgroundColor = [UIColor clearColor];
    country.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    country.placeholder = @"Country";
    country.text=@"";
    country.textColor = [UIColor whiteColor];
    UIView *leftView10 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [country setLeftView:leftView10];
    [country setLeftViewMode:UITextFieldViewModeAlways];
    [country setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [country setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [country setDelegate:self];
    [MainScroll addSubview:country];
    
    //bottom bar............
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 529, 320, 85/2)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];
    
    
    //backbutton.........................
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 532, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Backbtn];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 529, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    //save.........................
    
    Savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Savebtn setFrame:CGRectMake(270.0f, 530, 22, 36)];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateNormal];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateHighlighted];
    [Savebtn addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Savebtn];

    
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

///===========back button function/......

-(void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:NO];
    
}
//textfield return function...............

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
        
    }
    else
    {
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    
    MainView.frame = rect;
    
    [UIView commitAnimations];
    
}


//save button function...........

-(void)Save:(UIButton *)sender{
    
    
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
