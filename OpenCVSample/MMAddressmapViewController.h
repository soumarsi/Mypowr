//
//  MMAddressmapViewController.h
//  OpenCVSample
//
//  Created by Rinki Ganguly on 1/5/15.
//
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MMAddressmapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
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
    
    UILabel *loc_label;
}
@property(nonatomic,retain) NSString *firstnamecoming;
@property(nonatomic,retain) NSString *lastnamecoming;
@property(nonatomic,retain) NSString *emailcoming;
@property(nonatomic,retain) NSString *passwordcoming;
@property(nonatomic,retain)NSString *checkstring;
@property(nonatomic,retain)NSString *addressstring;

@end




