//
//  MMmapViewController.m
//  MeterMaid
//
//  Created by RAHUL - ( iMAC ) on 10/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMmapViewController.h"

@interface MMmapViewController ()

@end

@implementation MMmapViewController
@synthesize coordinate;
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
    
    [self CurrentLocationIdentifier];
    
    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:leftMenu];
    
    //backgroundView...................
    
    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
    [self.view addSubview:MainView];
    
    
    Map=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    [Map setMapType:MKMapTypeHybrid];
    Map.zoomEnabled=YES;
    Map.delegate=self;
    [MainView addSubview:Map];
    Map.showsUserLocation = NO;
    
    
    
    
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
    [HeaderLbl setText:@"O U T A G E  M A P"];
    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
    [HeaderLbl setTextColor:[UIColor whiteColor]];
    [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
    [Map addSubview:HeaderLbl];
    
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
    

    
    
    //// ToolBar ///////
    
    Toolbar=[[UIView alloc]initWithFrame:CGRectMake(0, 529, 320, 40)];
    Toolbar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
    //Toolbar.backgroundColor=[UIColor grayColor];
    
    [Map addSubview:Toolbar];
    
    //// toolbar buttons /////
    
    hospitalbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 2,69/2, 73/2)];
    hospitalbtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"hospital"]];
    
    gasbtn=[[UIButton alloc]initWithFrame:CGRectMake(110, 3,40/2, 67/2)];
    gasbtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"gas"]];
    
    foodbtn=[[UIButton alloc]initWithFrame:CGRectMake(190, 1,46/2, 71/2)];
    foodbtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"food"]];
    
    reportbtn=[[UIButton alloc]initWithFrame:CGRectMake(276, 3,58/2, 70/2)];
    reportbtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"report"]];
    
    
    [Toolbar addSubview:hospitalbtn];
    [Toolbar addSubview:gasbtn];
    [Toolbar addSubview:foodbtn];
    [Toolbar addSubview:reportbtn];
    
    locator = [[UIImageView alloc]initWithFrame:CGRectMake(40, 180, 220, 100)];
    locator.image=[UIImage imageNamed:@"textbgForLocation"];
    locator.userInteractionEnabled=YES;
    [MainView addSubview:locator];
    
    
    
    
    loc_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 437/2, 200/2)];
    loc_label.backgroundColor=[UIColor clearColor];
    loc_label.text=@"";
    loc_label.userInteractionEnabled=YES;
    loc_label.textAlignment=NSTextAlignmentCenter;
    loc_label.textColor=[UIColor whiteColor];
    loc_label.numberOfLines=3;
    //    loc_label.font = [UIFont systemFontOfSize:12];
    loc_label.font = [UIFont boldSystemFontOfSize:17];
    [locator addSubview:loc_label];

}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	
////// geting user current location /////
//    
//    [self CurrentLocationIdentifier];
//    
//    leftMenu = [[MMSideview alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [self.view addSubview:leftMenu];
//    
//    //backgroundView...................
//    
//    MainView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 320.0f, self.view.frame.size.height)];
//    [MainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]]];
//    [self.view addSubview:MainView];
//    ///// creating map view //////
//    
//   Map=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
//    [Map setMapType:MKMapTypeHybrid];
//    Map.zoomEnabled=YES;
//    Map.delegate=self;
//     [MainView addSubview:Map];
//    Map.showsUserLocation = YES;
//    
//    MKCoordinateRegion region;
//    region.center = CLLocationCoordinate2DMake([[[NSUserDefaults standardUserDefaults]objectForKey:@"lat"]floatValue],[[[NSUserDefaults standardUserDefaults]objectForKey:@"long"]floatValue]);
//    region.span = MKCoordinateSpanMake(0.03, 0.03); //Zoom distance
//    region = [Map regionThatFits:region];
//    [Map setRegion:region animated:YES];
//
//    
//    
/////// for map testing only /////////
//    
////CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(22.5667, 88.3667);
////MKCoordinateRegion adjustedRegion = [self->Map regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 900, 900)];
////    [Map setRegion:adjustedRegion animated:YES];
////    
//////////////////////////////////////
//    
//   
//
//    
//    //HeaderLabel.......................
//    
//    HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(12.0f, 20.0f,300.0f, 40.0f)];
//    [HeaderLbl setBackgroundColor:[UIColor clearColor]];
//    [HeaderLbl setText:@"O U T A G E  M A P"];
//    [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
//    [HeaderLbl setTextColor:[UIColor whiteColor]];
//    [HeaderLbl setFont:[UIFont fontWithName:@"Helvetica-LT-Light.ttf" size:30.0f]];
//    [HeaderLbl setFont:[UIFont systemFontOfSize:25.0f]];
//    [Map addSubview:HeaderLbl];
//    
//    //menu button............
//    
//    
//    Menubtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Menubtn setFrame:CGRectMake(0.0f, 30.0f, 66/2,40/2)];
//    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateNormal];
//    [Menubtn setBackgroundImage:[UIImage imageNamed:@"menubtn"] forState:UIControlStateHighlighted];
//    [Menubtn addTarget:self action:@selector(menu:) forControlEvents:UIControlEventTouchUpInside];
//    [MainView addSubview:Menubtn];
//    
//    
//    UIView *menuview = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 20.0f, 43.0f, 40.0f)];
//    [menuview setBackgroundColor:[UIColor clearColor]];
//    [MainView addSubview:menuview];
//    
//    UITapGestureRecognizer *menutap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(menu:)];
//    [menuview addGestureRecognizer:menutap];
//    menuview.userInteractionEnabled = YES;
//    
//    locator = [[UIImageView alloc]initWithFrame:CGRectMake(40, 180, 220, 100)];
//    locator.image=[UIImage imageNamed:@"textbgForLocation"];
//    locator.userInteractionEnabled=YES;
//    [MainView addSubview:locator];
//    
//    
//    
//    
//    loc_label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 437/2, 200/2)];
//    loc_label.backgroundColor=[UIColor clearColor];
//    loc_label.text=@"";
//    loc_label.userInteractionEnabled=YES;
//    loc_label.textAlignment=NSTextAlignmentCenter;
//    loc_label.textColor=[UIColor whiteColor];
//    loc_label.numberOfLines=3;
//    //    loc_label.font = [UIFont systemFontOfSize:12];
//    loc_label.font = [UIFont boldSystemFontOfSize:17];
//    [locator addSubview:loc_label];
//
//    
//    //// ToolBar ///////
//    
//    Toolbar=[[UIView alloc]initWithFrame:CGRectMake(0, 529, 320, 40)];
//    Toolbar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
//    //Toolbar.backgroundColor=[UIColor grayColor];
//    
//    [Map addSubview:Toolbar];
//    
//    //// toolbar buttons /////
//    
//    hospitalbtn=[[UIButton alloc]initWithFrame:CGRectMake(10, 3,69/2, 73/2)];
//    hospitalbtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"hospital"]];
//    
//    gasbtn=[[UIButton alloc]initWithFrame:CGRectMake(110, 3,40/2, 67/2)];
//    gasbtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"gas"]];
//    
//    foodbtn=[[UIButton alloc]initWithFrame:CGRectMake(190, 3,46/2, 71/2)];
//    foodbtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"food"]];
//    
//    reportbtn=[[UIButton alloc]initWithFrame:CGRectMake(276, 3,58/2, 70/2)];
//    reportbtn.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"report"]];
//
//    
//    [Toolbar addSubview:hospitalbtn];
//    [Toolbar addSubview:gasbtn];
//    [Toolbar addSubview:foodbtn];
//    [Toolbar addSubview:reportbtn];
//    
//
//}

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
         NSString *locatedaddress = [[placemark1.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
         
         
         //         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Your location" message:locatedaddress delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil]; [alert show];
         
         loc_label.text=locatedaddress;
         
         
         [[NSUserDefaults standardUserDefaults]setObject:locatedaddress forKey:@"area"];
         
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
