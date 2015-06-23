//
//  MMmapViewController.h
//  MeterMaid
//
//  Created by RAHUL - ( iMAC ) on 10/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MMSideview.h"
@interface MMmapViewController : UIViewController<MKMapViewDelegate,MKAnnotation,CLLocationManagerDelegate>
{
    UIView *MainView;
    UILabel *HeaderLbl;
    MKMapView *Map;
    UIView *Toolbar;
    UIButton *hospitalbtn,*gasbtn,*foodbtn,*reportbtn;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *AreaStr;
    UIImageView *locator;
    UILabel *loc_label;
    CLLocationCoordinate2D touchCoordinate;
    float curr_lat;
    float curr_long;
       
}



@end
