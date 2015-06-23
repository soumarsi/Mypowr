//
//  MMQrcodeViewController.h
//  MeterMaid
//
//  Created by Soumarsi_kundu on 30/09/14.
//  Copyright (c) 2014 Esolz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMScannerView.h"
#import "RMOutlineBox.h"

@interface MMQrcodeViewController : UIViewController<RMScannerViewDelegate>{
    
    UIView *MainView;
    UILabel *Qrlabl;
    UIButton *Backbtn;
        RMScannerView *scannerView;
}

@end
