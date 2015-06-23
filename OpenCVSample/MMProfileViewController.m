//
//  MMProfileViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 13/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 90.0
#import "MMProfileViewController.h"
#import "MMSettingsViewController.h"
#import "MMAddressmapViewController.h"

@interface MMProfileViewController (){
    
    CGSize myStringSize;
    NSOperationQueue *downloadqueue;
    NSString *longgo;
    NSString *latgo;
    NSDictionary *location;
    NSString *addressstr;
}

@end

@implementation MMProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
    addressstr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"address"]];
    if (_addresscoming.length == 0  && [_checking isEqualToString:@"map"]) {
        
        address.text=[NSString stringWithFormat:@"%@",_defaultaddress];
    }
    else if(_addresscoming.length > 0  && ![_checking isEqualToString:@"map"])
    {
        address.text = [NSString stringWithFormat:@"%@",_addresscoming];
    }
    else
    {
        address.text=[NSString stringWithFormat:@"%@",addressstr];
    }
    
    downloadqueue=[[NSOperationQueue alloc]init];
    
    [downloadqueue addOperationWithBlock:^{
        
        NSString *url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@",address.text];
        
        NSLog(@" url issssss  %@",url);
        
        NSString* urlTextEscaped = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"urlTextEscaped--%@",urlTextEscaped);
        
        
        
        NSError *error1 = nil;
        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlTextEscaped] options:NSDataReadingUncached error:&error1];
        
        // NSLog(@"data isssss%@",data1);
        
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            NSDictionary  *mapdict=[[NSDictionary alloc]init];
            
            NSError *parseError = nil;
            
            if(!error1)
                
                
                mapdict=[NSJSONSerialization JSONObjectWithData:data1 options:kNilOptions error:&parseError];
            
            //  NSLog(@"mapdict is %@",mapdict);
            NSMutableArray *maparray=[[NSMutableArray alloc]init];
            maparray=[mapdict objectForKey:@"results"];
            
            // NSLog(@"mappparray is %@",maparray);
            NSDictionary *geometry=[[NSDictionary alloc]init];
            geometry=[[maparray objectAtIndex:0]objectForKey:@"geometry"];
            // NSLog(@"geometry is %@",geometry);
            
            
            location=[[NSDictionary alloc]init];
            location=[geometry objectForKey:@"location"];
            NSLog(@"locationdict is %@",location);
            
            longgo=[location objectForKey:@"lng"];
            latgo=[location objectForKey:@"lat"];
            
            NSLog(@"longgo isss %@",longgo);
            NSLog(@"latgo isss %@",latgo);
            
            
            
        }];
    }];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"MMProfileViewController");
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];

    
    //backgroundView...................
    
    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [self.view addSubview:MainView];
    
    //scrollview................
    MainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 568.0f)];
    MainScroll.userInteractionEnabled=YES;
    //MainScroll.scrollEnabled=YES;
    //MainScroll.showsVerticalScrollIndicator=YES;
    //MainScroll.contentSize=CGSizeMake(300.0f, 601.0f);
    [MainView addSubview:MainScroll];
    

    
    //menu button............
    
    Menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Menubtn setFrame:CGRectMake(0.0f, 30.0f, 66/2,40/2)];
    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateNormal];
    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateHighlighted];
    [Menubtn addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
    [MainScroll addSubview:Menubtn];
    
    
    UIView *menuview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, 43.0f, 40.0f)];
    [menuview setBackgroundColor:[UIColor clearColor]];
    [MainScroll addSubview:menuview];
    
    UITapGestureRecognizer *menutap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(menu:)];
    [menuview addGestureRecognizer:menutap];
    menuview.userInteractionEnabled = YES;
    //HeaderLabel.......................
    
    HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(85.0f, 20.0f,150.0f, 40.0f)];
    [HeaderLbl setBackgroundColor:[UIColor clearColor]];
    [HeaderLbl setText:@"PROFILE"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [MainScroll addSubview:HeaderLbl];
    
    
    
    //Fullname textfileld...................
    
    UIView *UsBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, 320, 85/2)];
    UsBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fullnametxtfiled"]];
    [MainScroll addSubview:UsBackView];
    
    NSString *fullnamestr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"firstname"]];
    
    FullName = [[UITextField alloc] initWithFrame:CGRectMake(0, 100.0f, 160.0f, 85/2)];
    FullName.backgroundColor = [UIColor clearColor];
    FullName.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    FullName.placeholder = @"First Name";
    FullName.text=[NSString stringWithFormat:@"%@",fullnamestr];
    FullName.textColor = [UIColor whiteColor];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [FullName setLeftView:leftView3];
    [FullName setLeftViewMode:UITextFieldViewModeAlways];
    FullName.autocorrectionType = UITextAutocorrectionTypeNo;
    [FullName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [FullName setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [FullName setDelegate:self];
    [MainScroll addSubview:FullName];
    
    NSString *lastnamestr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"lastname"]];
    
    lastname = [[UITextField alloc] initWithFrame:CGRectMake(160, 100.0f, 160.0f, 85/2)];
    lastname.backgroundColor = [UIColor clearColor];
    lastname.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
    lastname.placeholder = @"Last";
    lastname.text=[NSString stringWithFormat:@"%@",lastnamestr];
    lastname.font = [UIFont boldSystemFontOfSize:17.0f];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [lastname setLeftView:leftView];
    [lastname setLeftViewMode:UITextFieldViewModeAlways];
    lastname.textColor = [UIColor whiteColor];
    lastname.autocorrectionType = UITextAutocorrectionTypeNo;
    [lastname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [lastname setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [lastname setDelegate:self];
    [MainScroll addSubview:lastname];
    
    //email field............
    
    
    NSString *emailstr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"email"]];
    
    UIView *UsBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 143, 320, 85/2)];
    UsBackView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView1];
    
    Email = [[UITextField alloc] initWithFrame:CGRectMake(0, 143.0f, 320.0f, 85/2)];
    Email.backgroundColor = [UIColor clearColor];
    Email.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    Email.placeholder = @"Email";
    Email.text=[NSString stringWithFormat:@"%@",emailstr];
    Email.textColor = [UIColor whiteColor];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [Email setLeftView:leftView1];
    Email.autocorrectionType = UITextAutocorrectionTypeNo;
    [Email setLeftViewMode:UITextFieldViewModeAlways];
    [Email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [Email setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [Email setDelegate:self];
    [MainScroll addSubview:Email];
    
    //password field............
    
    NSString *passwordstr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"passcode"]];
    
    UIView *UsBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 186, 320, 85/2)];
    UsBackView2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView2];
    
    password = [[UITextField alloc] initWithFrame:CGRectMake(0, 186.0f, 320.0f, 85/2)];
    password.backgroundColor = [UIColor clearColor];
    password.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    password.placeholder = @"Password";
    password.text=[NSString stringWithFormat:@"%@",passwordstr];
    password.textColor = [UIColor whiteColor];
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [password setLeftView:leftView2];
    password.autocorrectionType = UITextAutocorrectionTypeNo;
    [password setLeftViewMode:UITextFieldViewModeAlways];
    [password setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [password setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [password setDelegate:self];
    [MainScroll addSubview:password];
    [password setSecureTextEntry:YES];
    
    //appartment no field............
    
     NSString *apartmentnostr = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"apartment_no"]];
    
    UIView *UsBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 229, 320, 85/2)];
    UsBackView3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView3];
    
    appartmentno = [[UITextField alloc] initWithFrame:CGRectMake(0, 229.0f, 320.0f, 85/2)];
    appartmentno.backgroundColor = [UIColor clearColor];
    appartmentno.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    appartmentno.placeholder = @"Appartment no";
    appartmentno.text=[NSString stringWithFormat:@"%@",apartmentnostr];
    appartmentno.textColor = [UIColor whiteColor];
    UIView *leftView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [appartmentno setLeftView:leftView4];
    appartmentno.autocorrectionType = UITextAutocorrectionTypeNo;
    [appartmentno setLeftViewMode:UITextFieldViewModeAlways];
    [appartmentno setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [appartmentno setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]  forKeyPath:@"_placeholderLabel.font"];
    [appartmentno setDelegate:self];
    [MainScroll addSubview:appartmentno];
    
    
    //address field............
    
    
    
    UIView *UsBackView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 272, 320, 85/2)];
    UsBackView4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView4];
    
    
    
    
    CGSize maximumSize = CGSizeMake(300, 9999);
    
    
    UIFont *myFont = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    
    
    
    
    myStringSize = [addressstr sizeWithFont:myFont  constrainedToSize:maximumSize lineBreakMode:NSLineBreakByWordWrapping];

    
    
    address = [[UITextField alloc] initWithFrame:CGRectMake(0, 272, 280, myStringSize.height+20)];
    address.backgroundColor = [UIColor clearColor];
    address.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    address.placeholder = @"Address";
    address.userInteractionEnabled = NO;
    address.textColor = [UIColor whiteColor];
    [address setLeftViewMode:UITextFieldViewModeAlways];
    [address setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [address setValue:[UIFont fontWithName:GLOBALTEXTFONT size:17]  forKeyPath:@"_placeholderLabel.font"];
    [address setDelegate:self];
    [MainScroll addSubview:address];
    
   
    

    

    UIButton *locationchange = [UIButton buttonWithType:UIButtonTypeCustom];
    [locationchange setFrame:CGRectMake(284, 272, 35, 35)];
    [locationchange setBackgroundImage:[UIImage imageNamed:@"locationimage"] forState:UIControlStateNormal];
    [locationchange addTarget:self action:@selector(addresstap:) forControlEvents:UIControlEventTouchUpInside];
    [MainScroll addSubview:locationchange];
    
    //bottom bar............
    
    UIView *UsBackView9 = [[UIView alloc] initWithFrame:CGRectMake(0, 525.0f, 320, 85/2)];
    UsBackView9.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView9];
    
    
    //backbutton.........................
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 530.0f, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainScroll addSubview:Backbtn];
    
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 526.0f, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainScroll addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    
    //save.........................
    
    Savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Savebtn setFrame:CGRectMake(270.0f, 528.0f, 22, 36)];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateNormal];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateHighlighted];
    [Savebtn addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    [MainScroll addSubview:Savebtn];
    
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
    
    MMSettingsViewController *settng = [[MMSettingsViewController alloc]init];
    [self.navigationController pushViewController:settng animated:NO];
    
}
//textfield return function...............

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


-(void)Save:(UIButton *)sender{
    
    if ([FullName.text isEqualToString:@""]) {
        
        FullName.text = @"";
        FullName.placeholder = @"Please enter your first Name";
        return;
    }
    else if ([FullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1){
        
        
        FullName.text = @"";
        FullName.placeholder = @"Please enter your first name";
        return;
    }
   else if ([lastname.text isEqualToString:@""]) {
        
        lastname.text = @"";
        lastname.placeholder = @"Please enter your last name";
        return;
    }
    else if ([lastname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1){
        
        lastname.text = @"";
        lastname.placeholder = @"Please enter your last name";
        return;
    }
    else if ([Email.text isEqualToString:@""]) {
        
        Email.text = @"";
        Email.placeholder = @"Please enter your email";
        return;
    }
    else if ([Email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1){
        
        
        Email.text = @"";
        Email.placeholder = @"Please enter your email";
        return;
    }
    else if (![self NSStringIsValidEmail:Email.text]){
        
        Email.text = @"";
        Email.placeholder = @"Please enter your email";
        return;
        
    }
    else if ([password.text isEqualToString:@""]) {
        
        password.text = @"";
        password.placeholder = @"Please enter your password";
        return;
    }
    else if ([password.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1){
        
        password.text = @"";
        password.placeholder = @"Please enter your password";
        return;
    }
    else if ([password.text length] <6){
    
        password.text = @"";
        password.placeholder = @"Minimum 6 character required";
        return;
        
    }
   else if ([address.text isEqualToString:@""]) {
        
        address.text = @"";
        address.placeholder = @"Please enter your address";
        return;
    }
    else if ([address.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length < 1){
        
        
        address.text = @"";
        address.placeholder = @"Please enter your address";
        return;
    }


    else{
        
        NSString *string=[[NSString alloc]init];
        string=[NSString stringWithFormat:@"%@/update_profile.php?id=%@&firstname=%@&lastname=%@&email=%@&passcode=%@&address=%@&apartment_no=%@&lat=%@&long=%@",DOMAIN_APP_URL,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],FullName.text,lastname.text,Email.text,password.text,address.text,appartmentno.text,latgo,longgo];
        
        
        NSError *error=nil;
        
        NSMutableArray  *fetchPassPath= [[NSMutableArray alloc] init];
        
        NSString* urlTextEscaped = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *requestURL = [NSURL URLWithString: urlTextEscaped];
        
        NSData *signeddataURL =  [NSData dataWithContentsOfURL:requestURL options:NSDataReadingUncached error:&error];
        
        NSMutableDictionary *result_new = [NSJSONSerialization  JSONObjectWithData:signeddataURL options:kNilOptions error:&error];
        
        for(NSMutableDictionary *dict in result_new)
        {
            [fetchPassPath addObject:dict];
            
        }
        if(error)
        {
            return ;
            
        }
        else
        {
            json=[NSJSONSerialization JSONObjectWithData:signeddataURL  options:kNilOptions  error:&error];
            
            NSLog(@"json.... :%@",json);
            
            if ([[json objectForKey:@"auth"] isEqualToString:@"success"])
            {
                NSDictionary *newdict = [json objectForKey:@"userdetails"];

                login_Defaults = [NSUserDefaults standardUserDefaults];
                
                [login_Defaults setObject:[newdict objectForKey:@"firstname"] forKey:@"firstname"];
                [login_Defaults setObject:[newdict objectForKey:@"passcode"] forKey:@"passcode"];
                [login_Defaults setObject:[newdict objectForKey:@"id"] forKey:@"id"];
                [login_Defaults setObject:[newdict objectForKey:@"address"] forKey:@"address"];
                [login_Defaults setObject:[newdict objectForKey:@"email"] forKey:@"email"];
                [login_Defaults setObject:[newdict objectForKey:@"lastname"] forKey:@"lastname"];
                [login_Defaults setObject:[newdict objectForKey:@"apartment_no"] forKey:@"apartment_no"];
                [login_Defaults setObject:[newdict objectForKey:@"lat"] forKey:@"latitude"];
                [login_Defaults setObject:[newdict objectForKey:@"long"] forKey:@"longitude"];
                
                [login_Defaults synchronize];

   
               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Thank you" message:@"Update Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
                

                
            }
            else if ([[json objectForKey:@"auth"] isEqualToString:@"duplicate"])
            {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Email already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

                [alert show];
                
                
            }
            
            else {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Update failed" message:@"Please try again"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];

                [alert show];
                
                
            }
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

-(void)addresstap:(UIButton *)sender{
    MMAddressmapViewController *map=[[MMAddressmapViewController alloc]init];
    [map setCheckstring:@"profile"];
    [map setAddressstring:[NSString stringWithFormat:@"%@",address.text]];
    [self.navigationController pushViewController:map animated:NO];
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
