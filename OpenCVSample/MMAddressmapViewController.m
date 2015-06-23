//
//  MMAddressmapViewController.m
//  OpenCVSample
//
//  Created by Rinki Ganguly on 1/5/15.
//
//

#import "MMAddressmapViewController.h"
#import "MMReportPoleImgViewController.h"
#import <objc/message.h>
#import "PKImagePickerViewController.h"
#import "MMReportPoleViewController.h"
#import "MMSignupViewController.h"
#import "MMSignupViewController.h"
#import "MMSignupViewController.h"
#import "MMProfileViewController.h"

@interface MMAddressmapViewController (){
    float lat,lng;
    float lat2,lng2;
}
@property (nonatomic,strong) PKImagePickerViewController *imagePicker;

@end

@implementation MMAddressmapViewController
@synthesize firstnamecoming,lastnamecoming,emailcoming,passwordcoming;


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
    
    //// geting user current location /////
    
    [self CurrentLocationIdentifier];
    
    
    
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
    [MainView addSubview:Map];
    Map.showsUserLocation = NO;
    
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
    
          //// ToolBar ///////
    
    Toolbar=[[UIView alloc]initWithFrame:CGRectMake(0, 529, 320, 40)];
    Toolbar.backgroundColor=[UIColor colorWithRed:(140.0f/255.0f) green:(133.0f/255.0f) blue:(125.0f/255.0f) alpha:1.0f];
    //Toolbar.backgroundColor=[UIColor grayColor];
    [Toolbar setAlpha:1.0f];
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
    [postbtn setFrame:CGRectMake(270, 529.0f, 22, 36)];
    [postbtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateNormal];
    [postbtn setBackgroundImage:[UIImage imageNamed:@"savebtn"] forState:UIControlStateHighlighted];
    [postbtn addTarget:self action:@selector(post:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:postbtn];
    
    
    //back button.............
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25, 532.0f, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Backbtn];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(135.0f, 526.0f, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    
    
    //    locator = [[UIImageView alloc]initWithFrame:CGRectMake(50, 250, 437/2, 100/2)];
    locator = [[UIImageView alloc]initWithFrame:CGRectMake(40, 180, 220, 100)];
    locator.image=[UIImage imageNamed:@"textbgForLocation"];
    locator.userInteractionEnabled=YES;
    [MainView addSubview:locator];
    
    
    
    
    loc_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 437/2, 200/2)];
    loc_label.backgroundColor=[UIColor clearColor];
    loc_label.text=@"";
    loc_label.userInteractionEnabled=YES;
    loc_label.textAlignment=NSTextAlignmentCenter;
    loc_label.textColor=[UIColor yellowColor];
    loc_label.numberOfLines=3;
    loc_label.font = [UIFont boldSystemFontOfSize:17];
    [locator addSubview:loc_label];
    
    
    
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
            
            NSLog(@"location.... %@",placemark);
            
            
            //                 AreaStr = [NSString stringWithFormat:@"%@ %@,%@,%@,%@",placemark.subThoroughfare,placemark.thoroughfare,placemark.locality,placemark.country,placemark.postalCode];
            
            
            AreaStr = [NSString stringWithFormat:@"%@,%@,%@",placemark.locality,placemark.country,placemark.postalCode];
            
            
            [[NSUserDefaults standardUserDefaults]setObject:AreaStr forKey:@"area"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [locationManager stopUpdatingLocation];
            
            
            
        } else {
            
            
        }
        
    }];
    
    
    [locationManager stopUpdatingLocation];
    
    
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    MKPointAnnotation *myAnnotation = [[MKPointAnnotation alloc] init];
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
    
    
    
    float spanX = 0.2;
    float spanY = 0.2;
    MKCoordinateRegion region;
    region.center.latitude = Map.userLocation.coordinate.latitude;
    region.center.longitude = Map.userLocation.coordinate.longitude;
    region.span.latitudeDelta = spanX;
    region.span.longitudeDelta = spanY;
    
    [Map setRegion:region animated:YES];
}

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
        annotationView.image = [UIImage imageNamed:@"annotationpin"];
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
    
    
    CLGeocoder *geocoder1 = [[CLGeocoder alloc] init];
    locationManager=[[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    
    
    //    CGPoint touchPoint = CGPointMake(locator.frame.origin.x+70, locator.frame.origin.y-100);
    
    CGPoint touchPoint = CGPointMake(locator.frame.origin.x+110, locator.frame.origin.y+50);
    
    
    touchCoordinate = [Map convertPoint:touchPoint toCoordinateFromView:Map];
    
     lat = touchCoordinate.latitude;
    lng = touchCoordinate.longitude;
    
    
    [[NSUserDefaults standardUserDefaults]setFloat:lat forKey:@"arrive_lat"];
    
    [[NSUserDefaults standardUserDefaults]setFloat:lng forKey:@"arrive_long"];
    
    // map_View.showsUserLocation=YES;
    
    CLLocation *LocationAtual = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    
    [geocoder1 reverseGeocodeLocation:LocationAtual completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         
         //Get address
         CLPlacemark *placemark1 = [placemarks objectAtIndex:0];
                //String to address
         NSString *locatedaddress = [[placemark1.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         
         
         loc_label.text=locatedaddress;
         
         
       
//         CLLocation *location = [placemark1.addressDictionary valueForKey:@"FormattedAddressLines"];
//
//         
//         
//         
//         
//         
//         CLLocationCoordinate2D coordinate = location.coordinate;
//         NSLog(@"coordinate = (%f, %f)", coordinate.latitude, coordinate.longitude);
//         
//         lat2 = coordinate.latitude;
//         lng2 = coordinate.longitude;
//         [self display];

         
         
         
         
         
         NSLog(@"locatedaddresslocatedaddress is %@",[placemark1.addressDictionary valueForKey:@"FormattedAddressLines"]);
          NSLog(@"lat is %f",lat);
         NSLog(@"location is %@",locatedaddress);
         
         
         [[NSUserDefaults standardUserDefaults]setObject:locatedaddress forKey:@"area"];
         
          //[self display];
         
     }];
    
}
-(void)getLatLong:(NSString *)string
{
    CLGeocoder *geocoder2 = [[CLGeocoder alloc] init];
    
    [geocoder2 geocodeAddressString:string completionHandler:^(NSArray *placemarks2, NSError *error) {
        if([placemarks2 count]) {
            CLPlacemark *placemark2 = [placemarks2 objectAtIndex:0];
            CLLocation *location = placemark2.location;
            
//            if([string isEqualToString:self.from.text])
//            {
//                fromLat = coordinate.latitude;
//                fromLng = coordinate.longitude;
//                [self display];
//            }
//            else if([string  isEqualToString:self.to.text])
//            {
//                toLat = coordinate.latitude;
//                toLng = coordinate.longitude;
//                [self display];
//            }
        }
    }];
}

- (void)display
{
    NSLog(@"%f rinkilat",lat2);
    NSLog(@"%f rinkilng",lng2);
   
}




//back button function..........

-(void)back:(UIButton *)sender{
    
    if ([_checkstring isEqualToString:@"profile"]) {
        
        MMProfileViewController *view = [[MMProfileViewController alloc]init];
        [view setDefaultaddress:_addressstring];
        [view setChecking:@"map"];
        [self.navigationController pushViewController:view animated:NO];
    }
    else
    {
    MMSignupViewController *report = [[MMSignupViewController alloc]init];
    report.firstnamesignup=firstnamecoming;
    report.lastnamesignup=lastnamecoming;
    report.emailsignup=emailcoming;
    report.passwordsignup=passwordcoming;
    [self.navigationController pushViewController:report animated:NO];
    }
}

-(void)post:(UIButton *)sender{
    
    if ([_checkstring isEqualToString:@"profile"]) {
        
        MMProfileViewController *view = [[MMProfileViewController alloc]init];
        [view setAddresscoming:[NSString stringWithFormat:@"%@",loc_label.text]];
        [self.navigationController pushViewController:view animated:NO];
    }
    else
    {
    MMSignupViewController *imagePicker = [[MMSignupViewController alloc]init];
    imagePicker.addresscoming=loc_label.text;
    imagePicker.firstnamesignup=firstnamecoming;
    imagePicker.lastnamesignup=lastnamecoming;
    imagePicker.emailsignup=emailcoming;
    imagePicker.passwordsignup=passwordcoming;
    [self.navigationController pushViewController:imagePicker animated:YES ];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
