//
//  MMSigninViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMSigninViewController.h"
#import "MMHomeViewController.h"

@interface MMSigninViewController ()

@end

@implementation MMSigninViewController

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
    
    NSLog(@"signinviewcontroller");
    
    MainView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,568)];
    MainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]];
    [self.view addSubview:MainView];
    
    //meter logo............
    
    UIImageView *Metermaid = [[UIImageView alloc]initWithFrame:CGRectMake(100.0f, 70.0f, 230/2, 38/2)];
    [Metermaid setImage:[UIImage imageNamed:@"metermaidicon"]];
    [MainView addSubview:Metermaid];
    
    //email field..................
    
    UIView *UsBackView1 = [[UIView alloc] initWithFrame:CGRectMake(34, 173, 252, 77/2)];
    UsBackView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textbox"]];
    [MainView addSubview:UsBackView1];
    
    Email = [[UITextField alloc] initWithFrame:CGRectMake(34, 173, 252, 77/2)];
    Email.backgroundColor = [UIColor clearColor];
    Email.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    Email.placeholder = @"Email";
    Email.keyboardType = UIKeyboardTypeEmailAddress;
   // Email.text=@"user@gmail.com";
    Email.textColor = [UIColor whiteColor];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [Email setLeftView:leftView1];
    [Email setLeftViewMode:UITextFieldViewModeAlways];
    [Email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [Email setValue:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17]  forKeyPath:@"_placeholderLabel.font"];
    [Email setDelegate:self];
    [MainView addSubview:Email];
    
    //password field............
    
    
    UIView *UsBackView2 = [[UIView alloc] initWithFrame:CGRectMake(34, 216, 252, 77/2)];
    UsBackView2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textbox"]];
    [MainView addSubview:UsBackView2];
    
    passcode = [[UITextField alloc] initWithFrame:CGRectMake(34, 216.0f, 252.0f, 77/2)];
    passcode.backgroundColor = [UIColor clearColor];
    passcode.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:17];
    passcode.placeholder = @"Passcode";
    //passcode.text=@"123456";
    passcode.textColor = [UIColor whiteColor];
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [passcode setLeftView:leftView2];
    [passcode setLeftViewMode:UITextFieldViewModeAlways];
    [passcode setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [passcode setValue:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17]  forKeyPath:@"_placeholderLabel.font"];
    [passcode setDelegate:self];
    [MainView addSubview:passcode];
    [passcode setSecureTextEntry:YES];
    
    //sign buutton............
    
    signinbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [signinbtn setFrame:CGRectMake(34.0, 280.0f, 252.0f, 40.0f)];
    [signinbtn setBackgroundColor:[UIColor whiteColor]];
    [signinbtn setTitle:@"Sign In" forState:UIControlStateNormal];
    [signinbtn setTitle:@"Sign In" forState:UIControlStateHighlighted];
    [signinbtn setTitleColor:[UIColor colorWithRed:(135.0f/255.0f) green:(173.0f/255.0f) blue:(199.0f/255.0f) alpha:1.0f] forState:UIControlStateNormal];
    signinbtn.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:20];
    [signinbtn addTarget:self action:@selector(signin:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:signinbtn];
    

    //backbutton.........................
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 520.0f, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Backbtn];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 524.0f, 52.0f, 38.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    
    // Do any additional setup after loading the view.
}
-(void)back:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:NO];
}

//textfield return function...............

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


//sign in function........................

-(void)signin:(UIButton *)sender{
    

    //
    [Email resignFirstResponder];
    [passcode resignFirstResponder];

    
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    if([Email.text length]<=0||[passcode.text length]<=0||[passcode.text rangeOfCharacterFromSet:whitespace].location != NSNotFound||[Email.text rangeOfCharacterFromSet:whitespace].location !=NSNotFound)
        
    {
        
        if([Email.text length]<=0){
            
            
            
            
            Email.text = @"";
            
            Email.placeholder = @"Please enter valid email";
            
            
            
            
            return;
            
        }
        
        if([passcode.text length]<=0)
            
        {
            
            passcode.text = @"";
            
            passcode.placeholder = @"Please enter your passcode";
            
            
            return;
            
            
            
        }
        if (![self NSStringIsValidEmail:Email.text]){
            
            
            
            Email.text = @"";
            
            Email.placeholder = @"Please enter valid email";
            
            return;
            
            
            
        }
        if([passcode.text rangeOfCharacterFromSet:whitespace].location != NSNotFound)
            
        {
            
            passcode.text = @"";
            
            passcode.placeholder = @"Please enter your passcode";
            
            
            return;
            
        }
        
        if([Email.text rangeOfCharacterFromSet:whitespace].location !=NSNotFound){
            
            
            
            Email.text = @"";
            
            Email.placeholder = @"Please enter valid email";
            
            
            return;
            
        }

        
    }
    
    else
        
    {
        
        @try {
            
            
            
            NSString *string=[[NSString alloc]init];
            string=[NSString stringWithFormat:@"%@/login.php?email=%@&password=%@",DOMAIN_APP_URL,Email.text,passcode.text];
            
            NSError *error;
            
            //   NSMutableArray  *fetchPassPath= [[NSMutableArray alloc] init];
            
            
            //NSString* urlTextEscaped = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            //NSURL *requestURL = [NSURL URLWithString: string];
            
            NSData *signeddataURL =  [NSData dataWithContentsOfURL:[NSURL URLWithString:string] options:NSDataReadingUncached error:&error];
            
            
            
            jsondict=[NSJSONSerialization JSONObjectWithData:signeddataURL  options:kNilOptions error:&error];
        
        NSLog(@"json..... :%@",jsondict);
        
            if ([[jsondict objectForKey:@"auth"] isEqualToString:@"success"])
            {
                
                
                NSDictionary *newdict = [jsondict objectForKey:@"userdetails"];
 
                login_Defaults = [NSUserDefaults standardUserDefaults];
                
                [login_Defaults setObject:[newdict objectForKey:@"firstname"] forKey:@"firstname"];
                [login_Defaults setObject:[newdict objectForKey:@"passcode"] forKey:@"passcode"];
                [login_Defaults setObject:[newdict objectForKey:@"id"] forKey:@"id"];
                [login_Defaults setObject:[newdict objectForKey:@"address"] forKey:@"address"];
                [login_Defaults setObject:[newdict objectForKey:@"email"] forKey:@"email"];
                [login_Defaults setObject:[newdict objectForKey:@"status"] forKey:@"status"];
                [login_Defaults setObject:[newdict objectForKey:@"lastname"] forKey:@"lastname"];
                [login_Defaults setObject:[newdict objectForKey:@"apartment_no"] forKey:@"apartment_no"];
                [login_Defaults setObject:[newdict objectForKey:@"lat"] forKey:@"latitude"];
                [login_Defaults setObject:[newdict objectForKey:@"long"] forKey:@"longitude"];
                [login_Defaults synchronize];


                [[NSUserDefaults standardUserDefaults]setObject:@"signin" forKey:@"fb"];
                
                
                MMHomeViewController *home = [[MMHomeViewController alloc]init];
                [self.navigationController pushViewController:home animated:NO];
                
            }else{
                
                
                UIAlertView  *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"email or password is not correct" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                alert.tag = 2;
                [alert show];
                
                
            }
            
        }
        @catch (NSException *exception) {
            
            
            NSLog(@"exception... :%@",exception);
        }
        @finally {
            
        }
    
    }

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
