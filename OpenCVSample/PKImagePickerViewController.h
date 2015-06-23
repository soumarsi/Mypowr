//
//  MyImagePickerViewController.h
//  cameratestapp
//
//  Created by pavan krishnamurthy on 6/24/14.
//  Copyright (c) 2014 pavan krishnamurthy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@protocol PKImagePickerViewControllerDelegate <NSObject>

-(void)imageSelected:(UIImage*)img;
-(void)imageSelectionCancelled;

@end

@interface PKImagePickerViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CLLocationManagerDelegate>{
    
    UIImage *capturedImage;
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
    NSString *AreaStr;
}

@property(nonatomic,strong) id<PKImagePickerViewControllerDelegate> delegate;

@end
