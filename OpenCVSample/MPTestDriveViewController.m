//
//  MPTestDriveViewController.m
//  MyPower
//
//  Created by Admin on 08/09/14.
//  Copyright (c) 2014 esolz. All rights reserved.
//

#import "MPTestDriveViewController.h"
#import "MMSignupViewController.h"
#import "MMmapViewController.h"
#import "MMAppDelegate.h"
#import "MMSettingsViewController.h"
#import "MMReportViewController.h"
#import "MMSigninViewController.h"
#import "MMHomeViewController.h"
#import "MMusagebillViewController.h"
#import "MMUsageBudgetViewController.h"
@interface MPTestDriveViewController (){
    
    NSString *myString;
    UITextField *email;
    NSDictionary *result;
    NSString *profileimageURL;
}

@end

@implementation MPTestDriveViewController

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
    
    NSLog(@"Testdriveviewcontroller");
    
    // Do any additional setup after loading the view.
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];
    
    MainView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,568)];
    MainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]];
    [self.view addSubview:MainView];
    
    //usage button and label................
    
    
    
    UILabel *Usage = [[UILabel alloc] initWithFrame:CGRectMake(40, 120, 100,40)];
    Usage.text = @"USAGE";
    Usage.textColor = [UIColor whiteColor];
    Usage.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    [MainView addSubview:Usage];
    
    
    usagebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [usagebtn setFrame:CGRectMake(42.0f, 165.0f, 116/2, 84/2)];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usagebtn"] forState:UIControlStateNormal];
    [usagebtn setBackgroundImage:[UIImage imageNamed:@"usagebtn"] forState:UIControlStateHighlighted];
    [usagebtn addTarget:self action:@selector(usagebutton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:usagebtn];
    
    
    
    UIView *usageview = [[UIView alloc]initWithFrame:CGRectMake(40, 120, 100, 90)];
    [usageview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:usageview];
    
    
    UITapGestureRecognizer *usagetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(usagebutton:)];
    [usageview addGestureRecognizer:usagetap];
    usageview.userInteractionEnabled = YES;
    
    
    //report button and label................
    
    
    
    UILabel *Report = [[UILabel alloc] initWithFrame:CGRectMake(200, 120, 100,40)];
    Report.text = @"REPORT";
    Report.textColor = [UIColor whiteColor];
    Report.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    [MainView addSubview:Report];
    
    
    
    reportbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reportbtn setFrame:CGRectMake(220.0f, 165.0f, 73/2, 99/2)];
    [reportbtn setBackgroundImage:[UIImage imageNamed:@"reportbtn"] forState:UIControlStateNormal];
    [reportbtn setBackgroundImage:[UIImage imageNamed:@"reportbtn"] forState:UIControlStateHighlighted];
    [reportbtn addTarget:self action:@selector(reportbutton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:reportbtn];
    
    
    UIView *reportview = [[UIView alloc]initWithFrame:CGRectMake(200, 120, 100, 100)];
    [reportview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:reportview];
    
    
    
    UITapGestureRecognizer *reporttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(reportbutton:)];
    [reportview addGestureRecognizer:reporttap];
    reportview.userInteractionEnabled = YES;
    
    
    //Map button and label................
    
    
    
    UILabel *maplbl = [[UILabel alloc] initWithFrame:CGRectMake(52, 350, 300,40)];
    maplbl.text = @"MAP";
    maplbl.textColor = [UIColor whiteColor];
    maplbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    [MainView addSubview:maplbl];
    
    
    
    mapbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mapbtn setFrame:CGRectMake(45.0f, 295.0f, 92/2, 103/2)];
    [mapbtn setBackgroundImage:[UIImage imageNamed:@"Mapbtn"] forState:UIControlStateNormal];
    [mapbtn setBackgroundImage:[UIImage imageNamed:@"Mapbtn"] forState:UIControlStateHighlighted];
    [mapbtn addTarget:self action:@selector(mapbutton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:mapbtn];
    
    
    
    UIView *mapview = [[UIView alloc]initWithFrame:CGRectMake(52, 350, 100, 100)];
    [mapview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:mapview];
    
    
    UITapGestureRecognizer *maptap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(mapbutton:)];
    [mapview addGestureRecognizer:maptap];
    mapview.userInteractionEnabled = YES;
    
    
    //settings button and label................
    
    
    UILabel *settinglbl = [[UILabel alloc] initWithFrame:CGRectMake(200, 350, 100,40)];
    settinglbl.text = @"SETTINGS";
    settinglbl.textColor = [UIColor whiteColor];
    settinglbl.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17];
    [MainView addSubview:settinglbl];
    
    
    
    settingbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingbtn setFrame:CGRectMake(210.0f, 295.0f, 116/2, 118/2)];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settingsbtn"] forState:UIControlStateNormal];
    [settingbtn setBackgroundImage:[UIImage imageNamed:@"settingsbtn"] forState:UIControlStateHighlighted];
    [settingbtn addTarget:self action:@selector(settingbutton:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:settingbtn];
    
    
    
    UIView *settingsview = [[UIView alloc]initWithFrame:CGRectMake(200, 350, 100, 100)];
    [settingsview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:settingsview];
    
    
    
    UITapGestureRecognizer *settingstap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(settingbutton:)];
    [settingsview addGestureRecognizer:settingstap];
    settingsview.userInteractionEnabled = YES;
    
    //metermaid image..........
    
    UIImageView *Metermaid = [[UIImageView alloc]initWithFrame:CGRectMake(100.0f, 240.0f, 230/2, 38/2)];
    [Metermaid setImage:[UIImage imageNamed:@"metermaidicon"]];
    [MainView addSubview:Metermaid];
    
    
    //signin button............
    
    Signinbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Signinbtn setFrame:CGRectMake(10.0f, 470.0f, 180/2, 87/2)];
    [Signinbtn setBackgroundImage:[UIImage imageNamed:@"signinbtn"] forState:UIControlStateNormal];
    [Signinbtn setBackgroundImage:[UIImage imageNamed:@"signinbtn"] forState:UIControlStateHighlighted];
    [Signinbtn addTarget:self action:@selector(signin:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Signinbtn];
    
    
    //facebook button........
    
    
    facebookbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [facebookbtn setFrame:CGRectMake(135.0f, 470.0f, 98/2, 87/2)];
    [facebookbtn setBackgroundImage:[UIImage imageNamed:@"facebookbtn"] forState:UIControlStateNormal];
    [facebookbtn setBackgroundImage:[UIImage imageNamed:@"facebookbtn"] forState:UIControlStateHighlighted];
    [facebookbtn addTarget:self action:@selector(facebook:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:facebookbtn];
    
    //signup button............
    
    Signupbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Signupbtn setFrame:CGRectMake(220.0f, 470.0f, 180/2, 87/2)];
    [Signupbtn setBackgroundImage:[UIImage imageNamed:@"signupbtn"] forState:UIControlStateNormal];
    [Signupbtn setBackgroundImage:[UIImage imageNamed:@"signupbtn"] forState:UIControlStateHighlighted];
    [Signupbtn addTarget:self action:@selector(Signup:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Signupbtn];
    
    MMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
                // [self updateView];
                
                
            }];
        }
    }
    if (appDelegate.session.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [appDelegate.session closeAndClearTokenInformation];
        
        
    }
}



-(void)facebook:(UIButton *)sender{

    
    [[NSUserDefaults standardUserDefaults]setObject:@"facebook" forKey:@"fb"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    // get the app delegate so that we can access the session property
    MMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [appDelegate.session closeAndClearTokenInformation];
        
        
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self updateView];
        }];
    }
    
    
    
    
}
- (void)updateView{
    // get the app delegate, so that we can reference the session property
    MMAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        // valid account UI is shown whenever the session is open
        
  
        NSString *urlString;
        NSError *error = nil;
        urlString = [NSString stringWithFormat:@"https://graph.facebook.com/me?access_token=%@",
                     appDelegate.session.accessTokenData.accessToken];

        NSURL *requestURL = [NSURL URLWithString:urlString];
   
        NSData *signeddataURL1 =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
        
        result = [NSJSONSerialization JSONObjectWithData:signeddataURL1 options:kNilOptions error:&error];

        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@ %@",[result objectForKey:@"first_name"],[result objectForKey:@"last_name"]] forKey:@"name"];
        [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"id"] forKey:@"id"];
        [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"gender"] forKey:@"gender"];
        
        
        //For Profile Image
        
        NSString *urlString_img = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?width=200&height=200&redirect=false",[result objectForKey:@"id"]];
        
        NSURL *requestURL_img = [NSURL URLWithString:urlString_img];
        
        NSData *signeddataURL1_img =  [NSData dataWithContentsOfURL:requestURL_img options:NSDataReadingUncached error:&error];
        
        NSDictionary  *image_result = [NSJSONSerialization
                                       JSONObjectWithData:signeddataURL1_img //1
                                       
                                       options:kNilOptions
                                       error:&error];
        
        
        NSDictionary *picturedata = [image_result objectForKey:@"data"];
        profileimageURL = [picturedata objectForKey:@"url"];
        
        
        [[NSUserDefaults standardUserDefaults] setObject:profileimageURL forKey:@"imageurl"];

        
        
        NSString *str = [[NSString alloc]init];
        
        str = [NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myPower/check_email.php?mode=facebook&facebookid=%@",[result objectForKey:@"id"]];
        
        NSURL *checkurl = [NSURL URLWithString:str];
        
        
        NSData *checkdata =  [NSData dataWithContentsOfURL:checkurl options:NSDataReadingUncached error:&error];
        
        myString = [[NSString alloc] initWithData:checkdata encoding:NSASCIIStringEncoding];

        
        if ([myString isEqualToString:@"NO"]) {
            
            UIView *blackview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
            [blackview setBackgroundColor:[UIColor blackColor]];
            [blackview setAlpha:0.8f];
            [MainView addSubview:blackview];
            
            UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(20.0f, 200.0f, 280.0f, 100.0f)];
            [backview setBackgroundColor:[UIColor whiteColor]];
            backview.layer.cornerRadius = 5.0f;
            [MainView addSubview:backview];
            
            
            
            UIView *UsBackView = [[UIView alloc] initWithFrame:CGRectMake(40, 20, 200, 54/2)];
            UsBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"usernameFld"]];
            [backview addSubview:UsBackView];
            
            email = [[UITextField alloc] initWithFrame:CGRectMake(40, 20, 200, 54/2)];
            email.backgroundColor = [UIColor clearColor];
            email.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
            email.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
            [email setPlaceholder:@"Email"];
            email.textAlignment = NSTextAlignmentCenter;
            email.textColor = [UIColor colorWithRed:(17.0f/255.0f) green:(150.0f/255.0f) blue:(207.0f/255.0f) alpha:1];
            [email setValue:[UIColor colorWithRed:(17.0f/255.0f) green:(150.0f/255.0f) blue:(207.0f/255.0f) alpha:1] forKeyPath:@"_placeholderLabel.textColor"];
            [email setValue:[UIFont fontWithName:GLOBALTEXTFONT size:15]  forKeyPath:@"_placeholderLabel.font"];
            [email setDelegate:self];
            email.layer.borderWidth = 1.0f;
            email.layer.borderColor = [[UIColor colorWithRed:(17.0f/255.0f) green:(150.0f/255.0f) blue:(207.0f/255.0f) alpha:1]CGColor];
            email.keyboardType = UIKeyboardTypeEmailAddress;
            [backview addSubview:email];
            
            
            UIButton *submit= [UIButton buttonWithType:UIButtonTypeCustom];
            submit.frame = CGRectMake(40, 55, 200, 54/2);
            submit.backgroundColor = [UIColor colorWithRed:(17.0f/255.0f) green:(150.0f/255.0f) blue:(207.0f/255.0f) alpha:1];
            [submit setTitle:@"Submit" forState:UIControlStateNormal];
            [submit setTitle:@"Submit"forState:UIControlStateSelected];
            [submit setTitle:@"Submit" forState:UIControlStateHighlighted];
            [submit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            submit.titleLabel.font =[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:13];
            submit.titleLabel.textAlignment = NSTextAlignmentCenter;
            [submit addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
            [backview addSubview:submit];
            
            
            
        }
        else{
            
            NSArray *array = [myString componentsSeparatedByString:@"#"];
            
            NSString *emailstr = [array objectAtIndex:3];
            
            
            NSString *urlString_inseted;
            
            urlString_inseted = [NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myPower/social_login.php?mode=facebook&name=%@&email=%@&facebookid=%@&picurl=%@",[NSString stringWithFormat:@"%@ %@",[result objectForKey:@"first_name"],[result objectForKey:@"last_name"]],emailstr,[result objectForKey:@"id"],profileimageURL];
            
            
            NSString* urlTextEscaped = [urlString_inseted stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

            NSURL *requestURL_inseted = [NSURL URLWithString:urlTextEscaped];
            
            
            NSData *signeddataURL_inseted =  [NSData dataWithContentsOfURL:requestURL_inseted options:NSDataReadingUncached error:&error];
            
            NSMutableDictionary *result_inseted = [NSJSONSerialization JSONObjectWithData:signeddataURL_inseted options:kNilOptions error:&error];
            NSMutableArray *data_retrived = [[NSMutableArray alloc]init];
            
            for(NSMutableDictionary *dict in result_inseted)
            {
                [data_retrived addObject:dict];
                
            }
            
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"id"] forKey:@"id"];
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"firstname"] forKey:@"firstname"];
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"lastname"] forKey:@"lastname"];
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"email"] forKey:@"email"];
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"passcode"] forKey:@"passcode"];
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"address"] forKey:@"address"];
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"city"] forKey:@"city"];
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"state"] forKey:@"state"];
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"country"] forKey:@"country"];
            [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"pincode"] forKey:@"pincode"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            MMHomeViewController *fb = [[MMHomeViewController alloc]init];
            [self.navigationController pushViewController:fb animated:NO];
        }
    } else {
        
       
        
    }
}

//settings function........
-(void)settingbutton:(UIButton *)sender{
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"id"] isKindOfClass:[NSNull class]] || [[NSUserDefaults standardUserDefaults]objectForKey:@"id"] ==(id)[NSNull null] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]length] == 0) {
        
        MMSigninViewController *set = [[MMSigninViewController alloc]init];
        [self.navigationController pushViewController:set animated:NO];
    }
    else{
        
        MMSettingsViewController *set = [[MMSettingsViewController alloc]init];
        [self.navigationController pushViewController:set animated:NO];
    }
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
//report function............

-(void)reportbutton:(UIButton *)sender{
    
  
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"id"] isKindOfClass:[NSNull class]] || [[NSUserDefaults standardUserDefaults]objectForKey:@"id"] ==(id)[NSNull null] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]length] == 0) {
        
        MMSigninViewController *set = [[MMSigninViewController alloc]init];
        [self.navigationController pushViewController:set animated:NO];
    }
    else{
        
        MMReportViewController *set = [[MMReportViewController alloc]init];
        [self.navigationController pushViewController:set animated:NO];
    }
    
}

//usage function...........

-(void)usagebutton:(UIButton *)sender{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"id"] isKindOfClass:[NSNull class]] || [[NSUserDefaults standardUserDefaults]objectForKey:@"id"] ==(id)[NSNull null] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]length] == 0) {
        
        MMSigninViewController *set = [[MMSigninViewController alloc]init];
        [self.navigationController pushViewController:set animated:NO];
    }
    else{
        
        MMUsageBudgetViewController *set = [[MMUsageBudgetViewController alloc]init];
        [self.navigationController pushViewController:set animated:NO];
    }
}

//signin function......

-(void)signin:(UIButton *)sender{
    
    MMSigninViewController *set = [[MMSigninViewController alloc]init];
    [self.navigationController pushViewController:set animated:NO];
    
}
//signup function....

-(void)Signup:(UIButton *)sender{
    
    MMSignupViewController *signup = [[MMSignupViewController alloc]init];
    [self.navigationController pushViewController:signup animated:NO];
    
}

//map function...........

-(void)mapbutton:(UIButton *)sender{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"id"] isKindOfClass:[NSNull class]] || [[NSUserDefaults standardUserDefaults]objectForKey:@"id"] ==(id)[NSNull null] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"id"]length] == 0) {
        
        MMSigninViewController *set = [[MMSigninViewController alloc]init];
        [self.navigationController pushViewController:set animated:NO];
    }
    else{
        
        MMmapViewController *set = [[MMmapViewController alloc]init];
        [self.navigationController pushViewController:set animated:NO];
    }
    
    
    
}

-(void)submit{
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    if ([email.text isEqualToString:@""]) {
        
        email.text = @"";
        
        email.placeholder = @"Please enter valid email";
        
        
        return;
    }
    else if([email.text rangeOfCharacterFromSet:whitespace].location !=NSNotFound){
        
        
        
        email.text = @"";
        
        email.placeholder = @"Please enter valid email";
        
        
        return;
    }
    else{
        NSString *urlString_inseted;
        
        urlString_inseted = [NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myPower/social_login.php?mode=facebook&name=%@&email=%@&facebookid=%@&picurl=%@",[NSString stringWithFormat:@"%@ %@",[result objectForKey:@"first_name"],[result objectForKey:@"last_name"]],email.text,[result objectForKey:@"id"],profileimageURL];
        
        
        NSString* urlTextEscaped = [urlString_inseted stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        NSURL *requestURL_inseted = [NSURL URLWithString:urlTextEscaped];
        
        NSError *error;
        
        NSData *signeddataURL_inseted =  [NSData dataWithContentsOfURL:requestURL_inseted options:NSDataReadingUncached error:&error];
        
        NSMutableDictionary *result_inseted = [NSJSONSerialization JSONObjectWithData:signeddataURL_inseted options:kNilOptions error:&error];
        NSMutableArray *data_retrived = [[NSMutableArray alloc]init];
        
        for(NSMutableDictionary *dict in result_inseted)
        {
            [data_retrived addObject:dict];
            
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"id"] forKey:@"id"];
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"firstname"] forKey:@"firstname"];
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"lastname"] forKey:@"lastname"];
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"email"] forKey:@"email"];
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"passcode"] forKey:@"passcode"];
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"address"] forKey:@"address"];
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"city"] forKey:@"city"];
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"state"] forKey:@"state"];
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"country"] forKey:@"country"];
        [[NSUserDefaults standardUserDefaults] setObject:[[data_retrived objectAtIndex:0]objectForKey:@"pincode"] forKey:@"pincode"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        MMHomeViewController *fb = [[MMHomeViewController alloc]init];
        [self.navigationController pushViewController:fb animated:NO];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
