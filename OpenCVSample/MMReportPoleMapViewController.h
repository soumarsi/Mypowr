//
//  MMReportPoleMapViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 12/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MMReportPoleMapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
{
    UIView *MainView;
    UILabel *HeaderLbl;
    MKMapView *Map;
    UIView *Toolbar;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *AreaStr;
    BOOL menuOpened;
    UIButton *searchbtn,*postbtn,*Backbtn;
    UIImageView *locator;
    CLLocationCoordinate2D touchCoordinate;
    float curr_lat;
    float curr_long;
    NSString *locatedaddress;
    UILabel *loc_label;
    UIImageView *crosshairLabel;
    UIButton *editAddress, *findMe;
    UIView *alphaView;
    UITextView *manualAddress;
    UIButton *editSubmit;
    MKPointAnnotation *myAnnotation;
}

@property (nonatomic,retain) UIButton *cross;

@end
