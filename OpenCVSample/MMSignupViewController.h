//
//  MMSignupViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 10/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@interface MMSignupViewController : UIViewController<UITextFieldDelegate,CLLocationManagerDelegate,MKMapViewDelegate>{
    
    UIView *MainView;
    UILabel *HeaderLbl,*HeaderTextlbl,*headertextlbl1;
    UIImageView *lockimg,*bottomimg;
    UITextField *FullName,*lastname,*Email,*city,*state,*zipcode,*country,*passcode;
    UIScrollView *MainScroll;
    UIButton *Backbtn,*Savebtn;
    NSDictionary *json;
    UIAlertView *alert;
    UITextField *address;
    MKMapView *Map;
    UIView *Toolbar;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    
    UIImageView *locator;
    CLLocationCoordinate2D touchCoordinate;
    float curr_lat;
    float curr_long;
    
    UILabel *loc_label;

}
@property(nonatomic,retain)NSString *addresscoming;
@property(nonatomic,retain) NSString *firstnamesignup;
@property(nonatomic,retain) NSString *lastnamesignup;
@property(nonatomic,retain) NSString *emailsignup;
@property(nonatomic,retain) NSString *passwordsignup;


@end
