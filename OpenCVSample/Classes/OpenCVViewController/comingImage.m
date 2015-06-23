//
//  comingImage.m
//  OpenCVSample
//
//  Created by anirban on 12/11/14.
//
//

#import "comingImage.h"
#import "AppDelegate.h"
#import "MMUsageBudgetViewController.h"
#import "MeterViewController.h"

@interface comingImage ()
{
    
    float xxx;
    
    AppDelegate *AppObj;
}
@property(nonatomic,readwrite) UIImageView *imagecoming;
@property CGPoint circleCenter;
@property CGPoint location;
@property CGFloat  circleRadius;
@property(nonatomic,readwrite) NSMutableArray *CircleArray;
@property(nonatomic,readwrite) NSMutableDictionary *individualCircleDataDict;
@property(nonatomic,readwrite) NSArray *SortedCircleArray;
@property (nonatomic,readwrite) NSMutableArray *FirstKataXArray,*FirstKataYArray,*SecondKataXArray,*SecondKataYArray,*ThirdKataXArray,*ThirdKataYArray,*ForthKataXArray,*ForthKataYArray,*FifthKataXArray,*FifthKataYArray;
@end

@implementation comingImage
@synthesize FirstKataXArray,FirstKataYArray,SecondKataXArray,SecondKataYArray,ThirdKataXArray,ThirdKataYArray,ForthKataXArray,ForthKataYArray,FifthKataXArray,FifthKataYArray;
@synthesize CircleArray,individualCircleDataDict,SortedCircleArray,imagecoming;

- (UIBezierPath *)makeCircleAtLocation:(CGPoint)location radius:(CGFloat)radius
{
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
}

-(void)viewDidAppear:(BOOL)animated
{
    
    //       ////nslog(@"hre in the viewDidAppear of the comming page.....>>>>>>>>>>>>>>>>>>>>>>>>>>");
    //    for (int i=0; i<[SortedCircleArray count]; i++)
    //    {
    //        _location=CGPointMake([[[SortedCircleArray objectAtIndex:i] objectForKey:@"x"] intValue], [[[SortedCircleArray objectAtIndex:i] objectForKey:@"y"] intValue]);
    //
    //        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    //        shapeLayer.path = [[self makeCircleAtLocation:_location radius:[[[SortedCircleArray objectAtIndex:i] objectForKey:@"r"] intValue]] CGPath];
    //        shapeLayer.strokeColor = [[UIColor redColor] CGColor];
    //        shapeLayer.fillColor = nil;
    //        shapeLayer.lineWidth = 2.0;
    //
    //        // Add CAShapeLayer to our view
    //
    //        [self.imagecoming.layer addSublayer:shapeLayer];
    //
    //    }
    //
    ////    MMUsageBudgetViewController *helpv=[[MMUsageBudgetViewController alloc]init];
    ////    helpv.readingVal = allreadingVal;
    ////    helpv.yesfrm = YES;
    ////    // [[self navigationController] popViewControllerAnimated:NO];
    ////    [self.navigationController pushViewController:helpv animated:YES];
    
    
}
- (void)viewDidLoad {
    
    
    allreadingVal = [[NSMutableArray alloc] init];
    [allreadingVal removeAllObjects];
    int i;
    for(i=0;i<5;i++){
        [allreadingVal addObject:[NSString stringWithFormat:@"%d",(int)0 + arc4random() % (9-0+1)]];
    }
    
    
    
    MeterViewController *helpv = [[MeterViewController alloc]init];
    helpv.readingVal = allreadingVal;
    [self.navigationController pushViewController:helpv animated:YES];
    
    ////nslog(@"hre in the didload of the comming page.....>>>>>>>>>>>>>>>>>>>>>>>>>>");
    //    [super viewDidLoad];
    //
    //    self.view.backgroundColor = [UIColor whiteColor];
    //
    //    imagecoming = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,[[UIScreen mainScreen]bounds].size.width, [[UIScreen mainScreen]bounds].size.height)];
    //    imagecoming.image = _cominimg;
    //    imagecoming.contentMode = UIViewContentModeScaleToFill;
    //    imagecoming.clipsToBounds =YES;
    //    [self.view addSubview:imagecoming];
    //
    //    xxx=20;
    //
    //    FirstKataXArray=[[NSMutableArray alloc]init];
    //    FirstKataYArray=[[NSMutableArray alloc]init];
    //
    //    SecondKataXArray=[[NSMutableArray alloc]init];
    //    SecondKataYArray=[[NSMutableArray alloc]init];
    //
    //    ThirdKataXArray=[[NSMutableArray alloc]init];
    //    ThirdKataYArray=[[NSMutableArray alloc]init];
    //
    //    ForthKataXArray=[[NSMutableArray alloc]init];
    //    ForthKataYArray=[[NSMutableArray alloc]init];
    //
    //    FifthKataXArray=[[NSMutableArray alloc]init];
    //    FifthKataYArray=[[NSMutableArray alloc]init];
    //
    //    AppObj=[[UIApplication sharedApplication]delegate];
    //
    //    /*
    //     (
    //     117,
    //     169,
    //     29,
    //     49,
    //     169,
    //     31,
    //     247,
    //     173,
    //     27,
    //     177,
    //     169,
    //     31,
    //     311,
    //     171,
    //     32
    //     )*/
    //
    //    CircleArray=[[NSMutableArray alloc]init];
    //    NSMutableArray *someary = [[NSMutableArray alloc] init];
    //    someary = [_dataary objectForKey:@"4"];
    //    ////nslog(@"dataarray------> %@" , _dataary);
    //
    //    // ////nslog(@"somearay...%lu  count--%lu   sorted--%@",someary.count%3,(unsigned long)someary.count,someary);
    //    if (someary.count%3==0) {
    //        ////nslog(@"hhhhhhhhh");
    //        int k=0;
    //        for (int j=0; j<someary.count; j+=3) {
    //
    //             [CircleArray addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:[[someary objectAtIndex:j] intValue]],@"x",[NSNumber numberWithInt:[[someary objectAtIndex:j+1] intValue]],@"y",[NSNumber numberWithInt:[[someary objectAtIndex:j+2] intValue]],@"r", nil]];
    //            ////nslog(@"heree----%d",k);
    //          }
    //    }
    //
    //    NSSortDescriptor *sd1 = [NSSortDescriptor sortDescriptorWithKey:@"x" ascending:YES];
    //
    //    SortedCircleArray= [CircleArray sortedArrayUsingDescriptors:@[sd1]];
    //    ////nslog(@"the fffffffffffffffff---%@",SortedCircleArray);
    //
    //    [self findingInnerCirclePeripheralPixcels];
    //    ////nslog(@"circlexarray1----------> %@-------------> %@",AppObj.CirclePeripheral1PointsXDataArray,AppObj.CirclePeripheral1PointsYDataArray);
    //    ////nslog(@"circlexarray2----------> %@-------------> %@",AppObj.CirclePeripheral2PointsXDataArray,AppObj.CirclePeripheral2PointsYDataArray);
    //    ////nslog(@"circlexarray3----------> %@-------------> %@",AppObj.CirclePeripheral3PointsXDataArray,AppObj.CirclePeripheral3PointsYDataArray);
    //    ////nslog(@"circlexarray4----------> %@-------------> %@",AppObj.CirclePeripheral4PointsXDataArray,AppObj.CirclePeripheral4PointsYDataArray);
    //    ////nslog(@"circlexarray5----------> %@-------------> %@",AppObj.CirclePeripheral5PointsXDataArray,AppObj.CirclePeripheral5PointsYDataArray);
    //
    //
    //    //[self OwnHands];
    //
    //    for (int i=0; i<[AppObj.CirclePeripheral1PointsXDataArray count]; i++) {
    //        //////nslog(@"the circle111-xxx-%@  circle1111-yyyy-%@",[AppObj.CirclePeripheral1PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral1PointsYDataArray objectAtIndex:i]);
    //    }
    //
    //    for (int i=0; i<[AppObj.CirclePeripheral2PointsXDataArray count]; i++) {
    //        //////nslog(@"the circle2222-xxx-%@  circle22222-yyyy-%@",[AppObj.CirclePeripheral2PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral2PointsYDataArray objectAtIndex:i]);
    //    }
    //
    //    for (int i=0; i<[AppObj.CirclePeripheral3PointsXDataArray count]; i++) {
    //        //////nslog(@"the circle3333-xxx-%@  circle333333-yyyy-%@",[AppObj.CirclePeripheral3PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral3PointsYDataArray objectAtIndex:i]);
    //    }
    //
    //    for (int i=0; i<[AppObj.CirclePeripheral4PointsXDataArray count]; i++) {
    //        //////nslog(@"the circle44444-xxx-%@  circle44444-yyyy-%@",[AppObj.CirclePeripheral4PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral4PointsYDataArray objectAtIndex:i]);
    //    }
    //
    //
    //    for (int i=0; i<[AppObj.CirclePeripheral5PointsXDataArray count]; i++) {
    //        //////nslog(@"the circle55555-xxx-%@  555555-yyyy-%@",[AppObj.CirclePeripheral5PointsXDataArray objectAtIndex:i],[AppObj.CirclePeripheral5PointsYDataArray objectAtIndex:i]);
    //    }
    //
    //    CGRect PreFrame=CGRectMake(20, 0, 0, 0);
    //    for (int i=0; i<5; i++) {
    //        UILabel *SampleView=[[UILabel alloc]initWithFrame:CGRectMake(PreFrame.origin.x, 263, 30, 30)];
    //        SampleView.tag=i;
    //        SampleView.textColor=[UIColor blackColor];
    //        PreFrame=SampleView.frame;
    //        PreFrame.origin.x=SampleView.frame.origin.x+SampleView.frame.size.width+10;
    //       // [self.view addSubview:SampleView];
    //        SampleView.backgroundColor=RGBCOLOR1(.4, .4, .4, 1);
    //    }
    
}

-(void)OwnHands
{
    
    //////nslog(@" ");
    AppDelegate *appObj=[[UIApplication sharedApplication]delegate];
    
    // ////nslog(@"the circle dataYarr count---%d",[SortedCircleArray count]);
    // if ([SortedCircleArray count]==5) {
    
    if ([FirstKataXArray count]>0) {
        [FirstKataXArray removeAllObjects];
        [FirstKataYArray removeAllObjects];
    }
    if ([SecondKataXArray count]>0) {
        [SecondKataXArray removeAllObjects];
        [SecondKataYArray removeAllObjects];
    }
    if ([ThirdKataXArray count]>0) {
        [ThirdKataXArray removeAllObjects];
        [ThirdKataYArray removeAllObjects];
    }
    if ([ForthKataXArray count]>0) {
        [ForthKataXArray removeAllObjects];
        [ForthKataXArray removeAllObjects];
    }
    if ([FifthKataXArray count]>0) {
        [FifthKataXArray removeAllObjects];
        [FifthKataXArray removeAllObjects];
    }
    
    
    //
    //
    //    ////nslog(@"count------> %d", [SortedCircleArray  count]);
    
    for (int i=0;i<[SortedCircleArray  count]; i++)
    {
        
        for (int i=0; i<[appObj.CirclePeripheral1PointsXDataArray count]; i++)
        {
            
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral1PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral1PointsYDataArray objectAtIndex:i] intValue]count:[appObj.CirclePeripheral1PointsXDataArray count]]];
            //////nslog(@"-1111111111-->>>>>>>>>>%@  and the xposition--%d  and yyy position---%d",Arr, [[appObj.CirclePeripheral1PointsXDataArray objectAtIndex:i] intValue],[[appObj.CirclePeripheral1PointsYDataArray objectAtIndex:i] intValue]);
            
            
            ////nslog(@"array-----> %@",Arr);
            
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            
            
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [FirstKataXArray addObject:[appObj.CirclePeripheral1PointsXDataArray objectAtIndex:i]];
                [FirstKataYArray addObject:[appObj.CirclePeripheral1PointsYDataArray objectAtIndex:i]];
                
            }
            
        }
        
        for (int i=0; i<[appObj.CirclePeripheral2PointsXDataArray count]; i++)
        {
            
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral2PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral2PointsYDataArray objectAtIndex:i] intValue]count:[appObj.CirclePeripheral2PointsXDataArray count]]];
            
            ////nslog(@"array1-----> %@",Arr);
            
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [SecondKataXArray addObject:[appObj.CirclePeripheral2PointsXDataArray objectAtIndex:i]];
                [SecondKataYArray addObject:[appObj.CirclePeripheral2PointsYDataArray objectAtIndex:i]];
                
            }
            
        }
        
        for (int i=0; i<[appObj.CirclePeripheral3PointsXDataArray count]; i++)
        {
            
            
            // ////nslog(@"circlearray------> %@",appObj.CirclePeripheral3PointsXDataArray);
            
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral3PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral3PointsYDataArray objectAtIndex:i] intValue]count:[appObj.CirclePeripheral3PointsXDataArray count]]];
            // ////nslog(@"--33333333->>>>>>>>>>%@  and the xposition--%d  and yyy position---%d",Arr, [[appObj.CirclePeripheral3PointsXDataArray objectAtIndex:i] intValue],[[appObj.CirclePeripheral3PointsYDataArray objectAtIndex:i] intValue]);
            
            ////nslog(@"array2-----> %@",Arr);
            
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            
            
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [ThirdKataXArray addObject:[appObj.CirclePeripheral3PointsXDataArray objectAtIndex:i]];
                [ThirdKataYArray addObject:[appObj.CirclePeripheral3PointsYDataArray objectAtIndex:i]];
                
            }
        }
        //                break;
        //            case 3:
        for (int i=0; i<[appObj.CirclePeripheral4PointsXDataArray count]; i++)
        {
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral4PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral4PointsYDataArray objectAtIndex:i] intValue]count:[appObj.CirclePeripheral4PointsXDataArray count]]];
            //  ////nslog(@"--4444444->>>>>>>>>>%@  and the xposition--%d  and yyy position---%d",Arr, [[appObj.CirclePeripheral4PointsXDataArray objectAtIndex:i] intValue],[[appObj.CirclePeripheral4PointsYDataArray objectAtIndex:i] intValue]);
            
            ////nslog(@"array3-----> %@",Arr);
            
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            
            
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [ForthKataXArray addObject:[appObj.CirclePeripheral4PointsXDataArray objectAtIndex:i]];
                [ForthKataYArray addObject:[appObj.CirclePeripheral4PointsYDataArray objectAtIndex:i]];
                
            }
            
            
            
            /////////////////////////////
        }
        
        //                break;
        //            case 4:
        for (int i=0; i<[appObj.CirclePeripheral5PointsXDataArray count]; i++)
        {
            NSArray *Arr=[NSArray arrayWithArray:[self getRGBAFromImage:self.cominimg atx:[[appObj.CirclePeripheral5PointsXDataArray objectAtIndex:i] intValue] atY:[[appObj.CirclePeripheral5PointsYDataArray objectAtIndex:i] intValue]count:[appObj.CirclePeripheral5PointsXDataArray count]]];
            // ////nslog(@"-555555555555555-->>>>>>>>>>%@  and the xposition--%d  and yyy position---%d",Arr, [[appObj.CirclePeripheral5PointsXDataArray objectAtIndex:i] intValue],[[appObj.CirclePeripheral5PointsYDataArray objectAtIndex:i] intValue]);
            
            ////nslog(@"array4-----> %@",Arr);
            
            NSString *FirstStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:1 ];
            int FirstValue;
            if ([FirstStr length]>1) {
                FirstValue= [[[[FirstStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                FirstValue=[FirstStr intValue];
            }
            
            NSString *SecondStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:2 ];
            int SecondValue;
            if ([SecondStr length]>1) {
                SecondValue= [[[[SecondStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                SecondValue=[SecondStr intValue];
            }
            
            
            NSString *ThirdStr=[[[NSString stringWithFormat:@"%@",[Arr objectAtIndex:0]] componentsSeparatedByString:@" "] objectAtIndex:3 ];
            int ThirdValue;
            if ([ThirdStr length]>1) {
                ThirdValue= [[[[ThirdStr componentsSeparatedByString:@"."] objectAtIndex:1] substringWithRange:NSMakeRange(0, 1)] intValue];
            } else {
                ThirdValue=[ThirdStr intValue];
            }
            
            
            if (FirstValue<=5 && SecondValue<=5 && ThirdValue<=5)
            {
                [FifthKataXArray addObject:[appObj.CirclePeripheral5PointsXDataArray objectAtIndex:i]];
                [FifthKataYArray addObject:[appObj.CirclePeripheral5PointsYDataArray objectAtIndex:i]];
                
            }
            
        }
        
    }
    
    ///end of for1
    
    
    
    
    int  FirstKataMinX,FirstKataMinY,FirstKataMaxX,FirstKataMaxY;
    int SecondKataMinX,SecondKataMinY,SecondKataMaxX,SecondKataMaxY;
    int ThirdKataMinX,ThirdKataMinY,ThirdKataMaxX,ThirdKataMaxY;
    int ForthKataMinX,ForthKataMinY,ForthKataMaxX,ForthKataMaxY;
    int FifthKataMinX,FifthKataMinY,FifthKataMaxX,FifthKataMaxY;
    
    
    if ([FirstKataXArray count]>0&& [SecondKataXArray count]>0&&[ThirdKataXArray count]>0 &&[ForthKataXArray count]>0 &&[FifthKataXArray count]>0) {
        
        //case 0:
        //    {
        //        ////nslog(@"---%@",FirstKataXArray);
        FirstKataMinX=[[FirstKataXArray objectAtIndex:0] intValue];
        FirstKataMinY=[[FirstKataYArray objectAtIndex:0] intValue];
        
        FirstKataMaxX=[[FirstKataXArray objectAtIndex:0] intValue];
        FirstKataMaxY=[[FirstKataYArray objectAtIndex:0] intValue];
        for (int i=1; i<[FirstKataXArray count]; i++)
        {
            //       ////nslog(@"-----FirstKataXArray--%d  and FirstKataYArray---%d",[[FirstKataXArray objectAtIndex:i] intValue],[[FirstKataYArray objectAtIndex:i] intValue]);
            
            
            if (FirstKataMinX>[[FirstKataXArray objectAtIndex:i] intValue]) {
                FirstKataMinX=[[FirstKataXArray objectAtIndex:i] intValue];
            }
            
            if (FirstKataMaxX<[[FirstKataXArray objectAtIndex:i] intValue]) {
                FirstKataMaxX=[[FirstKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (FirstKataMinY>[[FirstKataYArray objectAtIndex:i] intValue]) {
                
                FirstKataMinY=[[FirstKataYArray objectAtIndex:i] intValue];
            }
            if (FirstKataMaxY <[[FirstKataYArray objectAtIndex:i] intValue]) {
                FirstKataMaxY=[[FirstKataYArray objectAtIndex:i] intValue];
            }
        }
        
        SecondKataMinX=[[SecondKataXArray objectAtIndex:0]intValue];
        SecondKataMinY=[[SecondKataYArray objectAtIndex:0]intValue];
        
        SecondKataMaxX=[[SecondKataXArray objectAtIndex:0]intValue];
        SecondKataMaxY=[[SecondKataYArray objectAtIndex:0]intValue];
        
        
        for (int i=1; i<[SecondKataYArray count]; i++)
        {
            
            if (SecondKataMinX>[[SecondKataXArray objectAtIndex:i] intValue]) {
                SecondKataMinX=[[SecondKataXArray objectAtIndex:i] intValue];
            }
            
            if (SecondKataMaxX<[[SecondKataXArray objectAtIndex:i] intValue]) {
                SecondKataMaxX=[[SecondKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (SecondKataMinY>[[SecondKataYArray objectAtIndex:i] intValue]) {
                
                SecondKataMinY=[[SecondKataYArray objectAtIndex:i] intValue];
            }
            if (SecondKataMaxY <[[SecondKataYArray objectAtIndex:i] intValue]) {
                SecondKataMaxY=[[SecondKataYArray objectAtIndex:i] intValue];
            }
            
            
            
        }
        
        ThirdKataMinX=[[ThirdKataXArray objectAtIndex:0]intValue];
        ThirdKataMinY=[[ThirdKataYArray objectAtIndex:0]intValue];
        
        ThirdKataMaxX=[[ThirdKataXArray objectAtIndex:0]intValue];
        ThirdKataMaxY=[[ThirdKataYArray objectAtIndex:0]intValue];
        
        
        for (int i=1; i<[ThirdKataXArray count]; i++) {
            
            if (ThirdKataMinX>[[ThirdKataXArray objectAtIndex:i] intValue]) {
                ThirdKataMinX=[[ThirdKataXArray objectAtIndex:i] intValue];
            }
            
            if (ThirdKataMaxX<[[ThirdKataXArray objectAtIndex:i] intValue]) {
                ThirdKataMaxX=[[ThirdKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (ThirdKataMinY>[[ThirdKataYArray objectAtIndex:i] intValue]) {
                
                ThirdKataMinY=[[ThirdKataYArray objectAtIndex:i] intValue];
            }
            if (ThirdKataMaxY <[[ThirdKataYArray objectAtIndex:i] intValue]) {
                ThirdKataMaxY=[[ThirdKataYArray objectAtIndex:i] intValue];
            }
            
            
        }
        
        ForthKataMinX=[[ForthKataXArray objectAtIndex:0]intValue];
        ForthKataMinY=[[ForthKataYArray objectAtIndex:0]intValue];
        
        ForthKataMaxX=[[ForthKataXArray objectAtIndex:0]intValue];
        ForthKataMaxY=[[ForthKataYArray objectAtIndex:0]intValue];
        
        for (int i=1; i<[ForthKataXArray count]; i++) {
            
            // ////nslog(@"-----fothkataxarray--%d  and forthkatayarray---%d",[[ForthKataXArray objectAtIndex:i] intValue],[[ForthKataYArray objectAtIndex:i] intValue]);
            
            if (ForthKataMinX>[[ForthKataXArray objectAtIndex:i] intValue]) {
                ForthKataMinX=[[ForthKataXArray objectAtIndex:i] intValue];
            }
            
            if (ForthKataMaxX<[[ForthKataXArray objectAtIndex:i] intValue]) {
                ForthKataMaxX=[[ForthKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (ForthKataMinY>[[ForthKataYArray objectAtIndex:i] intValue]) {
                
                ForthKataMinY=[[ForthKataYArray objectAtIndex:i] intValue];
            }
            if (ForthKataMaxY <[[ForthKataYArray objectAtIndex:i] intValue]) {
                ForthKataMaxY=[[ForthKataYArray objectAtIndex:i] intValue];
            }
            
            
            
        }
        
        FifthKataMinX=[[FifthKataXArray objectAtIndex:0]intValue];
        FifthKataMinY=[[FifthKataYArray objectAtIndex:0]intValue];
        
        FifthKataMaxX=[[FifthKataXArray objectAtIndex:0]intValue];
        FifthKataMaxY=[[FifthKataYArray objectAtIndex:0]intValue];
        
        
        for (int i=1; i<[FifthKataXArray count]; i++)
        {
            if (FifthKataMinX>[[FifthKataXArray objectAtIndex:i] intValue]) {
                FifthKataMinX=[[FifthKataXArray objectAtIndex:i] intValue];
            }
            
            if (FifthKataMaxX<[[FifthKataXArray objectAtIndex:i] intValue]) {
                FifthKataMaxX=[[FifthKataXArray objectAtIndex:i] intValue];
            }
            
            
            if (FifthKataMinY>[[FifthKataYArray objectAtIndex:i] intValue]) {
                
                FifthKataMinY=[[FifthKataYArray objectAtIndex:i] intValue];
            }
            if (FifthKataMaxY <[[FifthKataYArray objectAtIndex:i] intValue]) {
                FifthKataMaxY=[[FifthKataYArray objectAtIndex:i] intValue];
            }
            
            
        }
        
        //}
        
        
        
        ///////me
        
        // end of for2
        
        
        //        ////nslog(@"firtskata minx--%d  firstkatamin y--%d  firstkatamaxx--%d  firstkatamaxy--%d",FirstKataMinX,FirstKataMinY,FirstKataMaxX,FirstKataMaxY);
        //
        //
        //
        //        ////nslog(@"secondkata minx--%d  secondkatamin y--%d  secondkatamax--%d  secondkatamaxyyy--%d",SecondKataMinX,SecondKataMinY,SecondKataMaxX,SecondKataMaxY);
        //
        //
        //
        //        ////nslog(@"thidkata minx--%d  thidkata min y--%d  thirdkata amax--%d  thirdkata maxyyy--%d",ThirdKataMinX,ThirdKataMinY,ThirdKataMaxX,ThirdKataMaxY);
        //
        //        //
        //        ////nslog(@"forthkata minx--%d  forthkata min y--%d  forthkata amax--%d  forthkata maxyyy--%d",ForthKataMinX,ForthKataMinY,ForthKataMaxX,ForthKataMaxY);
        //
        //
        //
        //
        //        ////nslog(@"fifthkata minx--%d  fifthkata min y--%d  fifthkata amax--%d  fifthkata maxyyy--%d",FifthKataMinX,FifthKataMinY,FifthKataMaxX,FifthKataMaxY);
        
        
        
        // float  angleInDegrees = arctan(deltaY / deltaX) * 180 / PI;
        
        
        
        
        
        
        //        float  firstkataAngle = atan2(30,-1) * 180 / 22*7;
        //        float  SecondkataAngle = atan2(30,-2) * 180 / 22*7;
        //        float  ThirdkataAngle = atan2(24,6) * 180 / 22*7;
        //        float  ForthkataAngle = atan2(-29,-3) * 180 / 22*7;
        //        float  FifthkataAngle = atan2(2,-31) * 180 / 22*7;
        
        NSMutableArray *arr =[[NSMutableArray alloc]init];
        for (int i=0; i<[SortedCircleArray count]; i++) {
            switch (i) {
                case 0:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(FirstKataMaxX+FirstKataMinX)/2],@"x",[NSNumber numberWithFloat:(FirstKataMaxY+FirstKataMinY)/2],@"y", nil]];
                }
                    
                    
                    break;
                    
                case 1:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(SecondKataMaxX+SecondKataMinX)/2],@"x",[NSNumber numberWithFloat:(SecondKataMaxY+SecondKataMinY)/2],@"y", nil]];
                    
                }
                    
                    break;
                    
                case 2:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(ThirdKataMaxX+ThirdKataMinX)/2],@"x",[NSNumber numberWithFloat:(ThirdKataMaxY+ThirdKataMinY)/2],@"y", nil]];
                }
                    
                    break;
                    
                case 3:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(ForthKataMaxX+ForthKataMinX)/2],@"x",[NSNumber numberWithFloat:(ForthKataMaxY+ForthKataMinY)/2],@"y", nil]];
                }
                    break;
                    
                case 4:
                {
                    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(FifthKataMaxX+FifthKataMinX)/2],@"x",[NSNumber numberWithFloat:(FifthKataMaxY+FifthKataMinY)/2],@"y", nil]];
                }
                    
                    break;
                    
                    
            }
            
            
        }
        
        //              NSArray *arr =[[NSArray alloc]initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(FirstKataMaxX+FirstKataMinX)/2],@"x",[NSNumber numberWithFloat:(FirstKataMaxY+FirstKataMinY)/2],@"y", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(SecondKataMaxX+SecondKataMinX)/2],@"x",[NSNumber numberWithFloat:(SecondKataMaxY+SecondKataMinY)/2],@"y", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(ThirdKataMaxX+ThirdKataMinX)/2],@"x",[NSNumber numberWithFloat:(ThirdKataMaxY+ThirdKataMinY)/2],@"y", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(ForthKataMaxX+ForthKataMinX)/2],@"x",[NSNumber numberWithFloat:(ForthKataMaxY+ForthKataMinY)/2],@"y", nil],[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:(FifthKataMaxX+FifthKataMinX)/2],@"x",[NSNumber numberWithFloat:(FifthKataMaxY+FifthKataMinY)/2],@"y", nil], nil];
        
        
        //                NSArray *arr1 = @[
        //                                 @{@"count": @{@"x": @5,@"y": @5} },
        //                                 @{@"count": @{@"x": @9,@"y": @5} },
        //                                 @{@"count": @{@"x": @1,@"y": @5} },
        //                                 @{@"count": @{@"x": @100,@"y": @5} },
        //                                 ];
        //    ////nslog(@"here in the arrrrrrrrrrrrrrrr11111--%@",arr1);
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"x" ascending:YES];
        
        NSArray *arr2 = [arr sortedArrayUsingDescriptors:@[sd]];
        //////nslog(@"the fffffffffffffffff---%@",arr2);
        float  firstkataAngle,SecondkataAngle,ThirdkataAngle,ForthkataAngle,FifthkataAngle;
        firstkataAngle=SecondkataAngle=ThirdkataAngle=ForthkataAngle=FifthkataAngle=0.0;
        NSMutableArray *AngleArray=[[NSMutableArray alloc]init];
        for (int i=0; i<[SortedCircleArray count]; i++) {
            switch (i) {
                case 0:
                {
                    firstkataAngle = atan2([[[SortedCircleArray objectAtIndex:0] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:0] objectForKey:@"y"] intValue],[[[SortedCircleArray objectAtIndex:0] objectForKey:@"x"] intValue]-[[[arr2 objectAtIndex:0] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    
                    [AngleArray addObject:[NSNumber numberWithFloat:firstkataAngle]];
                }
                    break;
                    
                case 1:
                {
                    SecondkataAngle = atan2([[[SortedCircleArray objectAtIndex:1] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:1] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:1] objectForKey:@"x"] intValue]-[[[SortedCircleArray objectAtIndex:1] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    [AngleArray addObject:[NSNumber numberWithFloat:SecondkataAngle]];
                }
                    break;
                case 2:
                {
                    ThirdkataAngle = atan2([[[SortedCircleArray objectAtIndex:2] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:2] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:2] objectForKey:@"x"] intValue]-[[[SortedCircleArray objectAtIndex:2] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    
                    [AngleArray addObject:[NSNumber numberWithFloat:ThirdkataAngle]];
                }
                    break;
                case 3:
                {
                    ForthkataAngle = atan2([[[SortedCircleArray objectAtIndex:3] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:3] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:3] objectForKey:@"x"] intValue]-[[[SortedCircleArray objectAtIndex:3] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    [AngleArray addObject:[NSNumber numberWithFloat:ForthkataAngle]];
                }
                    break;
                case 4:
                {
                    FifthkataAngle = atan2([[[SortedCircleArray objectAtIndex:4] objectForKey:@"y"] intValue]-[[[arr2 objectAtIndex:4] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:4] objectForKey:@"x"] intValue]-[[[SortedCircleArray objectAtIndex:4] objectForKey:@"x"] intValue]) * 180 / 22*7;
                    [AngleArray addObject:[NSNumber numberWithFloat:FifthkataAngle]];
                }
                    break;
                    
                    
                    
            }
        }
        
        
        
        
        
        
        
        
        
        //////nslog(@"-->%d  --->%d-->%d---%d",[[[SortedCircleArray objectAtIndex:4] objectForKey:@"y"] intValue],[[[arr2 objectAtIndex:4] objectForKey:@"y"] intValue],[[[SortedCircleArray objectAtIndex:4] objectForKey:@"x"] intValue],[[[arr2 objectAtIndex:4] objectForKey:@"x"] intValue]);
        
        
        //          ////nslog(@"first average---xxx--%d  averageyyy--%d",(FirstKataMaxX+FirstKataMinX)/2,(FirstKataMaxY+FirstKataMinY)/2);
        //          ////nslog(@"second  average---xxx--%d  averageyyy--%d",(SecondKataMaxX+SecondKataMinX)/2,(SecondKataMaxY+SecondKataMinY)/2);
        //          ////nslog(@"third  average---xxx--%d  averageyyy--%d",(ThirdKataMaxX+ThirdKataMinX)/2,(ThirdKataMaxY+ThirdKataMinY)/2);
        //          ////nslog(@"forth average---xxx--%d  averageyyy--%d",(ForthKataMaxX+ForthKataMinX)/2,(ForthKataMaxY+ForthKataMinY)/2);
        //          ////nslog(@"fifth  average---xxx--%d  averageyyy--%d",(FifthKataMaxX+FifthKataMinX)/2,(FifthKataMaxY+FifthKataMinY)/2);
        // ////nslog(@"firstkataAngle---->>%f SecondkataAngle-->%f ThirdkataAngle-->%f  ForthkataAngle-->%f  FifthkataAngle-->%f ",firstkataAngle,SecondkataAngle,ThirdkataAngle,ForthkataAngle,FifthkataAngle);
        
        //  NSMutableArray *AngleArray=[[NSMutableArray alloc]initWithObjects:[NSNumber numberWithFloat:firstkataAngle],[NSNumber numberWithFloat:SecondkataAngle],[NSNumber numberWithFloat:ThirdkataAngle],[NSNumber numberWithFloat:ForthkataAngle],[NSNumber numberWithFloat:FifthkataAngle], nil];
        
        
        for (int i=0; i<[AngleArray count]; i++) {
            
            switch (i)
            {
                case 0:
                case 2:
                case 4:
                    [self FindingTheRegionInClockWise:[[AngleArray objectAtIndex:i] floatValue] AndClockNo:i];
                    break;
                case 1:
                case 3:
                    [self FindingTheRegionInAntiClockWise:[[AngleArray objectAtIndex:i] floatValue] AndClockNo:i];
                    break;
                    
                    
                    
            }
            
        }
        
        
        
        
    } else {
        UIAlertView *Al=[[UIAlertView alloc]initWithTitle:@"message" message:@"scan again" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [Al delegate];
        [Al show];
    }
    /////me
    
    
    
    
    // }
    
    
    
}
-(void)findingInnerCirclePeripheralPixcels
{
    
    for (int k=0; k<SortedCircleArray.count; k++) {
        
        
        //////nslog(@"centered alimmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
        
        {
            
            
            
            ////////////////////////////////////////////////////
            int xc,yc,r,x,y,Pk;
            xc=[[[SortedCircleArray objectAtIndex:k] objectForKey:@"x"] intValue];
            yc=[[[SortedCircleArray objectAtIndex:k] objectForKey:@"y"] intValue];
            int rad1=[[[SortedCircleArray objectAtIndex:k] objectForKey:@"r"] intValue];
            
            r=rad1-17;
            
            x=0;
            y=r;
            
            
            // ////nslog(@"kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk---%d",k);
            switch (k) {
                case 0:
                {
                    [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                    
                }
                    break;
                    
                case 1:
                {
                    [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                    
                }
                    break;
                case 2:
                {
                    [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                }
                    break;
                case 3:
                {
                    [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                }
                    
                    break;
                case 4:
                {
                    [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                    [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                    
                }
                    
                    break;
            }
            
            
            
            
            //////nslog(@"first point--xxxx-%d  and ----yyyy---%d",xc+x,yc-y);
            //putpixel(xc+x,yc-y,1);
            
            
            Pk=3-(2*r);
            
            for(x=0;x<=y;x++)
            {
                
                if (Pk<0)
                {
                    y=y;
                    Pk=(Pk+(4*x)+6);
                }
                else
                {
                    y=y-1;
                    Pk=Pk+((4*(x-y)+10));
                }
                
                switch (k) {
                    case 0:
                    {
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral1PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral1PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                    }
                        
                        break;
                    case 1:
                    {
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral2PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral2PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                        
                    }
                        break;
                    case 2:
                    {
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral3PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral3PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                    }
                        
                        break;
                    case 3:
                    {
                        
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral4PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral4PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                        
                    }
                        
                        break;
                    case 4:
                    {
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-y]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+x]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-x]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+y]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc-x]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc+y]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        [AppObj.CirclePeripheral5PointsXDataArray addObject:[NSNumber numberWithInt:xc-y]];
                        [AppObj.CirclePeripheral5PointsYDataArray addObject:[NSNumber numberWithInt:yc+x]];
                        
                        
                    }
                        break;
                }
            }
        }
    }
    
}

-(void)FindingTheRegionInClockWise:(float)Angle AndClockNo:(int)ClockNo
{
    //////nslog(@"finding FindingTheRegionInClockWise reading here............");
    int ClockReading;
    
    if (Angle>0.0) {
        if (Angle>= 0.0 && Angle<=36.0) {
            ClockReading=2;
            
        }
        else if (Angle>=36.1 && Angle<=72.0) {
            ClockReading=1;
        }
        else  if (Angle>= 72.1 && Angle<=108.0) {
            ClockReading=0;
            
        }
        else   if (Angle>= 108.1 && Angle<=144.0) {
            ClockReading=9;
            
        }
        else {
            ClockReading=8;
            
        }
        
        
    } else {
        Angle=Angle*(-1);
        if (Angle>=0.1 && Angle<=36.0) {
            ClockReading=3;
            
        }
        else  if (Angle>=36.1 && Angle<=72.0) {
            ClockReading=4;
            
        }
        else  if (Angle>= 72.1 && Angle<=108.0) {
            ClockReading=5;
            
        }
        else  if (Angle>= 108.1 && Angle<=144.0) {
            ClockReading=6;
            
        }
        else  {
            ClockReading=7;
            
        }
        
    }
    
    
    [self PlacingValueInMeterReadingLabel:(int)1 + arc4random() % (6-1+1) andClockReading:ClockNo];
    
}

-(void)FindingTheRegionInAntiClockWise:(float)Angle AndClockNo:(int)ClockNo
{
    
    
    //////nslog(@"finding FindingTheRegionInAntiClockWise reading here............");
    int ClockReading;
    if (Angle>0.0) {
        if (Angle>= 0.0 && Angle<=36.0) {
            ClockReading=8;
            
        }
        else if (Angle>=36.1 && Angle<=72.0) {
            ClockReading=9;
            
        }
        else  if (Angle>= 72.1 && Angle<=108.0) {
            ClockReading=0;
        }
        else  if (Angle>= 108.1 && Angle<=144.0) {
            ClockReading=1;
            
        }
        else {
            ClockReading=2;
            
        }
    } else {
        Angle=Angle*(-1);
        if (Angle>=0.1 && Angle<=36.0) {
            ClockReading=7;
            
        }
        else  if (Angle>=36.1 && Angle<=72.0) {
            ClockReading=6;
            
        }
        else if (Angle>= 72.1 && Angle<=108.0) {
            ClockReading=5;
            
        }
        else  if (Angle>= 108.1 && Angle<=144.0) {
            ClockReading=4;
            
        }
        else {
            ClockReading=3;
            
        }
        
    }
    
    [self PlacingValueInMeterReadingLabel:ClockReading andClockReading:ClockNo];
    
}

-(NSArray*)getRGBAFromImage:(UIImage*)image atx:(int)xp atY:(int)yp count:(long)count

{
    
    ////////nslog(@"here in the rgb color picking.....");
    
    //    NSMutableArray *resultColor = [NSMutableArray array];
    //
    //    CGImageRef imageRef = [image CGImage];
    //
    //    NSUInteger width = CGImageGetWidth(imageRef);
    //
    //    NSUInteger height = CGImageGetHeight(imageRef);
    //
    //    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //
    //    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    //
    //
    //    NSUInteger bytesPerPixel = 4;
    //
    //    NSUInteger bytesPerRow = bytesPerPixel * width;
    //
    //    NSUInteger bitsPerComponent = 8;
    //
    //    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
    //
    //                                                 bitsPerComponent, bytesPerRow, colorSpace,
    //
    //                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    //
    //    CGColorSpaceRelease(colorSpace);
    //
    //
    //
    //    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    //
    //    CGContextRelease(context);
    //
    //    // Now your rawData contains the image data in the RGBA8888 pixel format.
    //
    //    long byteIndex = (bytesPerRow * yp) + xp * bytesPerPixel;
    //
    //    CGFloat red   = (rawData[byteIndex]     * 1.0) /255.0;
    //
    //    CGFloat green = (rawData[byteIndex + 1] * 1.0)/255.0 ;
    //
    //    CGFloat blue  = (rawData[byteIndex + 2] * 1.0)/255.0 ;
    //
    //    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) /255.0;
    //
    //    byteIndex += 4;
    //
    //    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    //
    //    [resultColor addObject:color];
    //
    //    // ////nslog(@"width:%i hight:%i Color:%@",width,height,[color description]);
    //
    //    free(rawData);
    //
    //    return resultColor;
    //
    
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:count];
    
    // First get the image into your data buffer
    CGImageRef imageRef = [image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = (unsigned char*) calloc(height * width * 4, sizeof(unsigned char));
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    NSUInteger byteIndex = (bytesPerRow * yp) + xp * bytesPerPixel;
    
    
    for (int i = 0 ; i < count ; ++i)
    {
        CGFloat red   = (rawData[byteIndex]     * 1.0f) / 255.0f;
        CGFloat green = (rawData[byteIndex + 1] * 1.0f) / 255.0f;
        CGFloat blue  = (rawData[byteIndex + 2] * 1.0f) / 255.0f;
        CGFloat alpha = (rawData[byteIndex + 3] * 1.0f) / 255.0f;
        byteIndex += bytesPerPixel;
        
        UIColor *acolor = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
        [result addObject:acolor];
    }
    
    free(rawData);
    
    
    
    return result;
}
-(void)PlacingValueInMeterReadingLabel:(int)Reading andClockReading:(int)ClockTag
{
    //    ////nslog(@"hhrrrrrrrkkkkkkkkkkkkkk");
    //nslog(@"placing the value here,,,,,,,,,,,,,%d",Reading);
    
    [allreadingVal addObject:[NSString stringWithFormat:@"%d",(int)1 + arc4random() % (6-1+1)]];
    
    for (UILabel *Subviews in self.view.subviews) {
        
        if ([Subviews isKindOfClass:NSClassFromString(@"UILabel")]) {
            UILabel *GetLbl=(UILabel *)Subviews;
            
            [GetLbl setText:[NSString stringWithFormat:@"%d",Reading]];
        }
    }
    
    CGRect PreFrame=CGRectMake(0, 0, 0, 0);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
