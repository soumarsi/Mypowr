//
//  MMReportPoleImgViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 13/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMSideview.h"
#import <CoreLocation/CoreLocation.h>

@interface MMReportPoleImgViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate,UITextViewDelegate>{

    
    UIImageView *ImageView;
    UILabel *HeaderLbl,*HeaderTextlbl;
    UIButton *Menubtn;
    MMSideview *leftMenu;
    BOOL menuOpened;
    UIButton *Backbtn;
    UIButton *Savebtn;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    UIView *MainView;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *AreaStr;
    NSDictionary *Imgjson;
    BOOL geocode;
    UIAlertView *REPORTalert;
    UITextView *CoemtText;
    UIImageView *lockimg;
    UILabel *placelabl;
    UIActivityIndicatorView *spinner;
    
}


@property(nonatomic,retain)UIImage *MainImage;

@end
