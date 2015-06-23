//
//  MMReportPoleMapViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMReportPoleMapViewController.h"
#import "MMReportPoleImgViewController.h"
#import <objc/message.h>
#import "PKImagePickerViewController.h"
#import "MMReportPoleViewController.h"
@interface MMReportPoleMapViewController ()<UITextViewDelegate>
@property (nonatomic,strong) PKImagePickerViewController *imagePicker;

@end

@implementation MMReportPoleMapViewController

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
    
    NSLog(@"MMReportPoleMapViewController");
    
    //// geting user current location /////
    
    [self CurrentLocationIdentifier];

    NSLog(@"polecatname.... :%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"PoleCAT_NAME"]);
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];
    
    //backgroundView...................
    
    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [self.view addSubview:MainView];
    
    
    ///// creating map view //////
    
    Map=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    [Map setMapType:MKMapTypeHybrid];
    Map.zoomEnabled=YES;
    Map.delegate=self;
    Map.showsUserLocation = YES;
    [MainView addSubview:Map];


    NSLog(@"latiiiii will %f",[[[NSUserDefaults standardUserDefaults]objectForKey:@"lat"]floatValue]);
    
    NSLog(@"longiiii will %f",[[[NSUserDefaults standardUserDefaults]objectForKey:@"long"]floatValue]);
    

    MKCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults]objectForKey:@"lat"]floatValue],[[[NSUserDefaults standardUserDefaults]objectForKey:@"long"]floatValue]);
    region.span = MKCoordinateSpanMake(0.03, 0.03); //Zoom distance
    region = [Map regionThatFits:region];
    [Map setRegion:region animated:YES];
    ///// for map testing only /////////
    
    //CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(22.5667, 88.3667);
    //MKCoordinateRegion adjustedRegion = [self->Map regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 900, 900)];
    //    [Map setRegion:adjustedRegion animated:YES];
    //
    ////////////////////////////////////
    
    
    
    
    //HeaderLabel.......................
    
    HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(12.0f, 20.0f,300.0f, 40.0f)];
    [HeaderLbl setBackgroundColor:[UIColor clearColor]];
    [HeaderLbl setText:@"R E P O R T"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [Map addSubview:HeaderLbl];
    
    //menu button............
    
    
//    Menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Menubtn setFrame:CGRectMake(0.0f, 30.0f, 66/2,40/2)];
//    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateNormal];
//    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateHighlighted];
//    [Menubtn addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
//    [MainView addSubview:Menubtn];
//    
//    UIView *menuview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, 43.0f, 40.0f)];
//    [menuview setBackgroundColor:[UIColor clearColor]];
//    [MainView addSubview:menuview];
//    
//    UITapGestureRecognizer *menutap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(menu:)];
//    [menuview addGestureRecognizer:menutap];
//    menuview.userInteractionEnabled = YES;
    
    //// ToolBar ///////
    
    Toolbar=[[UIView alloc]initWithFrame:CGRectMake(0, 525, 320, 45)];
    Toolbar.backgroundColor=[UIColor colorWithRed:(140.0f/255.0f) green:(133.0f/255.0f) blue:(125.0f/255.0f) alpha:1.0f];
    //Toolbar.backgroundColor=[UIColor grayColor];
    [Toolbar setAlpha:0.6f];
    [Map addSubview:Toolbar];

    
    //search button.................
    
    searchbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchbtn setFrame:CGRectMake(10.0f, 529.0f, 55.5f, 36.0f)];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"searchbtn"] forState:UIControlStateNormal];
    [searchbtn setBackgroundImage:[UIImage imageNamed:@"searchbtn"] forState:UIControlStateHighlighted];
   // [searchbtn addTarget:self action:@selector(search:) forControlEvents:UIControlEventTouchUpInside];
   // [MainView addSubview:searchbtn];  // as client issue
    
    
    //post button.................
    
    postbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [postbtn setFrame:CGRectMake(275.0f, 530.0f, 19.0f, 34.5f)];
    [postbtn setBackgroundImage:[UIImage imageNamed:@"postbtn"] forState:UIControlStateNormal];
    [postbtn setBackgroundImage:[UIImage imageNamed:@"postbtn"] forState:UIControlStateHighlighted];
    [postbtn addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:postbtn];
    
    
    UIView *post = [[UIView alloc]initWithFrame:CGRectMake(260.0f, 520.0f, 60.0f, 48.0f)];
    [post setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:post];
    UITapGestureRecognizer *post1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(post:)];
    [post addGestureRecognizer:post1];
    post.userInteractionEnabled = YES;
    
    
    //back button.............
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25, 531.0f, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Backbtn];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 526.0f, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    
    // edit address manually.............

    editAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [editAddress setFrame:CGRectMake(backview.frame.origin.x+backview.frame.size.width+40.0f, 531.0f, 108.0f/2.0f, 33)];
    [editAddress setBackgroundImage:[UIImage imageNamed:@"editAddressBtn"] forState:UIControlStateNormal];
    [editAddress setBackgroundImage:[UIImage imageNamed:@"editAddressBtn"] forState:UIControlStateHighlighted];
    [editAddress addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:editAddress];
    
    UIView *editAddressView = [[UIView alloc]initWithFrame:CGRectMake(backview.frame.origin.x+backview.frame.size.width+30.0f, 526.0f, 70.0f, 42.5f)];
    [editAddressView setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:editAddressView];
    
    UITapGestureRecognizer *editTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(edit:)];
    [editAddressView addGestureRecognizer:editTap];
    editAddressView.userInteractionEnabled = YES;
    
    // find me.............
    
    findMe = [UIButton buttonWithType:UIButtonTypeCustom];
    [findMe setFrame:CGRectMake(editAddressView.frame.origin.x+editAddressView.frame.size.width+40.0f, 523.0f, 103.0f/2.0f, 50)];
    [findMe setBackgroundImage:[UIImage imageNamed:@"FindMe"] forState:UIControlStateNormal];
    [findMe setBackgroundImage:[UIImage imageNamed:@"FindMe"] forState:UIControlStateHighlighted];
    [findMe addTarget:self action:@selector(findMe:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:findMe];
    
    UIView *findMeView = [[UIView alloc]initWithFrame:CGRectMake(editAddressView.frame.origin.x+editAddressView.frame.size.width+30.0f, 526.0f, 70.0f, 42.5f)];
    [findMeView setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:findMeView];
    
    UITapGestureRecognizer *findMeTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(findMe:)];
    [findMeView addGestureRecognizer:findMeTap];
    findMeView.userInteractionEnabled = YES;
    
    
    crosshairLabel=[[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-(240/2),220,240.0f,40.0f)];
    crosshairLabel.backgroundColor=[UIColor clearColor];
    crosshairLabel.image = [UIImage imageNamed:@"crosshairLabelBack"];
//    crosshairLabel.userInteractionEnabled=YES;
//    crosshairLabel.textAlignment=NSTextAlignmentCenter;
//    crosshairLabel.textColor=[UIColor whiteColor];
//    crosshairLabel.numberOfLines=1;
    //    loc_label.font = [UIFont systemFontOfSize:12];
//    loc_label.font = [UIFont boldSystemFontOfSize:10];
    [MainView addSubview:crosshairLabel];
    
    
////    locator = [[UIImageView alloc]initWithFrame:CGRectMake(50, 250, 437/2, 100/2)];
    locator = [[UIImageView alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2-(35/2), [UIScreen mainScreen].bounds.size.height/2-(35/2), 35, 35)];
    locator.image=[UIImage imageNamed:@"textbgForLocation2"];
    locator.userInteractionEnabled=YES;
    [MainView addSubview:locator];
    
    
    loc_label=[[UILabel alloc]initWithFrame:CGRectMake(0.0f, Toolbar.frame.origin.y-40, [UIScreen mainScreen].bounds.size.width, 40.0f)];
    loc_label.backgroundColor=[[UIColor blackColor]colorWithAlphaComponent:0.6f];
    loc_label.text=@"";
    loc_label.userInteractionEnabled=YES;
    loc_label.textAlignment=NSTextAlignmentCenter;
    loc_label.textColor=[UIColor whiteColor];
    loc_label.numberOfLines=1;
//    loc_label.font = [UIFont systemFontOfSize:12];
    loc_label.font = [UIFont boldSystemFontOfSize:10];
    [MainView addSubview:loc_label];
    
    
    
    // Do any additional setup after loading the view.
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
    
    geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemrk, NSError *error) {
        

        
        if (error == nil && [placemrk count] > 0) {
            
            placemark = [placemrk lastObject];

            

//                 AreaStr = [NSString stringWithFormat:@"%@ %@,%@,%@,%@",placemark.subThoroughfare,placemark.thoroughfare,placemark.locality,placemark.country,placemark.postalCode];
            
            
            AreaStr = [NSString stringWithFormat:@"%@,%@,%@",placemark.locality,placemark.country,placemark.postalCode];
                
          [locationManager stopUpdatingLocation];
            
        } else {

            
        }
        
    }];
    

    [locationManager stopUpdatingLocation];
    
    
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    myAnnotation = [[MKPointAnnotation alloc] init];
    myAnnotation.coordinate = CLLocationCoordinate2DMake(manager.location.coordinate.latitude, manager.location.coordinate.longitude);
    [Map addAnnotation:myAnnotation];
    
    
}
+(CLLocationCoordinate2D) getLocationFromAddressString:(NSString*) getmapvalue {
    
    double latitude = 0, longitude = 0;
    //    NSString *esc_addr =  [getmapvalue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString  *address2=[[NSUserDefaults standardUserDefaults] objectForKey:@"address"];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&getmapvalue=%@",address2 ];

    // NSString *req = [NSString stringWithFormat:@"http://www.quiqfind.com/ios/directionpage.php?from=kolkata&to=%@",esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude = latitude;
    center.longitude = longitude;
    
    return center;
    
    
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
//    MKCoordinateRegion mapRegion;
//    mapRegion.center = mapView.userLocation.coordinate;
//    mapRegion.span.latitudeDelta = 0.2;
//    mapRegion.span.longitudeDelta = 0.2;
//    
//    [mapView setRegion:mapRegion animated: YES];
}
- (void)zoomToCurrentLocation:(UIBarButtonItem *)sender {
    
    [crosshairLabel removeFromSuperview];
    
    float spanX = 0.2;
    float spanY = 0.2;
    MKCoordinateRegion region;
    region.center.latitude = Map.userLocation.coordinate.latitude;
    region.center.longitude = Map.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;

    [Map setRegion:region animated:YES];
}
//- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
//    MKAnnotationView *annotationView = [Map dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
//    if(annotationView)
//        return annotationView;
//    else
//    {
//        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
//                                                                         reuseIdentifier:AnnotationIdentifier] ;
//        annotationView.canShowCallout = YES;
//        annotationView.image = [UIImage imageNamed:@"annotationpin"];
//        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//        //[rightButton addTarget:self action:@selector(writeSomething:) forControlEvents:UIControlEventTouchUpInside];
//        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
//        annotationView.rightCalloutAccessoryView = rightButton;
//        annotationView.canShowCallout = YES;
//        annotationView.draggable = YES;
//        return annotationView;
//    }
//    return nil;
//}
//

//-----------------PK2015--------------

- (MKAnnotationView *)mapView:(MKMapView *)mapview viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    static NSString* AnnotationIdentifier = @"AnnotationIdentifier";
    MKAnnotationView *annotationView ;
    
    if (annotationView==nil)
        
    
    {
        //MKAnnotationView *annotationView = [Map dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                                        reuseIdentifier:AnnotationIdentifier] ;
        annotationView.canShowCallout = YES;
        //annotationpin
//        annotationView.image = [UIImage imageNamed:@""];
        UIButton* rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        //[rightButton addTarget:self action:@selector(writeSomething:) forControlEvents:UIControlEventTouchUpInside];
        [rightButton setTitle:annotation.title forState:UIControlStateNormal];
        annotationView.rightCalloutAccessoryView = rightButton;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        return annotationView;
    }
    return nil;
}


- (void)mapView:(MKMapView *)mMapView regionDidChangeAnimated:(BOOL)animated{
    
    
    [crosshairLabel removeFromSuperview];
    
    CLGeocoder *geocoder1 = [[CLGeocoder alloc] init];
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];


//    CGPoint touchPoint = CGPointMake(locator.frame.origin.x+70, locator.frame.origin.y-100);
    
//    CGPoint touchPoint = CGPointMake(locator.frame.origin.x+110, locator.frame.origin.y+50);
    
    CGPoint touchPoint = CGPointMake(locator.frame.origin.x+110, locator.frame.origin.y+50);


    touchCoordinate = [Map convertPoint:touchPoint toCoordinateFromView:Map];
    
    float lat = touchCoordinate.latitude;
    float lng = touchCoordinate.longitude;
    

    [[NSUserDefaults standardUserDefaults]setFloat:lat forKey:@"arrive_lat"];
    
    [[NSUserDefaults standardUserDefaults]setFloat:lng forKey:@"arrive_long"];
    
    // map_View.showsUserLocation=YES;
    
    CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    
    [geocoder1 reverseGeocodeLocation:LocationAtual completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         //Get address
         CLPlacemark *placemark1 = [placemarks objectAtIndex:0];
         
         //String to address
//         locatedaddress = [[placemark1.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         locatedaddress = [NSString stringWithFormat:@"%@, %@, %@, %@, %@",placemark1.subThoroughfare,placemark1.thoroughfare,placemark1.locality,placemark1.administrativeArea,placemark1.postalCode];

         NSLog(@"LOCATION ADDRESS-------> %@",[placemark1.addressDictionary valueForKey:@"FormattedAddressLines"]);
         NSLog(@"PLACEMARK1 COUNTRY------> %@",placemark1.country);
         NSLog(@"PLACEMARK1 POSTAL CODE------> %@",placemark1.postalCode);
         NSLog(@"PLACEMARK1 throughfare------> %@",placemark1.thoroughfare);
         NSLog(@"PLACEMARK1 locality------> %@",placemark1.locality);
         NSLog(@"PLACEMARK1 administrative area------> %@",placemark1.administrativeArea);
         NSLog(@"PLACEMARK1 sub thorough------> %@",placemark1.subThoroughfare);
         //         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your location" message:locatedaddress delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];

         loc_label.text=locatedaddress;
         
         if ([loc_label.text length] >= 34) {
             
             loc_label.font = [UIFont boldSystemFontOfSize:10];
         }else{
             
             loc_label.font = [UIFont boldSystemFontOfSize:14];
         }
         
         
         //[[NSUserDefaults standardUserDefaults]setObject:locatedaddress forKey:@"area"];

     }];
 
}

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

//back button function..........

-(void)back:(UIButton *)sender{
    
    MMReportPoleViewController *report = [[MMReportPoleViewController alloc]init];
    report.Pole_Id = [[NSUserDefaults standardUserDefaults]objectForKey:@"Pole_ID"];
    [self.navigationController pushViewController:report animated:NO];
    
}

-(void)edit:(UIButton *)sender{ //-----------PK
    
    alphaView = [[UIView alloc]init];
    alphaView.frame = CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    alphaView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [MainView addSubview:alphaView];
    
    manualAddress = [[UITextView alloc]init];
    manualAddress.frame = CGRectMake(50.0f, 50.0f, 220.0f, 180.0f);
    manualAddress.backgroundColor = [UIColor whiteColor];
    manualAddress.delegate = self;
    manualAddress.text = @"Enter your address";
    manualAddress.textColor = [UIColor blackColor];
    manualAddress.layer.cornerRadius = 5.0f;
    [alphaView addSubview:manualAddress];
    
    editSubmit = [[UIButton alloc]init];
    editSubmit.frame = CGRectMake(50.0f, manualAddress.frame.origin.y+manualAddress.frame.size.height+10.0f, 220.0f, 30.0f);
    [editSubmit setTitle:@"SUBMIT" forState:UIControlStateNormal];
    editSubmit.backgroundColor = [UIColor colorWithRed:(74.0f/255.0f) green:(174.0f/255.0f) blue:(57.0f/255.0f) alpha:1.0f];
    [editSubmit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    editSubmit.layer.cornerRadius = 5.0f;
    editSubmit.showsTouchWhenHighlighted = YES;
    [editSubmit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [alphaView addSubview:editSubmit];
    
}

-(void)submit:(UIButton *)sender{
    
    [alphaView removeFromSuperview];
    
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    
    manualAddress.text = @"";
    return YES;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    
    if([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

-(void)post:(UIButton *)sender{

    [[NSUserDefaults standardUserDefaults]setObject:locatedaddress forKey:@"area"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    PKImagePickerViewController *imagePicker = [[PKImagePickerViewController alloc]init];
    [self.navigationController pushViewController:imagePicker animated:YES ];


}

-(void)findMe:(UIButton *)sender{
    
//    [Map setCenter:myAnnotation.coordinate animated:YES];
//    [Map setCenterCoordinate:myAnnotation.coordinate animated:YES];
    MKCoordinateRegion region;
    region.center = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults]objectForKey:@"lat"]floatValue],[[[NSUserDefaults standardUserDefaults]objectForKey:@"long"]floatValue]);
    region.span = MKCoordinateSpanMake(0.03, 0.03); //Zoom distance
    region = [Map regionThatFits:region];
    [Map setRegion:region animated:YES];
    
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
