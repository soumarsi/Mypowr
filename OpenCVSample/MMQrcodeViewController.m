//
//  MMQrcodeViewController.m
//  MeterMaid
//
//  Created by Soumarsi_kundu on 30/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import "MMQrcodeViewController.h"

@interface MMQrcodeViewController ()

@end

@implementation MMQrcodeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    MainView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320,60)];
    MainView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]];
    [self.view addSubview:MainView];
    
    Qrlabl = [[UILabel alloc]initWithFrame:CGRectMake(75.0f, 20.0f,170.0f, 40.0f)];
    [Qrlabl setBackgroundColor:[UIColor clearColor]];
    [Qrlabl setText:@"Q R  V I E W"];
    [Qrlabl setTextAlignment:NSTextAlignmentCenter];
    [Qrlabl setTextColor:[UIColor whiteColor]];
    [Qrlabl setFont:[UIFont fontWithName:@"Helvetica-LT-Light.ttf" size:20.0f]];
    [Qrlabl setFont:[UIFont systemFontOfSize:20.0f]];
    [Qrlabl setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [MainView addSubview:Qrlabl];
    
    
    
    //backbtn View.............
    
    UIView *UsBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 568-42.5f, 320, 42.5f)];
    UsBackView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Backgroundimg"]];
    [MainView addSubview:UsBackView];
    
    //Backbtn .............
    
    Backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [Backbtn setFrame:CGRectMake(25.0f, 528.0f, 54/2, 33)];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateNormal];
    [Backbtn setBackgroundImage:[UIImage imageNamed:@"backbtn"] forState:UIControlStateHighlighted];
    [Backbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [MainView addSubview:Backbtn];
    
    UIView *backview = [[UIView alloc]initWithFrame:CGRectMake(10.0f, 526.0f, 52.0f, 42.5f)];
    [backview setBackgroundColor:[UIColor clearColor]];
    [MainView addSubview:backview];
    
    UITapGestureRecognizer *backtp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back:)];
    [backview addGestureRecognizer:backtp];
    backview.userInteractionEnabled = YES;
    
    ///////////////////////////////////////////////
    scannerView=[[RMScannerView alloc]initWithFrame:CGRectMake(0, 60, 320, 508-42.5f)];
    scannerView.delegate=self;
    [self.view addSubview:scannerView];
    
    //////////////////////////////////////////
    
    [scannerView setVerboseLogging:YES];
    
    [scannerView setAnimateScanner:YES];
    
    [scannerView setDisplayCodeOutline:YES];
    
    [scannerView startCaptureSession];
    
    // Do any additional setup after loading the view.
}
-(void)startNewScannerSession:(id)sender
{
    
    [scannerView stopScanSession];

    [self.navigationController popViewControllerAnimated:NO];

    
    
}
- (void)didScanCode:(NSString *)scannedCode onCodeType:(NSString *)codeType {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Scanned %@", [scannerView humanReadableCodeTypeForCode:codeType]] message:scannedCode delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:@"Re-Scan", nil];
    //    [alert show];
    
  NSString *sendCode=[NSString stringWithFormat:@"%@",scannedCode];
    
   
    
    
}

- (void)errorGeneratingCaptureSession:(NSError *)error {
    [scannerView stopCaptureSession];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unsupported Device" message:@"This device does not have a camera. Run this app on an iOS device that has a camera." delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alert show];
    

    //  self->sessionToggleButton.title = @"Error";
}

- (void)errorAcquiringDeviceHardwareLock:(NSError *)error {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Focus Unavailable" message:@"Tap to focus is currently unavailable. Try again in a little while." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    [alert show];
}

- (BOOL)shouldEndSessionAfterFirstSuccessfulScan {
    // Return YES to only scan one barcode, and then finish - return NO to continually scan.
    // If you plan to test the return NO functionality, it is recommended that you remove the alert view from the "didScanCode:" delegate method implementation
    // The Display Code Outline only works if this method returns NO
    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Re-Scan"])
    {
        [scannerView startScanSession];

        
    } else if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Okay"])
    {
        
        
        
        
    }
}


//back button function..................

-(void)back:(UIButton *)sender{
    
    
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
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
