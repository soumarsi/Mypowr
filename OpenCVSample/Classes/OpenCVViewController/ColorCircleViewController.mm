#import "ColorCircleViewController.h"
#import <opencv2/objdetect/objdetect.hpp>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#import "opencv2/opencv.hpp"
#import "comingImage.h"
#import "MMUsageBudgetViewController.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

using namespace std;
using namespace cv;

#include <iostream>
#include <stdio.h>

@implementation ColorCircleViewController


//- (UIBezierPath *)makeCircleAtLocation:(CGPoint)location radius:(CGFloat)radius
//{
//    self.circleCenter = _location;
//    self.circleRadius = radius;
//
//    UIBezierPath *path = [UIBezierPath bezierPath];
//    [path addArcWithCenter:self.circleCenter
//                    radius:self.circleRadius
//                startAngle:0.0
//                  endAngle:M_PI * 2.0
//                 clockwise:YES];
//
//    return path;
//}
//

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    j = 0;
    //yellow range
    subDic = [[NSMutableDictionary alloc] init];
    _slider.value = 0.122;
    trnsfr = NO;
    [self sliderValueChanged:nil];
    _slider.hidden=YES;
    self.navigationController.navigationBarHidden=YES;
    maincount = 0;
    countm = NO;
    //NSLog(@"......%f......%f........%f........%f",_imageView.frame.origin.x,_imageView.frame.origin.y,_imageView.frame.size.width,_imageView.frame.size.height);
    _imageView.frame = CGRectMake(0,-100, self.view.frame.size.width, self.view.frame.size.height+200);
    [self.view bringSubviewToFront:_imageView];
    
    rioDict = [[NSMutableDictionary alloc] init];
    
    UIButton *backbutton = [[UIButton alloc]initWithFrame:CGRectMake(10.0f, 20.0f, 120.0f, 30.0f)];
    [backbutton setTitle:@"Back" forState:UIControlStateNormal];
    [backbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(Back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
}
- (IBAction)sliderValueChanged:(id)sender
{
    
    double rangeMIN = 0;
    double rangeMAX = 180;
    double step = 10;
    
    _min = rangeMIN + _slider.value * (rangeMAX - rangeMIN - step);
    _max = _min + step;
    
    _labelValue.text = [NSString stringWithFormat:@"%.2f - %.2f", _min, _max];
}


//NO shows RGB image and highlights found circles
//YES shows threshold image
static BOOL _debug = NO;
- (UIImage *)imageWithCVMat:(const cv::Mat&)cvMat
{
    NSData *data = [NSData dataWithBytes:cvMat.data length:cvMat.elemSize() * cvMat.total()];
    
    CGColorSpaceRef colorSpace;
    
    if (cvMat.elemSize() == 1) {
        colorSpace = CGColorSpaceCreateDeviceGray();
    } else {
        colorSpace = CGColorSpaceCreateDeviceRGB();
    }
    
    CGDataProviderRef provider = CGDataProviderCreateWithCFData((__bridge CFDataRef)data);
    
    CGImageRef imageRef = CGImageCreate(cvMat.cols,                                     // Width
                                        cvMat.rows,                                     // Height
                                        8,                                              // Bits per component
                                        8 * cvMat.elemSize(),                           // Bits per pixel
                                        cvMat.step[0],                                  // Bytes per row
                                        colorSpace,                                     // Colorspace
                                        kCGImageAlphaNone | kCGBitmapByteOrderDefault,  // Bitmap info flags
                                        provider,                                       // CGDataProviderRef
                                        NULL,                                           // Decode
                                        false,                                          // Should interpolate
                                        kCGRenderingIntentDefault);                     // Intent
    
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGDataProviderRelease(provider);
    CGColorSpaceRelease(colorSpace);
    
    return image;
}
- (void)didCaptureIplImage:(IplImage *)iplImage
{
    newimageipl =iplImage;
    //ipl image is in BGR format, it needs to be converted to RGB for display in UIImageView
    IplImage *imgRGB = cvCreateImage(cvGetSize(newimageipl), IPL_DEPTH_8U, 3);
    cvCvtColor(newimageipl, imgRGB, CV_BGR2RGB);
    Mat matRGB = Mat(imgRGB);
    
    //ipl imaeg is also converted to HSV; hue is used to find certain color
    IplImage *imgHSV = cvCreateImage(cvGetSize(newimageipl), 8, 3);
    cvCvtColor(iplImage, imgHSV, CV_BGR2HSV);
    
    IplImage *imgThreshed = cvCreateImage(cvGetSize(newimageipl), 8, 1);
    
    //it is important to release all images EXCEPT the one that is going to be passed to
    //the didFinishProcessingImage: method and displayed in the UIImageView
    cvReleaseImage(&newimageipl);
    
    //filter all pixels in defined range, everything in range will be white, everything else
    //is going to be black
    
    //NSLog(@"min... :%f...max..... :%f",_min,_max);
    
    
    cvInRangeS(imgHSV, cvScalar(0,55,55), cvScalar(130, 255, 255), imgThreshed);
    // cvInRangeS(imgHSV, cvScalar(0.11*256, 0.60*256, 0.20*256, 0),cvScalar(0.14*256, 1.00*256, 1.00*256, 0), imgThreshed);
    cvReleaseImage(&imgHSV);
    
    Mat matThreshed = Mat(imgThreshed);
    
    //smooths edges
    cv::GaussianBlur(matThreshed,
                     matThreshed,
                     cv::Size(9,9),
                     2,
                     2);
    
    //debug shows threshold image, otherwise the circles are detected in the
    //threshold image and shown in the RGB image
    if (_debug)
    {
        NSLog(@"maindebug");
        
        cvReleaseImage(&imgRGB);
        [self didFinishProcessingImage:imgThreshed];
    }
    else
    {
        vector<Vec3f> circles;
        //HoughCircles( matThreshed, circles, CV_HOUGH_GRADIENT,2.0,matThreshed.rows/8,174,90,0,60);
        //get circles
        HoughCircles(matThreshed,
                     circles,
                     CV_HOUGH_GRADIENT,
                     2,
                     matThreshed.rows / 8,
                     150,
                     75,
                     10,
                     100);
        NSLog(@"maincount..%d",maincount);
        
        if(maincount > 200)
        {
            countm = YES;
        }
        NSMutableArray *dicaray = [[NSMutableArray alloc] init];
        
        for (size_t i = 0; i < circles.size(); i++)
        {
            cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
            int radius = cvRound(circles[i][2]);
            
            circle(matRGB, center, 3, Scalar(0, 255, 0), -1, 8, 0);
            circle(matRGB, center, radius, Scalar(0,0,255), 3, 8, 0);
            circle(matRGB, center, radius-16, Scalar(0, 255,0), 3, 8, 0);
            
            NSArray *detailsary = [NSArray arrayWithObjects:[NSString stringWithFormat:@"%d",center.x-radius], [NSString stringWithFormat:@"%d",center.y-radius], [NSString stringWithFormat:@"%d",radius*2],[NSString stringWithFormat:@"%d",radius*2], nil];
            
            //            UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake([[NSString stringWithFormat:@"%d",center.x] floatValue], [[NSString stringWithFormat:@"%d",center.y] floatValue], [[NSString stringWithFormat:@"%d",radius] floatValue], 5)];
            //            lineview.backgroundColor = [UIColor redColor];
            //            [_imageView addSubview:lineview];
            
            
            if([rioDict count]<5){
                
                [rioDict setObject:detailsary forKey:[NSString stringWithFormat:@"%zu",i]];
            }
            
            //            CvMat * imagesource = nullptr;
            //
            //            // Transform it into the C++ cv::Mat format
            //            cv::Mat image(imagesource);
            //
            //            // Setup a rectangle to define your region of interest
            //            cv::Rect myROI(center.x-radius, center.y-radius, radius*2,radius*2);
            //
            //            // Crop the full image to that image contained by the rectangle myROI
            //            // Note that this doesn't copy the data
            //            cv::Mat croppedImage = image(myROI);
            //            nextimge = [self imageWithCVMat:croppedImage];
            
            
            
            
            
            line(matRGB, cv::Point(45,317),cv::Point(45,316), Scalar(255,0,0));
            line(matRGB, cv::Point(113,319),cv::Point(113,320), Scalar(255,0,0));
            line(matRGB, cv::Point(179,319),cv::Point(179,321), Scalar(255,0,0));
            long k=i;
            if(circles.size() == 5 ){
                
                //  _imageView=nil;
                
                //                cout << "Circle position x = " << (int)circles[i][0] << ", y = " << (int)circles[i][1] << ", radius = " << (int)circles[i][2] << "\n";
                
                //NSLog(@"....////....%@....////....%@....////....%@",[NSNumber numberWithInt:circles[i][0]],[NSNumber numberWithInt:circles[i][1]],[NSNumber numberWithInt:circles[i][2]]);
                
                [dicaray addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:circles[i][0]]]];
                [dicaray addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:circles[i][1]]]];
                [dicaray addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:circles[i][2]]]];
                
                [subDic setObject:dicaray forKey:[NSString stringWithFormat:@"%ld",k]];
                cv::Point center(cvRound(circles[i][0]), cvRound(circles[i][1]));
                
                int radius = cvRound(circles[i][2]);
                
                circle(matRGB, center, 3, Scalar(0, 255, 0), -1, 8, 0);
                circle(matRGB, center, radius, Scalar(0, 0, 255), 3, 8, 0);
                
                //if(i >= 5){
                
                //  NSLog(@"k...k...%d",k);
                //                    UIGraphicsBeginImageContext(self.view.frame.size);
                //                    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
                //                    UIImage *image = [self savePNGForView:self.view rect:CGRectMake(0,60, 320, 421)];
                //                    UIGraphicsEndImageContext();
                
                //                    _imageView.image = image;
                // NSLog(@"....///....%@",subDic);
                
                if(trnsfr == NO && countm == YES){
                    NSLog(@"here in the image size--%@",@"helloooo");
                    //[self transferOther:image];
                    
                    [self takscren];
                    
                    trnsfr =YES;
                }
                
                //}
                
                k++;
            }
            j++;
        }
        //threshed image is not needed any more and needs to be released
        cvReleaseImage(&imgThreshed);
        
        //imgRGB will be released once it is not needed, the didFinishProcessingImage:
        //method will take care of that
        [self didFinishProcessingImage:imgRGB];
        maincount++;
        // [self didCaptureIplImage:newimageipl];
    }
}
-(void)takscren
{
    _imageView=nil;
    UIImage *image = [self savePNGForView:self.view rect:CGRectMake(0,60, 320, 421)];
    _imageView.image = image;
    
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake([[[rioDict objectForKey:@"0"] objectAtIndex:0] floatValue], [[[rioDict objectForKey:@"0"] objectAtIndex:1] floatValue], [[[rioDict objectForKey:@"0"] objectAtIndex:2] floatValue], 5)];
    lineview.backgroundColor = [UIColor redColor];
    [_imageView addSubview:lineview];
    
    
    
    [self transferOther:image];
    
}
-(UIImage*) savePNGForView:(UIView *)targetView rect:(CGRect)rect
{
    UIImage *image;
    CGPoint pt = rect.origin;
    
    if (UIGraphicsBeginImageContextWithOptions != NULL) {
        UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
    } else {
        UIGraphicsBeginImageContext(rect.size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-(int)pt.x, -(int)pt.y));
    [targetView.layer renderInContext:context];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGRect cropRect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(cropRect.size, targetView.opaque, 1.0f);
    [image drawInRect:cropRect];
    UIImage * customScreenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //UIImageWriteToSavedPhotosAlbum(customScreenShot , nil, nil, nil);
    
    return customScreenShot;
}
- (UIImage *)convertImageToGrayScale:(UIImage *)image
{
    // Create image rectangle with current image width/height
    
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    // Grayscale color space
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    // Create bitmap content with current image size and grayscale colorspace
    
    CGContextRef context = CGBitmapContextCreate(nil, image.size.width, image.size.height, 8, 0, colorSpace, kCGImageAlphaNone);
    
    // Draw image into current context, with specified rectangle
    
    // using previously defined context (with grayscale colorspace)
    
    CGContextDrawImage(context, imageRect, [image CGImage]);
    
    // Create bitmap image info from pixel data in current context
    
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    
    // Create a new UIImage object
    
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    
    
    
    // Release colorspace, context and bitmap information
    
    CGColorSpaceRelease(colorSpace);
    
    CGContextRelease(context);
    
    CFRelease(imageRef);
    
    
    
    // Return the new grayscale image
    
    return newImage;
    
}
-(void)findingInnerCirclePeripheralPixcels
{
    //    AppDelegate *AppObj=[[UIApplication sharedApplication]delegate];
    //    for (int k=0; k<SortedCircleArray.count; k++) {
    //        NSLog(@"centered alimmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
    //
    //        {
    //
    //
    //
    //            ////////////////////////////////////////////////////
    //            int xc,yc,r,x,y,Pk;
    //            xc=[[[SortedCircleArray objectAtIndex:k] objectForKey:@"x"] intValue];
    //            yc=[[[SortedCircleArray objectAtIndex:k] objectForKey:@"y"] intValue];
    //            int rad1=[[[SortedCircleArray objectAtIndex:k] objectForKey:@"r"] intValue];
    //
    //            r=rad1-17;
    //
    //            x=0;
    //            y=r;
    //
    //
    //            NSLog(@"kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk---%d",k);
    //            switch (k) {
    //                case 0:
    //                {
    //                    [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                    [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //
    //
    //                }
    //
    //
    //                    break;
    //
    //                case 1:
    //                {
    //                    [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                    [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //
    //                }
    //
    //                    break;
    //                case 2:
    //                {
    //                    [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                    [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                }
    //                    break;
    //                case 3:
    //                {
    //
    //                    [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                    [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                }
    //
    //                    break;
    //                case 4:
    //                {
    //                    [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                    [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                }
    //
    //                    break;
    //            }
    //
    //
    //
    //
    //            //NSLog(@"first point--xxxx-%d  and ----yyyy---%d",xc+x,yc-y);
    //            //putpixel(xc+x,yc-y,1);
    //
    //
    //            Pk=3-(2*r);
    //
    //            for(x=0;x<=y;x++)
    //            {
    //
    //                if (Pk<0)
    //                {
    //                    y=y;
    //                    Pk=(Pk+(4*x)+6);
    //                }
    //                else
    //                {
    //                    y=y-1;
    //                    Pk=Pk+((4*(x-y)+10));
    //                }
    //
    //                switch (k) {
    //                    case 0:
    //                    {
    //                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //
    //                    }
    //
    //                        break;
    //                    case 1:
    //                    {
    //                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //
    //
    //                    }
    //                        break;
    //                    case 2:
    //                    {
    //
    //                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //
    //                    }
    //
    //                        break;
    //                    case 3:
    //                    {
    //
    //
    //                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //
    //
    //                    }
    //
    //                        break;
    //                    case 4:
    //                    {
    //
    //                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
    //
    //                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
    //                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
    //                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
    //
    //                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
    //
    //                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
    //                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
    //                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
    //
    //
    //                    }
    //
    //                        break;
    //                }
    //
    //
    //
    //
    //            }
    //
    //
    //
    //
    //            
    //            
    //        }
    //        
    //    }
}

-(void)transferOther:(UIImage *)image{
    
    NSLog(@"rioDictrioDict...%@",rioDict);
    
    
    
    
    // Transform it into the C++ cv::Mat format
    //                cv::Mat imagenew(newimageipl);
    //    
    //                // Setup a rectangle to define your region of interest
    //                cv::Rect myROI([[[rioDict objectForKey:@"0"] objectAtIndex:0] integerValue], [[[rioDict objectForKey:@"0"] objectAtIndex:1] integerValue], [[[rioDict objectForKey:@"0"] objectAtIndex:2] integerValue],[[[rioDict objectForKey:@"0"] objectAtIndex:3] integerValue]);
    //    
    //                // Crop the full image to that image contained by the rectangle myROI
    //                // Note that this doesn't copy the data
    //                cv::Mat croppedImage = imagenew(myROI);
    //                nextimge = [self imageWithCVMat:croppedImage];
    
    
    
    
    
    
    
    
    trnsfr =YES;
    UIImage *sendimag = [self convertImageToGrayScale:image];
    comingImage *helpv=[[comingImage alloc]init];
    helpv.cominimg = sendimag;
    helpv.dataary = subDic;
    
    // [[self navigationController] popViewControllerAnimated:NO];
    [self.navigationController pushViewController:helpv animated:YES];
    [_session stopRunning];
    
}
-(void)Back:(UIButton *)sender
{
    MMUsageBudgetViewController *view = [[MMUsageBudgetViewController alloc]init];
    [self.navigationController pushViewController:view animated:NO];
}

@end