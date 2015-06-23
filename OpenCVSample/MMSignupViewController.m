//
//  MMSignupViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 10/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 40.0
#import "MMSignupViewController.h"
#import "MPTestDriveViewController.h"
#import "MPTestDriveViewController.h"
#import "MMAddressmapViewController.h"
@interface MMSignupViewController ()<UITextViewDelegate,UIAlertViewDelegate>
{
    CGSize myStringSize ;
    NSOperationQueue  *downloadqueue;
    NSString *longgo;
    NSString *latgo;
    UITextField *Apartmentno;
    UIButton *clearbutton;
    NSString *adresscheckingstr;
}

@end

@implementation MMSignupViewController
@synthesize addresscoming,firstnamesignup,lastnamesignup,emailsignup,passwordsignup;

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
    
    NSLog(@"signupviewcontroller");
    
    //backgroundView...................
    
    
     [self CurrentLocationIdentifier];
    
    
    
    
    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [self.view addSubview:MainView];
    
    //scrollview................
    MainScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, 568.0f)];
    MainScroll.userInteractionEnabled=YES;
    MainScroll.scrollEnabled=NO;
    MainScroll.showsVerticalScrollIndicator=YES;
    MainScroll.contentSize=CGSizeMake(300.0f, 601.0f);
    [MainView addSubview:MainScroll];
    
    //header label.....................
    
    
    HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 5.0f,320.0f, 40.0f)];
    [HeaderLbl setBackgroundColor:[UIColor clearColor]];
    [HeaderLbl setText:@"WELCOME"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25]];
    [MainScroll addSubview:HeaderLbl];
    
    
    lockimg = [[UIImageView alloc]initWithFrame:CGRectMake(25.0f, 60.0f, 26/2, 31/2)];
    [lockimg setImage:[UIImage imageNamed:@"lockimg"]];
    [MainScroll addSubview:lockimg];
    
    
    HeaderTextlbl = [[UILabel alloc]initWithFrame:CGRectMake(43.0f, 60.0f,260.0f, 16.0f)];
    [HeaderTextlbl setBackgroundColor:[UIColor clearColor]];
    [HeaderTextlbl setText:@"A secure connection is used to send your information"];
    [HeaderTextlbl setTextAlignment:NSTextAlignmentLeft];
    [HeaderTextlbl setTextColor:[UIColor whiteColor]];
    [HeaderTextlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:10]];
    [MainScroll addSubview:HeaderTextlbl];
    
    headertextlbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 95.0f,320.0f, 30.0f)];
    [headertextlbl1 setBackgroundColor:[UIColor clearColor]];
    [headertextlbl1 setText:@"Tell Us About Yourself"];
    [headertextlbl1 setTextAlignment:NSTextAlignmentCenter];
    [headertextlbl1 setTextColor:[UIColor whiteColor]];
    [headertextlbl1 setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:20]];
    [MainScroll addSubview:headertextlbl1];
    
    
    //Fullname textfileld...................
    
    UIView *UsBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 130, 320, 85/2)];
    UsBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fullnametxtfiled"]];
    [MainScroll addSubview:UsBackView];
    
    FullName = [[UITextField alloc] initWithFrame:CGRectMake(0, 130.0f, 160.0f, 85/2)];
    FullName.backgroundColor = [UIColor clearColor];
    FullName.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    FullName.placeholder = @"First Name";
    FullName.textColor = [UIColor whiteColor];
    UIView *leftView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [FullName setLeftView:leftView3];
    FullName.autocorrectionType = UITextAutocorrectionTypeNo;
    [FullName setLeftViewMode:UITextFieldViewModeAlways];
    [FullName setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [FullName setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:19]  forKeyPath:@"_placeholderLabel.font"];
    [FullName setDelegate:self];
    [MainScroll addSubview:FullName];
    
    if ([firstnamesignup isKindOfClass:[NSNull class]] || [firstnamesignup length]==0 || [firstnamesignup isEqualToString:@"(null)"]){
        
        FullName.text=@"";
        
    }
    else{
        FullName.text=[NSString stringWithFormat:@"%@",firstnamesignup];
    }
    
    

    
    lastname = [[UITextField alloc] initWithFrame:CGRectMake(160, 130.0f, 160.0f, 85/2)];
    lastname.backgroundColor = [UIColor clearColor];
    lastname.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    lastname.placeholder = @"Last Name";
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [lastname setLeftView:leftView];
    [lastname setLeftViewMode:UITextFieldViewModeAlways];
    lastname.textColor = [UIColor whiteColor];
    lastname.autocorrectionType = UITextAutocorrectionTypeNo;
    [lastname setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [lastname setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:19]  forKeyPath:@"_placeholderLabel.font"];
    [lastname setDelegate:self];
    [MainScroll addSubview:lastname];
    
    
    if ([lastnamesignup isKindOfClass:[NSNull class]] || [lastnamesignup length]==0 || [lastnamesignup isEqualToString:@"(null)"]){
        
         lastname.text=@"";
        
    }
    else{
        lastname.text=[NSString stringWithFormat:@"%@",lastnamesignup];
    }
    
    
    
    
    
    
    
    //email field............
    
    
    UIView *UsBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 173, 320, 85/2)];
    UsBackView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView1];
    
    Email = [[UITextField alloc] initWithFrame:CGRectMake(0, 173.0f, 320.0f, 85/2)];
    Email.backgroundColor = [UIColor clearColor];
    Email.font = [UIFont fontWithName:GLOBALTEXTFONT size:17.0f];
    Email.placeholder = @"Email";
    Email.textColor = [UIColor whiteColor];
    UIView *leftView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [Email setLeftView:leftView1];
    Email.autocorrectionType = UITextAutocorrectionTypeNo;
    [Email setLeftViewMode:UITextFieldViewModeAlways];
    [Email setKeyboardType:UIKeyboardTypeEmailAddress];
    [Email setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [Email setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:19]  forKeyPath:@"_placeholderLabel.font"];
    [Email setDelegate:self];
    [MainScroll addSubview:Email];
    
    
    if ([emailsignup isKindOfClass:[NSNull class]] || [emailsignup length]==0 || [emailsignup isEqualToString:@"(null)"]){
        
        Email.text=@"";
        
    }
    else{
        Email.text=[NSString stringWithFormat:@"%@",emailsignup];
    }
    
    
    
    
    
    
    
    
    //password field............
    
    
    UIView *UsBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 216, 320, 85/2)];
    UsBackView2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainScroll addSubview:UsBackView2];
    
    passcode = [[UITextField alloc] initWithFrame:CGRectMake(0, 216.0f, 320.0f, 85/2)];
    passcode.backgroundColor = [UIColor clearColor];
    passcode.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
    passcode.placeholder = @"Passcode";
    passcode.textColor = [UIColor whiteColor];
    UIView *leftView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
    [passcode setLeftView:leftView2];
    passcode.autocorrectionType = UITextAutocorrectionTypeNo;
    [passcode setLeftViewMode:UITextFieldViewModeAlways];
    [passcode setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [passcode setValue:[UIFont fontWithName:GLOBALTEXTFONT_Light size:19]  forKeyPath:@"_placeholderLabel.font"];
    [passcode setDelegate:self];
    [MainScroll addSubview:passcode];
    [passcode setSecureTextEntry:YES];
    
    
    if ([passwordsignup isKindOfClass:[NSNull class]] || [passwordsignup length]==0 || [passwordsignup isEqualToString:@"(null)"]){
        
        passcode.text=@"";
        
    }
    else{
        passcode.text=[NSString stringWithFormat:@"%@",passwordsignup];
    }
    
    
    //address field............
    NSLog(@"adddddd %@",addresscoming);
    

    
    
    
        if ([addresscoming isKindOfClass:[NSNull class]] || [addresscoming length]==0 || [addresscoming isEqualToString:@"(null)"]) {
            
            adresscheckingstr = @"Choose your Location";
            
            clearbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 285, 320, 85/2)];
            clearbutton.backgroundColor=[UIColor colorWithRed:(171.0f/255.0f) green:(199.0f/255.0f) blue:(219.0f/255.0f) alpha:1.0f];
            [clearbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [clearbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [clearbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
            [clearbutton setTitle:@"Choose your Location" forState:UIControlStateHighlighted];
            [clearbutton setTitle:@"Choose your Location" forState:UIControlStateSelected];
            [clearbutton setTitle:@"Choose your Location" forState:UIControlStateNormal];
            clearbutton.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
            [clearbutton addTarget:self action:@selector(addresstap:) forControlEvents:UIControlEventTouchUpInside];
            [MainScroll addSubview:clearbutton];

        }
        else
        {
                adresscheckingstr = @"";
            
            //apartment no backview...
            
            
            UIView *UsBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 285, 320, 85/2)];
            UsBackView3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
            [MainScroll addSubview:UsBackView3];
            
            Apartmentno = [[UITextField alloc] initWithFrame:CGRectMake(0, 285.0f, 320.0f, 85/2)];
            Apartmentno.backgroundColor = [UIColor clearColor];
            Apartmentno.font = [UIFont fontWithName:GLOBALTEXTFONT size:17];
            Apartmentno.placeholder = @"Apartment No";
            Apartmentno.textColor = [UIColor whiteColor];
            UIView *leftView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 7)];
            [Apartmentno setLeftView:leftView7];
            [Apartmentno setLeftViewMode:UITextFieldViewModeAlways];
            [Apartmentno setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
            [Apartmentno setValue:[UIFont fontWithName:GLOBALTEXTFONT_BOLD size:17]  forKeyPath:@"_placeholderLabel.font"];
            [Apartmentno setDelegate:self];
            Apartmentno.autocorrectionType = UITextAutocorrectionTypeNo;
            [MainScroll addSubview:Apartmentno];
            
            //apartment no field.....
            
            
            CGSize maximumSize = CGSizeMake(300, 9999);
            
            
            UIFont *myFont = [UIFont fontWithName:GLOBALTEXTFONT size:15];
            
            
            
            
            myStringSize = [addresscoming sizeWithFont:myFont  constrainedToSize:maximumSize lineBreakMode:NSLineBreakByWordWrapping];
            

            
             NSLog(@"adddddddddd %@",addresscoming);
            NSLog(@"heightttttt %f",myStringSize.height);
            
            
            UIView *UsBackView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 333, 320, myStringSize.height+20)];
            UsBackView4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
            [MainScroll addSubview:UsBackView4];
            
            address = [[UITextField alloc] initWithFrame:CGRectMake(0, 333, 280.0f, myStringSize.height+20)];
            address.backgroundColor = [UIColor colorWithRed:(171.0f/255.0f) green:(199.0f/255.0f) blue:(219.0f/255.0f) alpha:1.0f];
            address.userInteractionEnabled = NO;
            address.font = [UIFont fontWithName:GLOBALTEXTFONT size:15];
            address.delegate = self;
            address.autocorrectionType = UITextAutocorrectionTypeNo;
            address.textColor = [UIColor whiteColor];
            [MainScroll addSubview:address];
            
             address.text=[NSString stringWithFormat:@"%@",addresscoming];
         
            
            UIButton *locationchange = [UIButton buttonWithType:UIButtonTypeCustom];
            [locationchange setFrame:CGRectMake(284, 333, 35, 35)];
            [locationchange setBackgroundImage:[UIImage imageNamed:@"locationimage"] forState:UIControlStateNormal];
            [locationchange addTarget:self action:@selector(addresstap:) forControlEvents:UIControlEventTouchUpInside];
            [MainScroll addSubview:locationchange];
            
        }

    


    
    
    
    
    //backbutton.........................
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 510, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainScroll addSubview:Backbtn];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 503, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainScroll addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    //save.........................
    
    Savebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Savebtn setFrame:CGRectMake(270.0f, 507, 22, 36)];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateNormal];
    [Savebtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateHighlighted];
    [Savebtn addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    [MainScroll addSubview:Savebtn];
    
    UIButton *saveview = [[UIButton alloc]initWithFrame:CGRectMake(200.0f, 503, 100, 40)];
    [saveview setBackgroundColor:[UIColor clearColor]];
     [saveview addTarget:self action:@selector(Save:) forControlEvents:UIControlEventTouchUpInside];
    [MainScroll addSubview:saveview];
    
//    UITapGestureRecognizer *savetp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Save:)];
//    [saveview addGestureRecognizer:savetp];
//    saveview.userInteractionEnabled = YES;
    
  
	// Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled=NO;
    }
    
    downloadqueue=[[NSOperationQueue alloc]init];
    
    [downloadqueue addOperationWithBlock:^{
        
        NSString *url=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/geocode/json?address=%@",addresscoming];
        
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
            
            
            NSDictionary *location=[[NSDictionary alloc]init];
            location=[geometry objectForKey:@"location"];
            NSLog(@"locationdict is %@",location);
            
            longgo=[location objectForKey:@"lng"];
            latgo=[location objectForKey:@"lat"];
            
            NSLog(@"longgo isss %@",longgo);
             NSLog(@"latgo isss %@",latgo);
            
            
            
        }];
    }];

}
-(void)CurrentLocationIdentifier
{
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.distanceFilter = 30.0f;
    if ([CLLocationManager locationServicesEnabled])
    {
        [locationManager startUpdatingLocation];
    }
    else
    {
        
    }
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [locationManager requestWhenInUseAuthorization];
    }
    
    curr_lat = [[[NSUserDefaults standardUserDefaults]objectForKey:@"lat"]floatValue];
    curr_long = [[[NSUserDefaults standardUserDefaults]objectForKey:@"long"]floatValue];
    
    
   
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        
    }
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude] forKey:@"lat"];
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude] forKey:@"long"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    NSLog(@"latiiiii will go %f",[[[NSUserDefaults standardUserDefaults]objectForKey:@"lat"]floatValue]);
    
    NSLog(@"longiiii will  go %f",[[[NSUserDefaults standardUserDefaults]objectForKey:@"long"]floatValue]);
    
}


//back button function...............

-(void)back:(UIButton *)sender{
    
    MPTestDriveViewController *test = [[MPTestDriveViewController alloc]init];
    [self.navigationController pushViewController:test animated:NO];
    
    
    
}
-(void)addresstap:(UIButton *)sender{
    MMAddressmapViewController *map=[[MMAddressmapViewController alloc]init];
    map.firstnamecoming=FullName.text;
    map.lastnamecoming=lastname.text;
    map.emailcoming=Email.text;
    map.passwordcoming=passcode.text;
    [self.navigationController pushViewController:map animated:NO];
}

//save button function....................

-(void)Save:(UIButton *)sender{
    
    
    
    if ([FullName.text isEqualToString:@""] ) {

        
        FullName.text = @"";
        
        FullName.placeholder = @"Please enter your full name";
        [FullName setValue:[UIFont fontWithName:GLOBALTEXTFONT size:12]  forKeyPath:@"_placeholderLabel.font"];
        return;

    }
    else if ([FullName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length <1 ){
        

        
        FullName.text = @"";
        
        FullName.placeholder = @"Please enter your full name";
        [FullName setValue:[UIFont fontWithName:GLOBALTEXTFONT size:12]  forKeyPath:@"_placeholderLabel.font"];
        return;

    }
   else if ([lastname.text isEqualToString:@""] ) {
        
        
        lastname.text = @"";
        
        lastname.placeholder = @"Please enter your last name";
       [lastname setValue:[UIFont fontWithName:GLOBALTEXTFONT size:10.5f]  forKeyPath:@"_placeholderLabel.font"];
        return;
        
    }
    else if ([lastname.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length <1 ){
        
        
        
        lastname.text = @"";
        
        lastname.placeholder = @"Please enter your last name";
        [lastname setValue:[UIFont fontWithName:GLOBALTEXTFONT size:10.5f]  forKeyPath:@"_placeholderLabel.font"];
        return;
        
    }
    else if ([Email.text isEqualToString:@""]){
        

        
        Email.text = @"";
        
        Email.placeholder = @"Please enter a valid email";
        
        return;
        
    }
    
    else if ([Email.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length <1 ){
        

        Email.text = @"";
        
        Email.placeholder = @"Please enter a valid email";
        
        return;
    }
    else if (![self NSStringIsValidEmail:Email.text]){
        

        
        Email.text = @"";
        
        Email.placeholder = @"Please enter a valid email";
        
        return;
        
        
        
    }
    
    
    else if ([passcode.text isEqualToString:@""]){
        

        
        passcode.text = @"";
        
        passcode.placeholder = @"Please enter your passcode";
        
        return;
        
    }
    else if ([passcode.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet] ].length <1){
        
        
        
        passcode.text = @"";
        
        passcode.placeholder = @"Please enter your passcode";
        return;
        
    }
    
    else if ([passcode.text length] <6){
        

        
        passcode.text = @"";
        
        passcode.placeholder = @"Minimum 6 character required";
        return;
        
    }
    else if ([address.text isEqualToString:@""]){
        
 
        
        address.text = @"";
        
        UIAlertView *Adress = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please choose your location" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [Adress show];
        
        return;
        
    }
    else if ([adresscheckingstr isEqualToString:@"Choose your Location"]){
        

        
        UIAlertView *Adress = [[UIAlertView alloc]initWithTitle:@"Alert" message:@"Please choose your location" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [Adress show];
        
        return;
    }

    else{
        
        @try {
                
                
                
                NSString *string=[[NSString alloc]init];
                string=[NSString stringWithFormat:@"%@/registration.php?firstname=%@&lastname=%@&email=%@&passcode=%@&address=%@&lat=%@&long=%@&apartment_no=%@",DOMAIN_APP_URL,FullName.text ,lastname.text,Email.text,passcode.text,address.text,latgo,longgo,Apartmentno.text];

            
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

                        
                        [[NSUserDefaults standardUserDefaults] setObject:@"fstTime" forKey:@"LognType"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                        
                        

                        alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Registration Successful" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        alert.tag = 5;
                        [alert show];

                        MPTestDriveViewController *sign = [[MPTestDriveViewController alloc]init];
                        [self.navigationController pushViewController:sign animated:NO];
                        
                    }
                    else if ([[json objectForKey:@"auth"] isEqualToString:@"duplicate"])
                    {
                        
                        alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Email already exist" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        alert.tag = 2;
                        [alert show];

                        
                    }
                    
                    else if ([[json objectForKey:@"msg"] isEqualToString:@"fail"]){
                        
                        alert = [[UIAlertView alloc]initWithTitle:@"Registration failed" message:@"Please try again"delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        
                        alert.tag = 2;
                        [alert show];
                        
                        
                    }
                }

        }
        @catch (NSException *exception) {
            

            
        }
        @finally {
            
        }
        
    }

    
    
    
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
        
        if(rect.origin.y != -40.000000){
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

@end
