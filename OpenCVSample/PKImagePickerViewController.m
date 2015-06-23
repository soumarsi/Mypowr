//
//  MyImagePickerViewController.m
//  cameratestapp
//
//  Created by pavan krishnamurthy on 6/24/14.
//  Copyright (c) 2014 pavan krishnamurthy. All rights reserved.
//

#import "PKImagePickerViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "MMReportPoleMapViewController.h"
#import "MMReportPoleImgViewController.h"

@interface PKImagePickerViewController ()

@property(nonatomic,strong) AVCaptureSession *captureSession;
@property(nonatomic,strong) AVCaptureStillImageOutput *stillImageOutput;
@property(nonatomic,strong) AVCaptureDevice *captureDevice;
@property(nonatomic,strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
@property(nonatomic,assign) BOOL isCapturingImage;
@property(nonatomic,strong) UIImageView *capturedImageView;
@property(nonatomic,strong)UIImagePickerController *picker;
@property(nonatomic,strong) UIView *imageSelectedView;
@property(nonatomic,strong) UIImage *selectedImage;

@end

@implementation PKImagePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    
    NSLog(@"PKImagePickerViewController");
    
    [super viewDidLoad];
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
    // Do any additional setup after loading the view.
    self.captureSession = [[AVCaptureSession alloc]init];
    self.captureSession.sessionPreset = AVCaptureSessionPresetPhoto;
    
    self.capturedImageView = [[UIImageView alloc]init];
    self.capturedImageView.frame = self.view.frame; // just to even it out
    self.capturedImageView.backgroundColor = [UIColor clearColor];
    self.capturedImageView.userInteractionEnabled = YES;
    self.capturedImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.captureSession];
    self.captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.captureVideoPreviewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.captureVideoPreviewLayer];
    
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    if (devices.count > 0) {
        self.captureDevice = devices[0];
    
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:&error];
    
        [self.captureSession addInput:input];
    
        self.stillImageOutput = [[AVCaptureStillImageOutput alloc]init];
        NSDictionary * outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil];
        [self.stillImageOutput setOutputSettings:outputSettings];
        [self.captureSession addOutput:self.stillImageOutput];
    
    
        if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        _captureVideoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
        }
        else if (self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        _captureVideoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationLandscapeRight;
        }
    
        
        UILabel *safety = [[UILabel alloc]init];
        safety.frame = CGRectMake([UIScreen mainScreen].bounds.origin.x-150.0f, [UIScreen mainScreen].bounds.size.height-310.0f, 370.0f, 30.0f);
        [safety setTransform:CGAffineTransformMakeRotation(-M_PI / 2)];
        safety.backgroundColor = [UIColor clearColor];
        safety.font = [UIFont fontWithName:GLOBALTEXTFONT size:21.0f];
        safety.text = @"PLEASE KEEP YOUR DISTANCE";
        safety.textColor = [UIColor whiteColor];
        safety.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:safety];
        
        UILabel *HeaderLbl = [[UILabel alloc]initWithFrame:CGRectMake(85.0f, 20.0f,150.0f, 40.0f)];
        [HeaderLbl setBackgroundColor:[UIColor clearColor]];
        [HeaderLbl setText:@"R E P O R T"];
        [HeaderLbl setTextAlignment:NSTextAlignmentCenter];
        [HeaderLbl setTextColor:[UIColor whiteColor]];
        [HeaderLbl setFont:[UIFont fontWithName:GLOBALTEXTFONT_Light size:25.0f]];
        [self.view addSubview:HeaderLbl];
        
        
        
        UIView *UsBackView8 = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
        
        UsBackView8.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Textfiled"]];
        
        [self.view addSubview:UsBackView8];
  

    UIButton *camerabutton = [[UIButton alloc]initWithFrame:CGRectMake(270.0f, 528.0f, 35, 38)];
    [camerabutton setImage:[UIImage imageNamed:@"Capturebtn"] forState:UIControlStateNormal];
    [camerabutton addTarget:self action:@selector(capturePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [camerabutton setTintColor:[UIColor blueColor]];
    [camerabutton.layer setCornerRadius:20.0];
    [self.view addSubview:camerabutton];
        
        
        UIView *camera = [[UIView alloc]initWithFrame:CGRectMake(260.0f, 525.0f, 60.0f, 45.0f)];
        [camera setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:camera];
        
        UITapGestureRecognizer *cameratap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(capturePhoto:)];
        [camera addGestureRecognizer:cameratap];
        camera.userInteractionEnabled = YES;
    
//    UIButton *flashbutton = [[UIButton alloc]initWithFrame:CGRectMake(5, 5, 30, 31)];
//    [flashbutton setImage:[UIImage imageNamed:@"PKImageBundle.bundle/flash"] forState:UIControlStateNormal];
//    [flashbutton setImage:[UIImage imageNamed:@"PKImageBundle.bundle/flashselected"] forState:UIControlStateSelected];
//    [flashbutton addTarget:self action:@selector(flash:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:flashbutton];
    
//    UIButton *frontcamera = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-50, 5, 47, 25)];
//    [frontcamera setImage:[UIImage imageNamed:@"PKImageBundle.bundle/front-camera"] forState:UIControlStateNormal];
//    [frontcamera addTarget:self action:@selector(showFrontCamera:) forControlEvents:UIControlEventTouchUpInside];
//    [frontcamera setBackgroundColor:[UIColor colorWithWhite:0.3 alpha:0.2]];
//    [self.view addSubview:frontcamera];
    }
    
//    UIButton *album = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-35, CGRectGetHeight(self.view.frame)-40, 27, 27)];
//    [album setImage:[UIImage imageNamed:@"PKImageBundle.bundle/library"] forState:UIControlStateNormal];
//    [album addTarget:self action:@selector(showalbum:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:album];
    
    UIButton *Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 530.0f, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Backbtn];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 526.0f, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [self.view addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    
    self.picker = [[UIImagePickerController alloc]init];
    self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.picker.delegate = self;
    
//    self.imageSelectedView = [[UIView alloc]initWithFrame:self.view.frame];
//    [self.imageSelectedView setBackgroundColor:[UIColor clearColor]];
//    [self.imageSelectedView addSubview:self.capturedImageView];
//    UIView *overlayView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.view.frame)-60, CGRectGetWidth(self.view.frame), 60)];
//    [overlayView setBackgroundColor:[UIColor colorWithWhite:0.2 alpha:0.9]];
//    [self.imageSelectedView addSubview:overlayView];
//    UIButton *selectPhotoButton = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(overlayView.frame)-40, 20, 32, 32)];
//    [selectPhotoButton setImage:[UIImage imageNamed:@"PKImageBundle.bundle/selected"] forState:UIControlStateNormal];
//    [selectPhotoButton addTarget:self action:@selector(photoSelected:) forControlEvents:UIControlEventTouchUpInside];
//    [overlayView addSubview:selectPhotoButton];
//    
//    UIButton *cancelSelectPhotoButton = [[UIButton alloc]initWithFrame:CGRectMake(5, 20, 32, 32)];
//    [cancelSelectPhotoButton setImage:[UIImage imageNamed:@"PKImageBundle.bundle/cancel"] forState:UIControlStateNormal];
//    [cancelSelectPhotoButton addTarget:self action:@selector(cancelSelectedPhoto:) forControlEvents:UIControlEventTouchUpInside];
//    [overlayView addSubview:cancelSelectPhotoButton];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.captureSession startRunning];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.captureSession stopRunning];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
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

            
            
            AreaStr = [NSString stringWithFormat:@"%@,%@,%@",placemark.locality,placemark.country,placemark.postalCode];
            
//            [[NSUserDefaults standardUserDefaults]setObject:AreaStr forKey:@"area"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
            
            
            [locationManager stopUpdatingLocation];
            
            
            
        } else {
            
        }
        
    }];
    
    
    //        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude] forKey:@"lat"];
    //        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude] forKey:@"long"];
    //        [[NSUserDefaults standardUserDefaults]synchronize];
    
    [locationManager stopUpdatingLocation];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)capturePhoto:(id)sender
{
    self.isCapturingImage = YES;
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in _stillImageOutput.connections)
    {
        for (AVCaptureInputPort *port in [connection inputPorts])
        {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] )
            {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) { break; }
    }
    
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        if (imageSampleBuffer != NULL) {
            
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
           capturedImage = [[UIImage alloc]initWithData:imageData scale:1];
            self.isCapturingImage = NO;
            self.capturedImageView.image = capturedImage;
            [self.view addSubview:self.imageSelectedView];
            self.selectedImage = capturedImage;
            MMReportPoleImgViewController *map = [[MMReportPoleImgViewController alloc]init];
            map.MainImage = capturedImage;
            [self.navigationController pushViewController:map animated:NO];
            imageData = nil;
        }
    }];
    
    
}

-(IBAction)flash:(UIButton*)sender
{
    if ([self.captureDevice isFlashAvailable]) {
        if (self.captureDevice.flashActive) {
            if([self.captureDevice lockForConfiguration:nil]) {
                self.captureDevice.flashMode = AVCaptureFlashModeOff;
                [sender setTintColor:[UIColor grayColor]];
                [sender setSelected:NO];
            }
        }
        else {
            if([self.captureDevice lockForConfiguration:nil]) {
                self.captureDevice.flashMode = AVCaptureFlashModeOn;
                [sender setTintColor:[UIColor blueColor]];
                [sender setSelected:YES];
            }
        }
        [self.captureDevice unlockForConfiguration];
    }
}

-(IBAction)showFrontCamera:(id)sender
{
    if (self.isCapturingImage != YES) {
        if (self.captureDevice == [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo][0]) {
            // rear active, switch to front
            self.captureDevice = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo][1];
            
            [self.captureSession beginConfiguration];
            AVCaptureDeviceInput * newInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
            for (AVCaptureInput * oldInput in self.captureSession.inputs) {
                [self.captureSession removeInput:oldInput];
            }
            [self.captureSession addInput:newInput];
            [self.captureSession commitConfiguration];
        }
        else if (self.captureDevice == [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo][1]) {
            // front active, switch to rear
            self.captureDevice = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo][0];
            [self.captureSession beginConfiguration];
            AVCaptureDeviceInput * newInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];
            for (AVCaptureInput * oldInput in self.captureSession.inputs) {
                [self.captureSession removeInput:oldInput];
            }
            [self.captureSession addInput:newInput];
            [self.captureSession commitConfiguration];
        }
        
        // Need to reset flash btn
    }
}
-(IBAction)showalbum:(id)sender
{
    [self presentViewController:self.picker animated:YES completion:nil];
    //
}

//-(IBAction)photoSelected:(id)sender
//{
//    
//    [self dismissViewControllerAnimated:YES completion:^{
//        if ([self.delegate respondsToSelector:@selector(imageSelected:)]) {
//            [self.delegate imageSelected:self.selectedImage];
//        }
//        [self.imageSelectedView removeFromSuperview];
//    }];
//    
//   
//}
//
//-(IBAction)cancelSelectedPhoto:(id)sender
//{
//    [self.imageSelectedView removeFromSuperview];
//}

-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        if ([self.delegate respondsToSelector:@selector(imageSelectionCancelled)]) {
            [self.delegate imageSelectionCancelled];
        }

    }];
    
    MMReportPoleMapViewController *map = [[MMReportPoleMapViewController alloc]init];
    [self.navigationController pushViewController:map animated:YES];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.capturedImageView.image = self.selectedImage;
        [self.view addSubview:self.imageSelectedView];
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
