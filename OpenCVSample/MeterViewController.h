//
//  MeterViewController.h
//  OpenCVSample
//
//  Created by Soumarsi_kundu on 17/11/14.
//
//

#import <UIKit/UIKit.h>

@interface MeterViewController : UIViewController{
    
    UIView *MeterPopView;
    UIButton *MeterCrossButton,*MeterPlusButton;
    NSString *allval;
    UIImageView *MeterImage;
}
@property(nonatomic,strong) NSMutableArray *readingVal;
@end
