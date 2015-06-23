#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <opencv2/imgproc/imgproc_c.h>


@interface AbstractOCVViewController : UIViewController <AVCaptureVideoDataOutputSampleBufferDelegate>
{
    __weak IBOutlet UIImageView *_imageView;
    
    AVCaptureSession *_session;
    AVCaptureDevice *_captureDevice;
    
    BOOL _useBackCamera;
    
    CGPoint originPoint;
    UIImage* currentImage;
    float outerRadius;
    float innerRadius;
}



@property (retain) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, retain) UIImage *stillImage;
- (UIImage*)getUIImageFromIplImage:(IplImage *)iplImage;
- (void)didCaptureIplImage:(IplImage *)iplImage;
- (void)didFinishProcessingImage:(IplImage *)iplImage;



- (void)addStillImageOutput;
- (void)captureStillImage;


@end