//
//  MMReportPoleImgViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 13/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 105.0
#import "MMReportPoleImgViewController.h"
#import"MMReportPoleMapViewController.h"
#import "PKImagePickerViewController.h"
#import "MMReportViewController.h"

@interface MMReportPoleImgViewController ()
{
    NSOperationQueue *reportQueue;
}

@end

@implementation MMReportPoleImgViewController
@synthesize MainImage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
        
        if(rect.origin.y != -105.000000){
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
    
    geocode = NO;
    
    NSLog(@"MMReportPoleImgViewController");

    // Do any additional setup after loading the view.
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    
//    //picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//   [self presentViewController:picker animated:YES completion:NULL];
    
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
    
    
    
    HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(85.0f, 20.0f,200.0f, 40.0f)];
    
    [HeaderLbl setBackgroundColor:[UIColor clearColor]];
    
    [HeaderLbl setText:@"OUTAGE DETAILS"];
    
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:23.0f]];
    
    [MainView addSubview:HeaderLbl];
    
    
    lockimg = [[UIImageView alloc]initWithFrame:CGRectMake(25.0f, 60.0f, 26/2, 31/2)];
    [lockimg setImage:[UIImage imageNamed:@"lockimg"]];
    [MainView addSubview:lockimg];
    
    
    HeaderTextlbl = [[UILabel alloc]initWithFrame:CGRectMake(50, 60.0f,260.0f, 16.0f)];
    [HeaderTextlbl setBackgroundColor:[UIColor clearColor]];
    [HeaderTextlbl setText:@"A secure connection is used to send your information"];
    [HeaderTextlbl setTextAlignment:NSTextAlignmentLeft];
    [HeaderTextlbl setTextColor:[UIColor whiteColor]];
    [HeaderTextlbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:10]];
    [MainView addSubview:HeaderTextlbl];
    
    
    UIView *UsBackView = [[UIView alloc] initWithFrame:CGRectMake(0,90, 320, 85/2)];
    UsBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fullnametxtfiled"]];
    [MainView addSubview:UsBackView];
    
    UILabel *fullname = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 150.0f, 42.5f)];
    [fullname setBackgroundColor:[UIColor clearColor]];
    [fullname setText:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"firstname"]]];
    [fullname setTextAlignment:NSTextAlignmentLeft];
    [fullname setTextColor:[UIColor whiteColor]];
    [fullname setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:18]];
    [UsBackView addSubview:fullname];
    
    UILabel *lastname = [[UILabel alloc]initWithFrame:CGRectMake(170.0f, 0.0f, 150.0f, 42.5f)];
    [lastname setBackgroundColor:[UIColor clearColor]];
    [lastname setText:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"lastname"]]];
    [lastname setTextAlignment:NSTextAlignmentLeft];
    [lastname setTextColor:[UIColor whiteColor]];
    [lastname setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:18]];
    [UsBackView addSubview:lastname];
    
    UIView *UsBackView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 133, 320, 85/2)];
    UsBackView1.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView1];
    
    UILabel *type = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 42.5f)];
    [type setBackgroundColor:[UIColor clearColor]];
    [type setText:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"Pole_NAME"]]];
    [type setTextAlignment:NSTextAlignmentLeft];
    [type setTextColor:[UIColor whiteColor]];
    [type setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:18]];
    [UsBackView1 addSubview:type];

    
    UIView *UsBackView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 176.0f, 320, 85/2)];
    UsBackView2.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView2];
    
    UILabel *type_sub = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 42.5f)];
    [type_sub setBackgroundColor:[UIColor clearColor]];
    [type_sub setText:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"PoleCAT_NAME"]]];
    [type_sub setTextAlignment:NSTextAlignmentLeft];
    [type_sub setTextColor:[UIColor whiteColor]];
    [type_sub setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:18]];
    [UsBackView2 addSubview:type_sub];
    
    UIView *UsBackView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 219, 320, 130/2)];
    UsBackView3.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Addressfield"]];
    [MainView addSubview:UsBackView3];
    
    UILabel *address = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 320.0f, 130/2)];
    [address setBackgroundColor:[UIColor clearColor]];
    [address setText:[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"area"]]];
    [address setTextAlignment:NSTextAlignmentLeft];
    [address setTextColor:[UIColor whiteColor]];
    address.numberOfLines = 2;
    [address setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:17]];
    [UsBackView3 addSubview:address];
    
    
    UIView *UsBackView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 284.5f, 320, 150/2)];
    UsBackView4.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"notefield"]];
    [MainView addSubview:UsBackView4];
    
    CoemtText = [[UITextView alloc]initWithFrame:CGRectMake(10.0f,3.0f,300.0f,75)];
    CoemtText.textColor = [UIColor whiteColor];
    CoemtText.font = [UIFont fontWithName:GLOBALTEXTFONT_Light size:20.0f];
    CoemtText.backgroundColor = [UIColor clearColor];
    CoemtText.scrollEnabled = YES;
    CoemtText.pagingEnabled = YES;
    CoemtText.editable = YES;
    CoemtText.delegate = self;
    CoemtText.textAlignment = NSTextAlignmentLeft;
    [UsBackView4 addSubview:CoemtText];
    
    placelabl=[[UILabel alloc]initWithFrame:CGRectMake(6.0f, 10.0f, 200.0f, 40.0f)];
    placelabl.text=@"Comment....";
    placelabl.font=[UIFont fontWithName:GLOBALTEXTFONT size:14];
    placelabl.textAlignment=NSTextAlignmentLeft;
    //[placelabl setHidden:YES];
    placelabl.textColor=[UIColor whiteColor];
    [CoemtText addSubview:placelabl];
    
    
    
    ImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10.0f, 370.0f, 200.0f, 100.0f)];
    [ImageView setImage:MainImage];
    ImageView.clipsToBounds=YES;
    ImageView.contentMode = UIViewContentModeScaleAspectFit;
    [MainView addSubview:ImageView];
    CGSize size = [ImageView sizeThatFits:ImageView.frame.size];
    
    CGSize actualSize;
    actualSize.height = ImageView.frame.size.height;
    actualSize.width = size.width / (1.0 * (size.height / ImageView.frame.size.height));
    
    CGRect frame = ImageView.frame;
    frame.size = actualSize;
    [ImageView setFrame:frame];
    
    
    UIButton *changeimg = [UIButton buttonWithType:UIButtonTypeCustom];
    [changeimg setFrame:CGRectMake(230.0f, 400.0f, 80.0f, 40.0f)];
    [changeimg setBackgroundColor:[UIColor clearColor]];
    [changeimg setTitle:@"CHANGE" forState:UIControlStateNormal];
    [changeimg setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    changeimg.titleLabel.font = [UIFont fontWithName:GLOBALTEXTFONT_BOLD size:18];
    [changeimg addTarget:self action:@selector(pic:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:changeimg];
    
    //backview...............
    
    UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    [MainView addSubview:UsBackView8];

    //backbutton.........................

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
    
    //save.........................
    
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



//back button function.................

-(void)back:(UIButton *)sender{
    
    
    
    MMReportPoleMapViewController *map = [[MMReportPoleMapViewController alloc]init];
    
    [self.navigationController pushViewController:map animated:NO];
    
    
    
}

 - (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
    {
 
        currentLocation = newLocation;
        
        if (currentLocation != nil) {


        }

         geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemrk, NSError *error) {

            
            if (error == nil && [placemrk count] > 0) {
                
                placemark = [placemrk lastObject];
                

                
                geocode = YES;
                
                AreaStr = [NSString stringWithFormat:@"%@ %@,%@,%@,%@",placemark.subThoroughfare,placemark.thoroughfare,placemark.locality,placemark.country,placemark.postalCode];

                
                
                
                [locationManager stopUpdatingLocation];
                
     
                
            } else {
            }
            
        }];

        
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude] forKey:@"lat"];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude] forKey:@"long"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [locationManager stopUpdatingLocation];

    }
    
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
    {

        
        
}
-(void)Save:(UIButton *)sender
{
    
    NSLog(@"entry...");

        spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        spinner.center = CGPointMake(160, 400);
        spinner.hidesWhenStopped = YES;
        [MainView addSubview:spinner];
        [spinner startAnimating];
    
    
    CGSize size = MainImage.size;
    CGFloat ratio = 0;
    if (size.width > size.height) {
        ratio = 300.0 / size.width;
    }
    else {
        ratio = 300.0 / size.height;
    }
    CGRect rect = CGRectMake(0.0, 0.0, ratio * size.width, ratio * size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    [MainImage drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
        
    reportQueue = [[NSOperationQueue alloc]init];
    
    [reportQueue addOperationWithBlock:^{

    NSString *ReportPoleStr = [[NSString alloc]init];
    
    ReportPoleStr = [NSString stringWithFormat:@"%@insert_pole.php?userid=%@&pid=%@&catid=%@&area=%@&note=%@",DOMAIN_APP_URL,[[NSUserDefaults standardUserDefaults]objectForKey:@"id"],[[NSUserDefaults standardUserDefaults]objectForKey:@"Pole_ID"],[[NSUserDefaults standardUserDefaults]objectForKey:@"PoleCAT_ID"],[[NSUserDefaults standardUserDefaults]objectForKey:@"area"],CoemtText.text];
        
        NSLog(@"reportstring.... :%@",ReportPoleStr);

     NSString* urlTextEscaped = [ReportPoleStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setURL:[NSURL URLWithString:urlTextEscaped]];
    [request setTimeoutInterval:10];
    [request setHTTPMethod:@"POST"];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    
    NSData *imageData =[NSData dataWithData:UIImageJPEGRepresentation(thumbnail, 1)];
              
    if ( [imageData length] > 0)
        //   if (pic_send ==1)
    {
        NSString *boundary = [NSString stringWithFormat:@"%0.9u",arc4random()];
         NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"poleimage\"; filename=\".jpg\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:UIImageJPEGRepresentation(thumbnail, 1)]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        
    }
    
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSData *returnData1 = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error)
    {

        return ;
        
    }
    else
    {
        
        Imgjson=[NSJSONSerialization JSONObjectWithData:returnData1 options:kNilOptions error:&error];

    
        REPORTalert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Report save successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [REPORTalert show];
        
        MMReportViewController *view = [[MMReportViewController alloc]init];
        [self.navigationController pushViewController:view animated:NO];
        
        [spinner stopAnimating];
    }
        
        
            
        }];
        
    }];
   

    
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    //    commentbox.text = @"";
    placelabl.hidden=YES;
    CoemtText.textColor = [UIColor whiteColor];
    return YES;
    
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
    if ([CoemtText.text isEqualToString:@""]) {
        
        placelabl.hidden=NO;
        
    }
    else{

    }
    return YES;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    
    if([text isEqualToString:@"\n"]) {
        
        [CoemtText resignFirstResponder];
        
        return NO;
        
    }

    return YES;
    
}

-(void)pic:(UIButton *)sender{
    
    PKImagePickerViewController *imagePicker = [[PKImagePickerViewController alloc]init];
    
    [self.navigationController pushViewController:imagePicker animated:YES ];
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
