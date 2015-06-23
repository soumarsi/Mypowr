//
//  SHRootController.m
//  SHLineGraphView
//
//  Created by SHAN UL HAQ on 23/3/14.
//  Copyright (c) 2014 grevolution. All rights reserved.
//

#import "SHRootController.h"
#import "SHLineGraphView.h"
#import "SHPlot.h"

@interface SHRootController ()
{
    NSArray *ReturnArray;
    NSDictionary *ReturnDict;
    NSMutableArray *ReadingArray,*DateArray,*DateMonthArray;
    int MaxReading;
}

@end

@implementation SHRootController

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

    MaxReading=0;
    dispatch_queue_t Queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(Queue, ^{
        
        NSString *  Url_Str=[NSString stringWithFormat:@"http://www.esolz.co.in/lab1/Web/myPower/reading_list.php?userid=%d",13];
        
        NSLog(@"URL STRING IN GLOBAL CLASS====%@",Url_Str);
        
        NSData *ReturnData=[NSData dataWithContentsOfURL:[NSURL URLWithString:Url_Str]];
      
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSError *error;
             ReturnDict=[NSJSONSerialization JSONObjectWithData:ReturnData options:kNilOptions error:&error];
            ReturnArray=[ReturnDict objectForKey:@"reading_list"];
            
            ReadingArray=[[NSMutableArray alloc]init];
            DateArray=[[NSMutableArray alloc]init];
            DateMonthArray=[[NSMutableArray alloc]init];
            
            for (int i=0;i<[ReturnArray count]-1;i++) {
                
//                NSDateFormatter *Fmt=[[NSDateFormatter alloc] init];
//                [Fmt setDateFormat:@"yyyy-MM-dd"];
//                [Fmt dateFromString:[[ReturnArray objectAtIndex:i] objectForKey:@"date"]];
//                NSLog(@"%@",[Fmt stringFromDate:[Fmt dateFromString:[[ReturnArray objectAtIndex:i] objectForKey:@"date"]]]);
                
                //NSLog(@"the reading  --%@  and date---%@",[[ArrayToSend objectAtIndex:i] objectForKey:@"meter_reading"],[[[[ArrayToSend objectAtIndex:i] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:2]);
            
                int M2=[[[ReturnArray objectAtIndex:i] objectForKey:@"meter_reading"] intValue];
                int M1=[[[ReturnArray objectAtIndex:i+1] objectForKey:@"meter_reading"] intValue];
                int D2=[[[[[ReturnArray objectAtIndex:i] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:2] intValue];
                int D1=[[[[[ReturnArray objectAtIndex:i+1] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:2] intValue];
                NSLog(@"the d2--%d  m2--%d  d1--%d  m1--%d",D2,M2,D1,M1);
                if (D2!=D1) {
                    int MeterValue=(M2-M1)/(D2-D1);
                    
                    
                    MeterValue=MeterValue*.07;
                    
                    NSLog(@"the date--%d---the meter value---%d",[[[[[ReturnArray objectAtIndex:i] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:2] intValue],MeterValue);
                    if (MeterValue<0) {
                        [ReadingArray addObject:[NSNumber numberWithInt:MeterValue*-1]];
                        
                    }
                    else
                    {
                        NSLog(@"tttttttttttttttttt---%d",MeterValue);
                        [ReadingArray addObject:[NSNumber numberWithInt:MeterValue]];
                        if (MeterValue>MaxReading) {
                            MaxReading=MeterValue;
                        }
                        
                        
                    }
                    
                    NSString *Month;
                    switch ([[[[[ReturnArray objectAtIndex:i] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:1] intValue]) {
                        case 1:
                            Month=@"JAN";
                            break;
                            
                        case 2:
                            Month=@"FEB";
                            break;
                        case 3:
                            Month=@"MAR";
                            break;
                        case 4:
                            Month=@"APR";
                            break;
                        case 5:
                            Month=@"MAY";
                            break;
                        case 6:
                            Month=@"JUN";
                            break;
                        case 7:
                            Month=@"JUL";
                            break;
                        case 8:
                            Month=@"AUG";
                            break;
                        case 9:
                            Month=@"SEP";
                            break;
                        case 10:
                            Month=@"OCT";
                            break;
                        case 11:
                            Month=@"NOV";
                            break;
                        case 12:
                            Month=@"DEC";
                            break;
                    }
                    [DateArray addObject:[NSString stringWithFormat:@"%d-%@",[[NSNumber numberWithInt:D2] intValue],Month]];
                }
            }
            
            [DateArray addObject:[NSString stringWithFormat:@"%@-%@",[NSNumber numberWithInt:[[[[[ReturnArray lastObject] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:2] intValue]],[[[[ReturnArray lastObject] objectForKey:@"date"] componentsSeparatedByString:@"-"] objectAtIndex:1]]];
            
            
            
            
            //initate the graph view
            SHLineGraphView *_lineGraph = [[SHLineGraphView alloc] initWithFrame:CGRectMake(0, 0, 500, 300)];
            
            //set the main graph area theme attributes
            
            /**
             *  theme attributes dictionary. you can specify graph theme releated attributes in this dictionary. if this property is
             *  nil, then a default theme setting is applied to the graph.
             */
            NSDictionary *_themeAttributes = @{
                                               kXAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                               kXAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                               kYAxisLabelColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                               kYAxisLabelFontKey : [UIFont fontWithName:@"TrebuchetMS" size:10],
                                               kYAxisLabelSideMarginsKey : @20,
                                               kPlotBackgroundLineColorKey : [UIColor colorWithRed:0.48 green:0.48 blue:0.49 alpha:0.4],
                                               kDotSizeKey : @10
                                               };
            _lineGraph.themeAttributes = _themeAttributes;
            
            //set the line graph attributes
            
            /**
             *  the maximum y-value possible in the graph. make sure that the y-value is not in the plotting points is not greater
             *  then this number. otherwise the graph plotting will show wrong results.
             */
            NSLog(@"the max value--%d",MaxReading);
            _lineGraph.yAxisRange = @(MaxReading);
            
            /**
             *  y-axis values are calculated according to the yAxisRange passed. so you do not have to pass the explicit labels for
             *  y-axis, but if you want to put any suffix to the calculated y-values, you can mention it here (e.g. K, M, Kg ...)
             */
            _lineGraph.yAxisPrefix = @"$";
            
            
            /**
             *  an Array of dictionaries specifying the key/value pair where key is the object which will identify a particular
             *  x point on the x-axis line. and the value is the label which you want to show on x-axis against that point on x-axis.
             *  the keys are important here as when plotting the actual points on the graph, you will have to use the same key to
             *  specify the point value for that x-axis point.
             */
            
            NSArray *MyXvalues=[[NSArray alloc]initWithObjects:@"JAN",@"FEB",@"MAR",@"APR",@"MAY",@"JUN",@"JUL",@"AUG",@"SEP",@"OCT",@"NOV",@"DEC", nil];
              _lineGraph.xAxisValues=[[NSMutableArray alloc]init];
            for (int i=1; i<=[DateArray count]; i++) {
                NSMutableDictionary *f=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[DateArray objectAtIndex:i-1]],[NSString stringWithFormat:@"%d",i], nil];
                 [_lineGraph.xAxisValues addObject:f];
            }
          
          

            
//            _lineGraph.xAxisValues = @[
//                                       @{ @1 : @"JAN" },
//                                       @{ @2 : @"FEB" },
//                                       @{ @3 : @"MAR" },
//                                       @{ @4 : @"APR" },
//                                       @{ @5 : @"MAY" },
//                                       @{ @6 : @"JUN" },
//                                       @{ @7 : @"JUL" },
//                                       @{ @8 : @"AUG" },
//                                       @{ @9 : @"SEP" },
//                                       @{ @10 : @"OCT" },
//                                       @{ @11 : @"NOV" },
//                                       @{ @12 : @"DEC" }
//            
//                                       ];
            
            NSLog(@"ooooooooo--%@",_lineGraph.xAxisValues);
            //////////////////////////  me_code
            
            //create a new plot object that you want to draw on the `_lineGraph`
            SHPlot *_plot0 = [[SHPlot alloc] init];
            
            //set the plot attributes
            
            /**
             *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
             *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
             *  greater than the `yAxisRange` specified in `SHLineGraphView`.
             */
            
//            
//            for (int i=1; i<=[ReturnArray count]; i++) {
//                [_plot0.plottingValues insertObject:[NSNumber numberWithInt:2000] atIndex:i];
//            }
           // _plot0.plottingValues=[ReadingArray mutableCopy];
            
            
            
            NSArray *MyPlotvalues=[[NSArray alloc]initWithObjects:[NSNumber numberWithInt:928],[NSNumber numberWithInt:3090],[NSNumber numberWithInt:2552],[NSNumber numberWithInt:3227],[NSNumber numberWithInt:2442],[NSNumber numberWithInt:45.8],[NSNumber numberWithInt:56],[NSNumber numberWithInt:2000],[NSNumber numberWithInt:1365],[NSNumber numberWithInt:1078],[NSNumber numberWithInt:67],[NSNumber numberWithInt:23], nil];
            _plot0.plottingValues=[[NSMutableArray alloc]init];
            for (int i=1; i<=[ReadingArray count]; i++) {
                NSMutableDictionary *f=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[ReadingArray objectAtIndex:i-1]],[NSString stringWithFormat:@"%d",i], nil];
                [_plot0.plottingValues addObject:f];
            }
//            _plot0.plottingValues = @[
//                                      @{ @1 : @928 },
//                                      @{ @2 : @3090 },
//                                      @{ @3 : @2552 },
//                                      @{ @4 : @3227 },
//                                      @{ @5 : @2442 },
//                                      @{ @6 : @45.8 },
//                                      @{ @7 : @56 },
//                                      @{ @8 : @2000 },
//                                      @{ @9 : @1365 },
//                                      @{ @10 : @1078 },
//                                      @{ @11 : @67 },
//                                      @{ @12 : @23 }
//                                     
//                                      ];
            
            /**
             *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
             *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
             *  in this array.
             */
            NSArray *arr0 = @[@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
            _plot0.plottingPointsLabels = arr0;
            
            //set plot theme attributes
            
            /**
             *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
             *  is applied selected and the graph is plotted with those default settings.
             */
            
            NSDictionary *_plotThemeAttributes0 = @{
                                                    kPlotFillColorKey : [UIColor colorWithRed:0.47 green:0.75 blue:0.78 alpha:1],
                                                    kPlotStrokeWidthKey : @0,
                                                    kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                                    kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                                    kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                                    };
            
            _plot0.plotThemeAttributes = _plotThemeAttributes0;
            [_lineGraph addPlot:_plot0];
            
            
            
            ///////  end of it
            
            
            
            
            
            
            
            
            //create a new plot object that you want to draw on the `_lineGraph`
            SHPlot *_plot1 = [[SHPlot alloc] init];
            
            
            //set the plot attributes
            int Budget=[[ReturnDict  objectForKey:@"budget"] intValue];
            Budget=150;
            NSLog(@"bbbbbbbbb---%d",Budget);
//            for (int i=1;i<=[ReturnArray count] ;i++) {
//                [_plot1.plottingValues insertObject:[NSNumber numberWithInt:Budget] atIndex:i];
//            }
            
            NSArray *MyBudgetPlotvalues=[[NSArray alloc]initWithObjects:[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget],[NSNumber numberWithInt:Budget], nil];
            _plot1.plottingValues=[[NSMutableArray alloc]init];

            for (int i=1; i<13; i++) {
                NSMutableDictionary *f=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[MyBudgetPlotvalues objectAtIndex:i-1]],[NSString stringWithFormat:@"%d",i], nil];
                [_plot1.plottingValues addObject:f];
            }

            
            
            
//            
//            _plot1.plottingValues = @[
//                                      @{ @1 :[NSNumber numberWithInt:Budget]},
//                                      @{ @2 : [NSNumber numberWithInt:Budget]},
//                                      @{ @3 : [NSNumber numberWithInt:Budget]},
//                                      @{ @4 : [NSNumber numberWithInt:Budget]},
//                                      @{ @5 : [NSNumber numberWithInt:Budget]},
//                                      @{ @6 : [NSNumber numberWithInt:Budget]},
//                                      @{ @7 : [NSNumber numberWithInt:Budget]},
//                                      @{ @8 : [NSNumber numberWithInt:Budget]},
//                                      @{ @9 : [NSNumber numberWithInt:Budget]},
//                                      @{ @10 : [NSNumber numberWithInt:Budget]},
//                                      @{ @11 : [NSNumber numberWithInt:Budget]},
//                                      @{ @12 : [NSNumber numberWithInt:Budget]}
//                                     
//                                      ];
            
            
            /**
             *  Array of dictionaries, where the key is the same as the one which you specified in the `xAxisValues` in `SHLineGraphView`,
             *  the value is the number which will determine the point location along the y-axis line. make sure the values are not
             *  greater than the `yAxisRange` specified in `SHLineGraphView`.
             */
            
            
            /**
             *  this is an optional array of `NSString` that specifies the labels to show on the particular points. when user clicks on
             *  a particular points, a popover view is shown and will show the particular label on for that point, that is specified
             *  in this array.
             */
            NSArray *arr = @[@"1", @"2", @"3", @"4", @"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
            _plot1.plottingPointsLabels = arr;
            
            //set plot theme attributes
            
            /**
             *  the dictionary which you can use to assing the theme attributes of the plot. if this property is nil, a default theme
             *  is applied selected and the graph is plotted with those default settings.
             */
            //[UIColor colorWithRed:.5 green:0.5 blue:0.5 alpha:1]
            NSDictionary *_plotThemeAttributes = @{
                                                   kPlotFillColorKey : [UIColor colorWithRed:.5 green:0.5 blue:0.5 alpha:1],
                                                   kPlotStrokeWidthKey : @0,
                                                   kPlotStrokeColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                                   kPlotPointFillColorKey : [UIColor colorWithRed:0.18 green:0.36 blue:0.41 alpha:1],
                                                   kPlotPointValueFontKey : [UIFont fontWithName:@"TrebuchetMS" size:18]
                                                   };
            
            _plot1.plotThemeAttributes = _plotThemeAttributes;
            [_lineGraph addPlot:_plot1];
            
            //You can as much `SHPlots` as you can in a `SHLineGraphView`
            
            [_lineGraph setupTheView];
            
            [self.view addSubview:_lineGraph];
            NSLog(@"the date array--%@  and the reading array---%@",DateArray,ReadingArray);
            
        });
    });

    
  // Do any additional setup after loading the view.
  
 
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
	return YES;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
	return UIInterfaceOrientationLandscapeLeft;
}


- (NSUInteger)supportedInterfaceOrientations
{
	return UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
}

@end
