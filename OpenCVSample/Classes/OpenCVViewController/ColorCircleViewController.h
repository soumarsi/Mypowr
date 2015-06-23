#import "AbstractOCVViewController.h"


@interface ColorCircleViewController : AbstractOCVViewController
{
    double _min, _max;
    __weak IBOutlet UISlider *_slider;
    __weak IBOutlet UILabel *_labelValue;
    BOOL FrontCamera;
    BOOL haveImage;
    int j;
    NSMutableDictionary *subDic;
    BOOL trnsfr;
    int maincount;
    BOOL countm;
    UIImage *nextimge;
    NSMutableDictionary *rioDict;
    IplImage *newimageipl;
}

- (IBAction)sliderValueChanged:(id)sender;
@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
//@property CGPoint circleCenter;
//@property CGPoint location;
//@property CGFloat  circleRadius;
//

@end